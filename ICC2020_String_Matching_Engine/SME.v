module SME(clk,reset,chardata,isstring,ispattern,valid,match,match_index);
    input clk;
    input reset;
    input [7:0] chardata;
    input isstring;
    input ispattern;
    output match;
    output [4:0] match_index;
    output valid;
    
    localparam S_IDLE = 0;
    localparam S_STR = 1;
    localparam S_PAT = 2;
    localparam S_MATCH = 3;
    localparam S_MATCH_FINAL = 4;
    localparam S_OUT = 5;

    reg [2:0] state_r, state_w;
    reg [7:0] string_r[0:31], string_w[0:31];
    reg [7:0] pattern_r[0:7], pattern_w[0:7];
    reg [4:0] count_str_r, count_str_w;
    reg [2:0] count_pat_r, count_pat_w;
    reg [4:0] match_index_r, match_index_w;
    reg [2:0] split_pos_r, split_pos_w;
    reg match_r, match_w;


    reg [255:0] string_array;
    reg [63:0]  pattern_array;
    reg mode;
    wire [31:0] clz;
    wire [4:0] index;
    wire match_or_not;
    wire add_1_for_h5E;

    wire is_star_specialcase;
    assign is_star_specialcase = (pattern_r[split_pos_r] == 8'h2a) ? 1 : 0;

    wire is_latter_overlap_former;
    assign is_latter_overlap_former = ( $signed({1'b0, index}) - $signed({1'b0, match_index_r}) ) < $signed({1'b0, split_pos_r});

    assign match_index = match_index_r;
    assign match = match_r;
    assign valid = (state_r==S_OUT);

    integer i, j;
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            state_r <= S_IDLE;
            
            for(i=0; i<=31; i=i+1) begin
                string_r[i] <= 0;
            end

            for(j=0; j<=7; j=j+1) begin
                pattern_r[j] <= 0;
            end

            count_str_r <= 0;
            count_pat_r <= 0;
            match_index_r <= 0;
            split_pos_r <= 0;
            match_r <= 0;
        end
        else begin
            state_r <= state_w;
            
            for(i=0; i<=31; i=i+1) begin
                string_r[i] <= string_w[i];
            end

            for(j=0; j<=7; j=j+1) begin
                pattern_r[j] <= pattern_w[j];
            end

            count_str_r <= count_str_w;
            count_pat_r <= count_pat_w;
            match_index_r <= match_index_w;
            split_pos_r <= split_pos_w;
            match_r <= match_w;
        end
    end

    always@(*) begin
        case(state_r)
            S_IDLE: state_w = (isstring) ? S_STR : (ispattern) ? S_PAT : S_IDLE;
            S_STR:  state_w = (ispattern) ? S_PAT : S_STR;
            S_PAT:  state_w = (!ispattern && is_star_specialcase) ? S_MATCH : (ispattern) ? S_PAT : S_MATCH_FINAL; 
            S_MATCH: state_w = (match_or_not) ? S_MATCH_FINAL : S_OUT;
            S_MATCH_FINAL: state_w = S_OUT;
            S_OUT: state_w = (isstring) ? S_STR : (ispattern) ? S_PAT : S_IDLE;
            default: state_w = S_IDLE;
        endcase
    end

    always@(*) begin
        if(isstring) count_str_w = count_str_r + 1;
        else if(state_r == S_MATCH_FINAL  || (state_r == S_MATCH && (!match_or_not)) ) count_str_w = 0;
        else count_str_w = count_str_r;
    end

    always@(*) begin
        if(ispattern) count_pat_w = count_pat_r + 1;
        else if( state_r == S_MATCH_FINAL || (state_r == S_MATCH && (!match_or_not)) ) count_pat_w = 0;
        else count_pat_w = count_pat_r;
    end
    
    always@(*) begin
        if(chardata == 8'h2A && ispattern) split_pos_w = count_pat_r;
        else if(state_r == S_MATCH_FINAL) split_pos_w = 0;
        else split_pos_w = split_pos_r;
    end

    integer p;
    always@(*) begin
        if(state_r == S_OUT && isstring) begin
            string_w[0] = chardata;
            
            for(p=1; p<=31; p=p+1) begin
                string_w[p] = 0;
            end
        end
        else begin
            for(p=0; p<=31; p=p+1) begin
                string_w[p] = string_r[p];
            end

            if(isstring) begin
                string_w[count_str_r] = chardata;
            end
        end
    end

    integer q;
    always@(*) begin
        if(state_r == S_MATCH_FINAL) begin
            for(q=0; q<=7; q=q+1) begin
                pattern_w[q] = 0;
            end
        end
        else begin
            for(q=0; q<=7; q=q+1) begin
                pattern_w[q] = pattern_r[q];
            end

            if(ispattern) begin
                pattern_w[count_pat_r] = chardata;
            end
        end
    end

    Comparator Comparator(.string_array(string_array), .pattern_array(pattern_array), .clz(clz), .add_1_for_h5E(add_1_for_h5E));
    Count_leading_zeros CLZ(.mode(mode), .clz(clz), .index(index), .match_or_not(match_or_not), .add_1_for_h5E(add_1_for_h5E));

    always@(*) begin
        mode = is_star_specialcase && (state_r==S_MATCH_FINAL);
    end

    always@(*) begin
        string_array = { string_r[31], string_r[30], string_r[29], string_r[28], string_r[27], 
                         string_r[26], string_r[25], string_r[24], string_r[23], string_r[22], 
                         string_r[21], string_r[20], string_r[19], string_r[18], string_r[17], 
                         string_r[16], string_r[15], string_r[14], string_r[13], string_r[12], 
                         string_r[11], string_r[10], string_r[9],  string_r[8],  string_r[7], 
                         string_r[6],  string_r[5],  string_r[4],  string_r[3],  string_r[2], 
                         string_r[1],  string_r[0] };
    end

    always@(*) begin
        if(is_star_specialcase) begin
            if(state_r == S_MATCH) begin
                case(split_pos_r)
                    3'd7: pattern_array = { 8'd0, pattern_r[6], pattern_r[5], pattern_r[4], 
                                  pattern_r[3], pattern_r[2], pattern_r[1], pattern_r[0] };
                    3'd6: pattern_array = { 16'd0, pattern_r[5], pattern_r[4], 
                                  pattern_r[3], pattern_r[2], pattern_r[1], pattern_r[0] };
                    3'd5: pattern_array = { 24'd0, pattern_r[4], 
                                  pattern_r[3], pattern_r[2], pattern_r[1], pattern_r[0] };
                    3'd4: pattern_array = { 32'd0, 
                                  pattern_r[3], pattern_r[2], pattern_r[1], pattern_r[0] };
                    3'd3: pattern_array = { 40'd0, pattern_r[2], pattern_r[1], pattern_r[0] };
                    3'd2: pattern_array = { 48'd0, pattern_r[1], pattern_r[0] };
                    3'd1: pattern_array = { 56'd0, pattern_r[0] };
                    3'd0: pattern_array = { 64'd0 };
                endcase
            end
            else begin
                case(split_pos_r)
                    3'd0: pattern_array = { 8'd0, pattern_r[7], pattern_r[6], pattern_r[5], pattern_r[4], 
                                  pattern_r[3], pattern_r[2], pattern_r[1]};
                    3'd1: pattern_array = { 16'd0, pattern_r[7], pattern_r[6], pattern_r[5], pattern_r[4], pattern_r[3], pattern_r[2] };
                    3'd2: pattern_array = { 24'd0, pattern_r[7], pattern_r[6], pattern_r[5], pattern_r[4], pattern_r[3] };
                    3'd3: pattern_array = { 32'd0, pattern_r[7], pattern_r[6], pattern_r[5], pattern_r[4] };
                    3'd4: pattern_array = { 40'd0, pattern_r[7], pattern_r[6], pattern_r[5] };
                    3'd5: pattern_array = { 48'd0, pattern_r[7], pattern_r[6] };
                    3'd6: pattern_array = { 56'd0, pattern_r[7] };
                    3'd7: pattern_array = { 64'd0 };
                endcase
            end
        end
        else begin
            pattern_array = { pattern_r[7], pattern_r[6], pattern_r[5], pattern_r[4], 
                              pattern_r[3], pattern_r[2], pattern_r[1], pattern_r[0] };
        end
    end

    always@(*) begin
        if(state_r == S_MATCH_FINAL) begin
            match_w = (is_star_specialcase && is_latter_overlap_former) ? 0 : match_or_not;
        end
        else if(state_r == S_MATCH) begin
            match_w = match_or_not;
        end
        else begin
            match_w = match_r;
        end
    end

    always@(*) begin
        if(state_r == S_MATCH) begin
            match_index_w = index;
        end
        else if(state_r == S_MATCH_FINAL) begin
            if(is_star_specialcase) begin
                match_index_w = match_index_r;
            end
            else begin
                match_index_w = index;
            end
        end
        else begin
            match_index_w = match_index_r;
        end
    end

endmodule


module Comparator(
    input [255:0] string_array,
    input [63:0]  pattern_array,
    output reg [31:0] clz,
    output add_1_for_h5E
);
    reg [63:0] str[0:31];
    reg [311:0] temp;
    reg [7:0] match [0:31];

    integer i;
    always@(*) begin
        temp = {56'd0 , string_array};

        for(i=0; i<=31; i=i+1) begin
            str[i] = temp[i*8 +: 64];
        end
    end

    integer j;
    always@(*) begin
        for(j=0; j<=31; j=j+1) begin
            match[j][0] = ( (pattern_array[0 +: 8] == str[j][0 +: 8]) ||
                            (pattern_array[0 +: 8] == 0) ||
                            (pattern_array[0 +: 8] == 8'h2E) ||
                            (pattern_array[0 +: 8] == 8'h24 && str[j][0 +: 8] == 8'h20) ||
                            (pattern_array[0 +: 8] == 8'h24 && str[j][0 +: 8] == 0) ||
                            (pattern_array[0 +: 8] == 8'h5E && str[j][0 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][1] = ( (pattern_array[8 +: 8] == str[j][8 +: 8]) ||
                            (pattern_array[8 +: 8] == 0) ||
                            (pattern_array[8 +: 8] == 8'h2E) ||
                            (pattern_array[8 +: 8] == 8'h24 && str[j][8 +: 8] == 8'h20) ||
                            (pattern_array[8 +: 8] == 8'h24 && str[j][8 +: 8] == 0) ||
                            (pattern_array[8 +: 8] == 8'h5E && str[j][8 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][2] = ( (pattern_array[16 +: 8] == str[j][16 +: 8]) ||
                            (pattern_array[16 +: 8] == 0) ||
                            (pattern_array[16 +: 8] == 8'h2E) ||
                            (pattern_array[16 +: 8] == 8'h24 && str[j][16 +: 8] == 8'h20) ||
                            (pattern_array[16 +: 8] == 8'h24 && str[j][16 +: 8] == 0) ||
                            (pattern_array[16 +: 8] == 8'h5E && str[j][16 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][3] = ( (pattern_array[24+: 8] == str[j][24+: 8]) ||
                            (pattern_array[24+: 8] == 0) ||
                            (pattern_array[24+: 8] == 8'h2E) ||
                            (pattern_array[24+: 8] == 8'h24 && str[j][24+: 8] == 8'h20) ||
                            (pattern_array[24+: 8] == 8'h24 && str[j][24+: 8] == 0) ||
                            (pattern_array[24+: 8] == 8'h5E && str[j][24+: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][4] = ( (pattern_array[32 +: 8] == str[j][32 +: 8]) ||
                            (pattern_array[32 +: 8] == 0) ||
                            (pattern_array[32 +: 8] == 8'h2E) ||
                            (pattern_array[32 +: 8] == 8'h24 && str[j][32 +: 8] == 8'h20) ||
                            (pattern_array[32 +: 8] == 8'h24 && str[j][32 +: 8] == 0) ||
                            (pattern_array[32 +: 8] == 8'h5E && str[j][32 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][5] = ( (pattern_array[40 +: 8] == str[j][40 +: 8]) ||
                            (pattern_array[40 +: 8] == 0) ||
                            (pattern_array[40 +: 8] == 8'h2E) ||
                            (pattern_array[40 +: 8] == 8'h24 && str[j][40 +: 8] == 8'h20) ||
                            (pattern_array[40 +: 8] == 8'h24 && str[j][40 +: 8] == 0) ||
                            (pattern_array[40 +: 8] == 8'h5E && str[j][40 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][6] = ( (pattern_array[48 +: 8] == str[j][48 +: 8]) ||
                            (pattern_array[48 +: 8] == 0) ||
                            (pattern_array[48 +: 8] == 8'h2E) ||
                            (pattern_array[48 +: 8] == 8'h24 && str[j][48 +: 8] == 8'h20) ||
                            (pattern_array[48 +: 8] == 8'h24 && str[j][48 +: 8] == 0) ||
                            (pattern_array[48 +: 8] == 8'h5E && str[j][48 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[j][7] = ( (pattern_array[56 +: 8] == str[j][56 +: 8]) ||
                            (pattern_array[56 +: 8] == 0) ||
                            (pattern_array[56 +: 8] == 8'h2E) ||
                            (pattern_array[56 +: 8] == 8'h24 && str[j][56 +: 8] == 8'h20) ||
                            (pattern_array[56 +: 8] == 8'h24 && str[j][56 +: 8] == 0) ||
                            (pattern_array[56 +: 8] == 8'h5E && str[j][56 +: 8] == 8'h20)
            ) ? 1 : 0;
        end

        if(pattern_array[0 +: 8] == 8'h5E) begin
            match[0][0] = ( (pattern_array[8 +: 8] == str[0][0 +: 8]) ||
                            (pattern_array[8 +: 8] == 0) ||
                            (pattern_array[8 +: 8] == 8'h2E) ||
                            (pattern_array[8 +: 8] == 8'h24 && str[0][0 +: 8] == 8'h20) ||
                            (pattern_array[8 +: 8] == 8'h24 && str[0][0 +: 8] == 0)     ||
                            (pattern_array[8 +: 8] == 8'h5E && str[0][0 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][1] = ( (pattern_array[16 +: 8] == str[0][8 +: 8]) ||
                            (pattern_array[16 +: 8] == 0) ||
                            (pattern_array[16 +: 8] == 8'h2E) ||
                            (pattern_array[16 +: 8] == 8'h24 && str[0][8 +: 8] == 8'h20) ||
                            (pattern_array[16 +: 8] == 8'h24 && str[0][8 +: 8] == 0)     ||
                            (pattern_array[16 +: 8] == 8'h5E && str[0][8 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][2] = ( (pattern_array[24+: 8] == str[0][16+: 8]) ||
                            (pattern_array[24+: 8] == 0) ||
                            (pattern_array[24+: 8] == 8'h2E) ||
                            (pattern_array[24+: 8] == 8'h24 && str[0][16+: 8] == 8'h20) ||
                            (pattern_array[24+: 8] == 8'h24 && str[0][16+: 8] == 0)     ||
                            (pattern_array[24+: 8] == 8'h5E && str[0][16+: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][3] = ( (pattern_array[32 +: 8] == str[0][24 +: 8]) ||
                            (pattern_array[32 +: 8] == 0) ||
                            (pattern_array[32 +: 8] == 8'h2E) ||
                            (pattern_array[32 +: 8] == 8'h24 && str[0][24 +: 8] == 8'h20) ||
                            (pattern_array[32 +: 8] == 8'h24 && str[0][24 +: 8] == 0)     ||
                            (pattern_array[32 +: 8] == 8'h5E && str[0][24 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][4] = ( (pattern_array[40 +: 8] == str[0][32 +: 8]) ||
                            (pattern_array[40 +: 8] == 0) ||
                            (pattern_array[40 +: 8] == 8'h2E) ||
                            (pattern_array[40 +: 8] == 8'h24 && str[0][32 +: 8] == 8'h20) ||
                            (pattern_array[40 +: 8] == 8'h24 && str[0][32 +: 8] == 0)     ||
                            (pattern_array[40 +: 8] == 8'h5E && str[0][32 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][5] = ( (pattern_array[48 +: 8] == str[0][40 +: 8]) ||
                            (pattern_array[48 +: 8] == 0) ||
                            (pattern_array[48 +: 8] == 8'h2E) ||
                            (pattern_array[48 +: 8] == 8'h24 && str[0][40 +: 8] == 8'h20) ||
                            (pattern_array[48 +: 8] == 8'h24 && str[0][40 +: 8] == 0)     ||
                            (pattern_array[48 +: 8] == 8'h5E && str[0][40 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][6] = ( (pattern_array[56 +: 8] == str[0][48 +: 8]) ||
                            (pattern_array[56 +: 8] == 0) ||
                            (pattern_array[56 +: 8] == 8'h2E) ||
                            (pattern_array[56 +: 8] == 8'h24 && str[0][48 +: 8] == 8'h20) ||
                            (pattern_array[56 +: 8] == 8'h24 && str[0][48 +: 8] == 0)     ||
                            (pattern_array[56 +: 8] == 8'h5E && str[0][48 +: 8] == 8'h20)
            ) ? 1 : 0;

            match[0][7] = 1;
        end
    end

    integer k;
    always@(*) begin
        for(k=0; k<=31; k=k+1) begin
            clz[k] = &match[k];
        end
    end

    assign add_1_for_h5E = (!clz[0]) && (pattern_array[0 +: 8] == 8'h5E);

    /*
        if clz = 00...01000
            means in the 3rd position it matches
        if clz = 00...00001
            means in the 0th position it matches
        if clz = 001...0001
            means in the 0th and 29th position it matches
    */

endmodule

module Count_leading_zeros(
    input mode,
    input add_1_for_h5E,
    input [31:0] clz,
    output reg [4:0] index,
    output match_or_not
);
    assign match_or_not = |clz;

    reg [4:0] result;
    reg [15:0] val16, val16_rev;
    reg [7:0]  val8, val8_rev;
    reg [3:0]  val4, val4_rev;
    reg [31:0] data;

    integer i;
    always@ (*) begin
        if(!mode) begin
            for(i=0; i<=31; i=i+1) begin
                data[i] = clz[31-i];
            end
        end
        else begin
            data = clz;
        end
    end

    always@(*) begin
        result[4] = (data[31:16] == 16'b0);
        val16     = result[4] ? data[15:0] : data[31:16];
        result[3] = (val16[15:8] == 8'b0);
        val8      = result[3] ? val16[7:0] : val16[15:8];
        result[2] = (val8[7:4] == 4'b0);
        val4      = result[2] ? val8[3:0] : val8[7:4];
        result[1] = (val4[3:2] == 2'b0);
        result[0] = result[1] ? ~val4[1] : ~val4[3];
    end

    always@(*) begin
        if(!match_or_not) begin
            index = 0;
        end
        else if(mode) begin
            index = 5'd31 - result;
        end
        else begin
            index = result + add_1_for_h5E;
        end
    end
 
endmodule
