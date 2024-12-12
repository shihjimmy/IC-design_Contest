module huffman(clk, reset, gray_valid, gray_data,  CNT_valid, CNT1, CNT2, CNT3, CNT4, CNT5, CNT6,
    code_valid, HC1, HC2, HC3, HC4, HC5, HC6, M1, M2, M3, M4, M5, M6);

    input clk;
    input reset;
    input gray_valid;
    input [7:0] gray_data;
    output CNT_valid;
    output [7:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
    output code_valid;
    output reg [7:0] HC1, HC2, HC3, HC4, HC5, HC6;
    output reg [7:0] M1, M2, M3, M4, M5, M6;

    localparam S_IDLE = 0;
    localparam S_CNT = 1;
    localparam S_SORT1 = 2;
    localparam S_SORT2 = 3;
    localparam S_SORT3 = 4;
    localparam S_SORT4 = 5;
    localparam S_SORT5 = 6;
    localparam S_SORT6 = 7;
    localparam S_COMB1 = 8;
    localparam S_COMB2 = 9;
    localparam S_COMB3 = 10;
    localparam S_COMB4 = 11;
    localparam S_PREP = 12;
    localparam S_OUT = 13;

    reg [3:0] state_r, state_w;
    reg [6:0] CNT_r[0:5], CNT_w[0:5];
    

    always@ (*) begin
        if(gray_valid && gray_data==8'd1) begin
            CNT_w[0] = CNT_r[0] + 1;
        end
        else begin
            CNT_w[0] = CNT_r[0];
        end
    end

    always@ (*) begin
        if(gray_valid && gray_data==8'd2) begin
            CNT_w[1] = CNT_r[1] + 1;
        end
        else begin
            CNT_w[1] = CNT_r[1];
        end
    end

    always@ (*) begin
        if(gray_valid && gray_data==8'd3) begin
            CNT_w[2] = CNT_r[2] + 1;
        end
        else begin
            CNT_w[2] = CNT_r[2];
        end
    end

    always@ (*) begin
        if(gray_valid && gray_data==8'd4) begin
            CNT_w[3] = CNT_r[3] + 1;
        end
        else begin
            CNT_w[3] = CNT_r[3];
        end
    end

    always@ (*) begin
        if(gray_valid && gray_data==8'd5) begin
            CNT_w[4] = CNT_r[4] + 1;
        end
        else begin
            CNT_w[4] = CNT_r[4];
        end
    end

    always@ (*) begin
        if(gray_valid && gray_data==8'd6) begin
            CNT_w[5] = CNT_r[5] + 1;
        end
        else begin
            CNT_w[5] = CNT_r[5];
        end
    end

    always@ (*) begin
        case(state_r)
            S_IDLE: state_w = (gray_valid) ? S_CNT : S_IDLE;
            S_CNT:  state_w = (!gray_valid) ? S_SORT1 : S_CNT;
            S_SORT1: state_w = S_SORT2;
            S_SORT2: state_w = S_SORT3;
            S_SORT3: state_w = S_SORT4;
            S_SORT4: state_w = S_SORT5;
            S_SORT5: state_w = S_SORT6;
            S_SORT6: state_w = S_COMB1;
            S_COMB1: state_w = S_COMB2;
            S_COMB2: state_w = S_COMB3;
            S_COMB3: state_w = S_COMB4;
            S_COMB4: state_w = S_PREP;
            S_PREP:  state_w = S_OUT;
            S_OUT: state_w = S_IDLE;
            default: state_w = state_r;
        endcase
    end

    integer i;
    always@ (posedge clk or posedge reset) begin
        if(reset) begin
            state_r <= S_IDLE;

            for(i=0; i<=5; i=i+1) begin
                CNT_r[i] <= 0;
            end
        end
        else begin
            state_r <= state_w;

            for(i=0; i<=5; i=i+1) begin
                CNT_r[i] <= CNT_w[i];
            end
        end
    end


    reg [17:0] order_r, order_w;
    reg [4:0]  split_r, split_w;
    reg [4:0]  bits_r[0:5], bits_w[0:5];
    reg [2:0]  count_r[0:5], count_w[0:5];
    reg switch;
    reg [2:0] pos;
    reg [7:0] temp1, temp2, temp3, temp4, temp5, temp6;
    reg res1, res2, res3, res4, res5;
    reg [7:0] AX, AY;
    reg [7:0] A_combined;

    reg [1:0] used_combined_or_not;


    always@ (*) begin
        A_combined = AX + AY;
    end

    always@ (*) begin
        if(state_r == S_COMB1) begin
            AX = CNT_r[ order_r[0 +: 3] ];
            AY = CNT_r[ order_r[3 +: 3] ];
        end        
        else if(state_r == S_COMB2) begin
            case(split_r)
                5'b11110: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ];
                end

                5'b11101: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                end

                5'b11011: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                5'b10111: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                5'b01111: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                default: begin
                    AX = 0;
                    AY = 0;
                end
            endcase
        end
        else if(state_r == S_COMB3) begin
            case(split_r)
                5'b00111: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end 

                5'b10011: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                5'b11001: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                end

                5'b11100: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                    AY = CNT_r[ order_r[9 +: 3] ];
                end

                5'b11010: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3 ]];
                end

                5'b10101: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                end

                5'b01011: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                5'b10110: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ];
                end

                5'b01101: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                end

                5'b01110: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ];
                end
               

                default: begin
                    AX = 0;
                    AY = 0;
                end
            endcase 
        end
        else if(state_r == S_COMB4) begin
            case(~split_r)
                5'b00111: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                    AY = CNT_r[ order_r[12 +: 3 ]];
                end

                5'b10011: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                    AY = CNT_r[ order_r[9 +: 3] ];
                end

                5'b11001: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ];
                end

                5'b11100: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ];
                end

                5'b11010: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                end

                5'b10101: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                end

                5'b01011: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ];
                    AY = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3 ]];
                end

                5'b10110: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                end

                5'b01101: begin
                    AX = CNT_r[ order_r[0 +: 3] ] + CNT_r[ order_r[3 +: 3] ];
                    AY = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3 ]];
                end

                5'b01110: begin
                    AX = CNT_r[ order_r[0 +: 3] ];
                    AY = CNT_r[ order_r[12 +: 3 ]] + CNT_r[ order_r[3 +: 3] ] + CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                end
               

                default: begin
                    AX = 0;
                    AY = 0;
                end
            endcase 
        end 
        else begin
            AX = 0;
            AY = 0;
        end
    end


    always@ (*) begin
        if(state_r == S_SORT1) begin
            temp1 = CNT_r[0];
            temp2 = CNT_r[1];
            temp3 = CNT_r[2];
            temp4 = CNT_r[3];
            temp5 = CNT_r[4];
            temp6 = CNT_r[5];
        end
        else if(state_r == S_SORT2) begin
            temp1 = CNT_r[1];
            temp2 = CNT_r[0];
            temp3 = CNT_r[2];
            temp4 = CNT_r[3];
            temp5 = CNT_r[4];
            temp6 = CNT_r[5];
        end
        else if(state_r == S_SORT3) begin
            temp1 = CNT_r[2];
            temp2 = CNT_r[0];
            temp3 = CNT_r[1];
            temp4 = CNT_r[3];
            temp5 = CNT_r[4];
            temp6 = CNT_r[5];
        end
        else if(state_r == S_SORT4) begin
            temp1 = CNT_r[3];
            temp2 = CNT_r[0];
            temp3 = CNT_r[1];
            temp4 = CNT_r[2];
            temp5 = CNT_r[4];
            temp6 = CNT_r[5];
        end
        else if(state_r == S_SORT5) begin
            temp1 = CNT_r[4];
            temp2 = CNT_r[0];
            temp3 = CNT_r[1];
            temp4 = CNT_r[2];
            temp5 = CNT_r[3];
            temp6 = CNT_r[5];
        end
        else if(state_r == S_SORT6) begin
            temp1 = CNT_r[5];
            temp2 = CNT_r[0];
            temp3 = CNT_r[1];
            temp4 = CNT_r[2];
            temp5 = CNT_r[3];
            temp6 = CNT_r[4];
        end
        else if(state_r == S_COMB1) begin
            temp1 = A_combined;
            temp2 = CNT_r[ order_r[6 +: 3] ];
            temp3 = CNT_r[ order_r[9 +: 3] ];
            temp4 = CNT_r[ order_r[12 +: 3] ];
            temp5 = CNT_r[ order_r[15 +: 3] ];
            temp6 = 0;
        end
        else if(state_r == S_COMB2) begin
            temp1 = A_combined;

            case(split_r)
                5'b11110: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ];
                    temp4 = CNT_r[ order_r[15 +: 3] ];
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11101: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ];
                    temp4 = CNT_r[ order_r[15 +: 3] ];
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11011: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ];
                    temp4 = CNT_r[ order_r[15 +: 3] ];
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10111: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ];
                    temp3 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ];
                    temp4 = CNT_r[ order_r[15 +: 3] ];
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01111: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ];
                    temp3 = CNT_r[ order_r[9 +: 3] ];
                    temp4 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp5 = 0;
                    temp6 = 0;
                end

                default: begin
                    temp2 = 0;
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end
            endcase
        end
        else if(state_r == S_COMB3) begin
            temp1 = A_combined;

            case(split_r)
                5'b00111: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ];
                    temp3 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10011: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11001: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11100: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11010: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10101: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01011: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10110: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ];
                    temp3 = CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01101: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01110: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ];
                    temp3 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end
               

                default: begin
                    temp2 = 0;
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end
            endcase 
        end
        else if(state_r == S_COMB4) begin
            temp1 = A_combined;

            case(~split_r)
                5'b00111: begin
                    temp2 = CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10011: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11001: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11100: begin
                    temp2 = CNT_r[ order_r[6 +: 3] ] + CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b11010: begin
                    temp2 = CNT_r[ order_r[9 +: 3] ] + CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10101: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01011: begin
                    temp2 = CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b10110: begin
                    temp2 = CNT_r[ order_r[12 +: 3] ] + CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01101: begin
                    temp2 = CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end

                5'b01110: begin
                    temp2 = CNT_r[ order_r[15 +: 3] ];
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end
               

                default: begin
                    temp2 = 0;
                    temp3 = 0;
                    temp4 = 0;
                    temp5 = 0;
                    temp6 = 0;
                end
            endcase 
        end
        else begin
            temp1 = 0;
            temp2 = 0;
            temp3 = 0;
            temp4 = 0;
            temp5 = 0;
            temp6 = 0;
        end
    end

    always@ (*) begin
        if(state_r == S_SORT1) begin
            res1 = (temp1 >= temp2);
            res2 = (temp1 >= temp3);
            res3 = (temp1 >= temp4);
            res4 = (temp1 >= temp5);
            res5 = (temp1 >= temp6);
        end
        else if(state_r == S_SORT2) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 >= temp3);
            res3 = (temp1 >= temp4);
            res4 = (temp1 >= temp5);
            res5 = (temp1 >= temp6);
        end
        else if(state_r == S_SORT3) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 >= temp4);
            res4 = (temp1 >= temp5);
            res5 = (temp1 >= temp6);
        end
        else if(state_r == S_SORT4) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 > temp4);
            res4 = (temp1 >= temp5);
            res5 = (temp1 >= temp6);
        end
        else if(state_r == S_SORT5) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 > temp4);
            res4 = (temp1 > temp5);
            res5 = (temp1 >= temp6);
        end
        else if(state_r == S_SORT6) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 > temp4);
            res4 = (temp1 > temp5);
            res5 = (temp1 > temp6);
        end
        else if(state_r == S_COMB1) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 > temp4);
            res4 = (temp1 > temp5);
            res5 = 0; 
        end
        else if(state_r == S_COMB2) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = (temp1 > temp4);
            res4 = 0;
            res5 = 0;  
        end
        else if(state_r == S_COMB3) begin
            res1 = (temp1 > temp2);
            res2 = (temp1 > temp3);
            res3 = 0;
            res4 = 0;
            res5 = 0;  
        end
        else if(state_r == S_COMB4) begin
            res1 = (temp1 > temp2);
            res2 = 0;
            res3 = 0;
            res4 = 0;
            res5 = 0; 
        end
        else begin
            res1 = 0;
            res2 = 0;
            res3 = 0;
            res4 = 0;
            res5 = 0;
        end
    end

    always@ (*) begin
        pos = res1 + res2 + res3 + res4 + res5;
    end


    always@ (*) begin
        order_w = order_r;

        if(state_r == S_SORT1) begin
            order_w[3*(pos) +: 3] = 3'd0;
        end
        else if(state_r == S_SORT2) begin
            order_w[3*(pos) +: 3] = 3'd1;
        end
        else if(state_r == S_SORT3) begin
            order_w[3*(pos) +: 3] = 3'd2;
        end
        else if(state_r == S_SORT4) begin
            order_w[3*(pos) +: 3] = 3'd3;
        end
        else if(state_r == S_SORT5) begin
            order_w[3*(pos) +: 3] = 3'd4;
        end
        else if(state_r == S_SORT6) begin
            order_w[3*(pos) +: 3] = 3'd5;
        end
        else if(state_r == S_COMB1) begin
            case(pos)
                3'd0: order_w = order_r;
                3'd1: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[6 +: 3]};
                3'd2: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                3'd3: order_w = {order_r[15 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                3'd4: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
            endcase
        end
        else if(state_r == S_COMB2) begin
            case(pos)
                3'd0: begin
                    order_w = order_r;
                end

                3'd1: begin
                    case(split_r)
                        5'b11110: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3]}; 
                        5'b11101: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3]};
                        5'b11011: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                        5'b10111: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[6 +: 3]};
                        5'b01111: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[6 +: 3]};
                    endcase
                end

                3'd2: begin
                    case(split_r)
                        5'b11110: order_w = {order_r[15 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b11101: order_w = {order_r[15 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3]};
                        5'b11011: order_w = {order_r[15 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                        5'b10111: order_w = {order_r[15 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                        5'b01111: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                    endcase
                end

                3'd3: begin
                    case(split_r)
                        5'b11110: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b11101: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]};
                        5'b11011: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                        5'b10111: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                        5'b01111: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]};
                    endcase
                end
            endcase
        end
        else if(state_r == S_COMB3) begin
            case(pos)
                3'd0: begin
                    order_w = order_r;
                end

                3'd1: begin
                    case(split_r)
                        5'b00111: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[6 +: 3]}; 
                        5'b10011: order_w = {order_r[15 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b11001: order_w = {order_r[15 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3]}; 
                        5'b11100: order_w = {order_r[15 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3]}; 
                        5'b11010: order_w = {order_r[15 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3]}; 
                        5'b10101: order_w = {order_r[15 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b01011: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b10110: order_w = {order_r[15 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b01101: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3]}; 
                        5'b01110: order_w = {order_r[15 +: 3], order_r[12 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[9 +: 3]}; 
                    endcase 
                end

                3'd2: begin
                    case(split_r)
                        5'b00111: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b10011: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b11001: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b11100: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b11010: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b10101: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b01011: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b10110: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b01101: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b01110: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                    endcase 
                end
            endcase
        end
        else if(state_r == S_COMB4) begin
            case(pos)
                3'd0: begin
                    order_w = order_r;
                end

                3'd1: begin
                    case(~split_r)
                        5'b00111: order_w = {order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3]}; 
                        5'b10011: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b11001: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b11100: order_w = {order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3]}; 
                        5'b11010: order_w = {order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3], order_r[9 +: 3]}; 
                        5'b10101: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b01011: order_w = {order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3]}; 
                        5'b10110: order_w = {order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3], order_r[12 +: 3]}; 
                        5'b01101: order_w = {order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3]}; 
                        5'b01110: order_w = {order_r[12 +: 3], order_r[9 +: 3], order_r[6 +: 3], order_r[3 +: 3], order_r[0 +: 3], order_r[15 +: 3]}; 
                    endcase 
                end
            endcase    
        end
    end 


    integer k;
    always@ (*) begin
        for(k=0; k<=5; k=k+1) begin
            bits_w[k] = bits_r[k];
            count_w[k] = count_r[k];
        end

        if(state_r == S_COMB1) begin
            bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
            bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

            count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
            count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
        end
        else if(state_r == S_COMB2) begin
            case(split_r)
                5'b11110: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11101: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11011: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10111: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01111: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end
            endcase 
        end
        else if(state_r == S_COMB3) begin
            case(split_r)
                5'b00111: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10011: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11001: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11100: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11010: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10101: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01011: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10110: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01101: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01110: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end
            endcase 
        end
        else if(state_r == S_COMB4) begin
            case(~split_r)
                5'b00111: begin
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10011: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11001: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11100: begin
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b11010: begin
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10101: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01011: begin
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10110: begin
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01101: begin
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01110: begin
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end
            endcase 
        end
        else if(state_r == S_PREP) begin
            case(split_r)
                5'b00001: begin
                    bits_w[ order_r[15 +: 3] ] = {bits_r[ order_r[15 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[15 +: 3] ] = count_r[ order_r[15 +: 3] ] + 1;
                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b00010: begin
                    bits_w[ order_r[15 +: 3] ] = {bits_r[ order_r[15 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[15 +: 3] ] = count_r[ order_r[15 +: 3] ] + 1;
                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b00100: begin
                    bits_w[ order_r[15 +: 3] ] = {bits_r[ order_r[15 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[15 +: 3] ] = count_r[ order_r[15 +: 3] ] + 1;
                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b01000: begin
                    bits_w[ order_r[15 +: 3] ] = {bits_r[ order_r[15 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[15 +: 3] ] = count_r[ order_r[15 +: 3] ] + 1;
                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end

                5'b10000: begin
                    bits_w[ order_r[15 +: 3] ] = {bits_r[ order_r[15 +: 3] ][3:0], 1'b0};
                    bits_w[ order_r[12 +: 3] ] = {bits_r[ order_r[12 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[9 +: 3] ] = {bits_r[ order_r[9 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[6 +: 3] ] = {bits_r[ order_r[6 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[3 +: 3] ] = {bits_r[ order_r[3 +: 3] ][3:0], 1'b1};
                    bits_w[ order_r[0 +: 3] ] = {bits_r[ order_r[0 +: 3] ][3:0], 1'b1};

                    count_w[ order_r[15 +: 3] ] = count_r[ order_r[15 +: 3] ] + 1;
                    count_w[ order_r[12 +: 3] ] = count_r[ order_r[12 +: 3] ] + 1;
                    count_w[ order_r[9 +: 3] ] = count_r[ order_r[9 +: 3] ] + 1;
                    count_w[ order_r[6 +: 3] ] = count_r[ order_r[6 +: 3] ] + 1;
                    count_w[ order_r[3 +: 3] ] = count_r[ order_r[3 +: 3] ] + 1;
                    count_w[ order_r[0 +: 3] ] = count_r[ order_r[0 +: 3] ] + 1;
                end
            endcase
        end
    end


    always@ (*) begin
        if(state_r == S_COMB1) begin
            case(pos)   
                3'd0:   split_w = 5'b11110;
                3'd1:   split_w = 5'b11101;   
                3'd2:   split_w = 5'b11011;
                3'd3:   split_w = 5'b10111;
                3'd4:   split_w = 5'b01111;
                default: split_w = 5'b11111;
            endcase
        end
        else if(state_r == S_COMB2) begin
            case(pos)  
                3'd0: begin
                    case(split_r)
                        5'b11110: split_w = 5'b11100; 
                        5'b11101: split_w = 5'b11100;
                        5'b11011: split_w = 5'b11010;
                        5'b10111: split_w = 5'b10110;
                        5'b01111: split_w = 5'b01110;
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd1: begin
                    case(split_r)
                        5'b11110: split_w = 5'b11001; 
                        5'b11101: split_w = 5'b11001;
                        5'b11011: split_w = 5'b11010;
                        5'b10111: split_w = 5'b10101;
                        5'b01111: split_w = 5'b01101;
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd2: begin
                    case(split_r)
                        5'b11110: split_w = 5'b10011; 
                        5'b11101: split_w = 5'b10011;
                        5'b11011: split_w = 5'b10110;
                        5'b10111: split_w = 5'b10101;
                        5'b01111: split_w = 5'b01011;
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd3: begin
                    case(split_r)
                        5'b11110: split_w = 5'b00111; 
                        5'b11101: split_w = 5'b00111;
                        5'b11011: split_w = 5'b01110;
                        5'b10111: split_w = 5'b01101;
                        5'b01111: split_w = 5'b01011;
                        default:  split_w = 5'b11111;
                    endcase
                end

                default: split_w = 5'b11111;
            endcase
        end
        else if(state_r == S_COMB3) begin
            case(pos)   
                3'd0:  begin
                    case(split_r)
                        5'b00111: split_w = 5'b00110;
                        5'b10011: split_w = 5'b10010; 
                        5'b11001: split_w = 5'b11000; 
                        5'b11100: split_w = 5'b11000; 
                        5'b11010: split_w = 5'b11000; 
                        5'b10101: split_w = 5'b10100; 
                        5'b01011: split_w = 5'b01010; 
                        5'b10110: split_w = 5'b10100; 
                        5'b01101: split_w = 5'b01100; 
                        5'b01110: split_w = 5'b01100; 
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd1:   begin
                    case(split_r)
                        5'b00111: split_w = 5'b00101; 
                        5'b10011: split_w = 5'b10100; 
                        5'b11001: split_w = 5'b10001; 
                        5'b11100: split_w = 5'b10001; 
                        5'b11010: split_w = 5'b10001; 
                        5'b10101: split_w = 5'b10010; 
                        5'b01011: split_w = 5'b01010; 
                        5'b10110: split_w = 5'b10010; 
                        5'b01101: split_w = 5'b01001; 
                        5'b01110: split_w = 5'b01001; 
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd2:  begin
                    case(split_r)
                        5'b00111: split_w = 5'b01001;
                        5'b10011: split_w = 5'b01100;
                        5'b11001: split_w = 5'b00011;
                        5'b11100: split_w = 5'b00011;
                        5'b11010: split_w = 5'b00011;
                        5'b10101: split_w = 5'b00110;
                        5'b01011: split_w = 5'b01010;
                        5'b10110: split_w = 5'b00110;
                        5'b01101: split_w = 5'b00101;
                        5'b01110: split_w = 5'b00101;
                        default:  split_w = 5'b11111;
                    endcase
                end

                default: split_w = 5'b11111;
            endcase
        end
        else if(state_r == S_COMB4) begin
            case(pos)   
                3'd0:  begin
                    case(~split_r)
                        5'b00111: split_w = 5'b10000;
                        5'b10011: split_w = 5'b01000; 
                        5'b11001: split_w = 5'b00100; 
                        5'b11100: split_w = 5'b00010; 
                        5'b11010: split_w = 5'b00100; 
                        5'b10101: split_w = 5'b01000; 
                        5'b01011: split_w = 5'b10000; 
                        5'b10110: split_w = 5'b01000; 
                        5'b01101: split_w = 5'b10000; 
                        5'b01110: split_w = 5'b10000; 
                        default:  split_w = 5'b11111;
                    endcase
                end

                3'd1:   begin
                    case(~split_r)
                        5'b00111: split_w = 5'b00001;
                        5'b10011: split_w = 5'b00010; 
                        5'b11001: split_w = 5'b00100; 
                        5'b11100: split_w = 5'b01000; 
                        5'b11010: split_w = 5'b00100; 
                        5'b10101: split_w = 5'b00010; 
                        5'b01011: split_w = 5'b00001; 
                        5'b10110: split_w = 5'b00010; 
                        5'b01101: split_w = 5'b00001; 
                        5'b01110: split_w = 5'b00001; 
                        default:  split_w = 5'b11111;
                    endcase
                end

                default: split_w = 5'b11111;
            endcase
        end
        else begin
            split_w = 5'b11111;
        end
    end

    assign CNT_valid = (state_r==S_SORT1);
    assign code_valid = (state_r==S_OUT);
   
    assign CNT1 = CNT_r[0];
    assign CNT2 = CNT_r[1];
    assign CNT3 = CNT_r[2];
    assign CNT4 = CNT_r[3];
    assign CNT5 = CNT_r[4];
    assign CNT6 = CNT_r[5];

    always@ (*) begin
        case(count_r[0])
            3'd1: M1 = 8'b00000001;
            3'd2: M1 = 8'b00000011;
            3'd3: M1 = 8'b00000111;
            3'd4: M1 = 8'b00001111;
            3'd5: M1 = 8'b00011111;
            default: M1 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[1])
            3'd1: M2 = 8'b00000001;
            3'd2: M2 = 8'b00000011;
            3'd3: M2 = 8'b00000111;
            3'd4: M2 = 8'b00001111;
            3'd5: M2 = 8'b00011111;
            default: M2 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[2])
            3'd1: M3 = 8'b00000001;
            3'd2: M3 = 8'b00000011;
            3'd3: M3 = 8'b00000111;
            3'd4: M3 = 8'b00001111;
            3'd5: M3 = 8'b00011111;
            default: M3 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[3])
            3'd1: M4 = 8'b00000001;
            3'd2: M4 = 8'b00000011;
            3'd3: M4 = 8'b00000111;
            3'd4: M4 = 8'b00001111;
            3'd5: M4 = 8'b00011111;
            default: M4 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[4])
            3'd1: M5 = 8'b00000001;
            3'd2: M5 = 8'b00000011;
            3'd3: M5 = 8'b00000111;
            3'd4: M5 = 8'b00001111;
            3'd5: M5 = 8'b00011111;
            default: M5 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[5])
            3'd1: M6 = 8'b00000001;
            3'd2: M6 = 8'b00000011;
            3'd3: M6 = 8'b00000111;
            3'd4: M6 = 8'b00001111;
            3'd5: M6 = 8'b00011111;
            default: M6 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[0])
            3'd1: HC1 = {7'd0, bits_r[0][0]};
            3'd2: HC1 = {6'd0, bits_r[0][0], bits_r[0][1]};
            3'd3: HC1 = {5'd0, bits_r[0][0], bits_r[0][1], bits_r[0][2]};
            3'd4: HC1 = {4'd0, bits_r[0][0], bits_r[0][1], bits_r[0][2], bits_r[0][3]};
            3'd5: HC1 = {3'd0, bits_r[0][0], bits_r[0][1], bits_r[0][2], bits_r[0][3], bits_r[0][4]};
            default: HC1 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[1])
            3'd1: HC2 = {7'd0, bits_r[1][0]};
            3'd2: HC2 = {6'd0, bits_r[1][0], bits_r[1][1]};
            3'd3: HC2 = {5'd0, bits_r[1][0], bits_r[1][1], bits_r[1][2]};
            3'd4: HC2 = {4'd0, bits_r[1][0], bits_r[1][1], bits_r[1][2], bits_r[1][3]};
            3'd5: HC2 = {3'd0, bits_r[1][0], bits_r[1][1], bits_r[1][2], bits_r[1][3], bits_r[1][4]};
            default: HC2 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[2])
            3'd1: HC3 = {7'd0, bits_r[2][0]};
            3'd2: HC3 = {6'd0, bits_r[2][0], bits_r[2][1]};
            3'd3: HC3 = {5'd0, bits_r[2][0], bits_r[2][1], bits_r[2][2]};
            3'd4: HC3 = {4'd0, bits_r[2][0], bits_r[2][1], bits_r[2][2], bits_r[2][3]};
            3'd5: HC3 = {3'd0, bits_r[2][0], bits_r[2][1], bits_r[2][2], bits_r[2][3], bits_r[2][4]};
            default: HC3 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[3])
            3'd1: HC4 = {7'd0, bits_r[3][0]};
            3'd2: HC4 = {6'd0, bits_r[3][0], bits_r[3][1]};
            3'd3: HC4 = {5'd0, bits_r[3][0], bits_r[3][1], bits_r[3][2]};
            3'd4: HC4 = {4'd0, bits_r[3][0], bits_r[3][1], bits_r[3][2], bits_r[3][3]};
            3'd5: HC4 = {3'd0, bits_r[3][0], bits_r[3][1], bits_r[3][2], bits_r[3][3], bits_r[3][4]};
            default: HC4 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[4])
            3'd1: HC5 = {7'd0, bits_r[4][0]};
            3'd2: HC5 = {6'd0, bits_r[4][0], bits_r[4][1]};
            3'd3: HC5 = {5'd0, bits_r[4][0], bits_r[4][1], bits_r[4][2]};
            3'd4: HC5 = {4'd0, bits_r[4][0], bits_r[4][1], bits_r[4][2], bits_r[4][3]};
            3'd5: HC5 = {3'd0, bits_r[4][0], bits_r[4][1], bits_r[4][2], bits_r[4][3], bits_r[4][4]};
            default: HC5 = 0;
        endcase
    end

    always@ (*) begin
        case(count_r[5])
            3'd1: HC6 = {7'd0, bits_r[5][0]};
            3'd2: HC6 = {6'd0, bits_r[5][0], bits_r[5][1]};
            3'd3: HC6 = {5'd0, bits_r[5][0], bits_r[5][1], bits_r[5][2]};
            3'd4: HC6 = {4'd0, bits_r[5][0], bits_r[5][1], bits_r[5][2], bits_r[5][3]};
            3'd5: HC6 = {3'd0, bits_r[5][0], bits_r[5][1], bits_r[5][2], bits_r[5][3], bits_r[5][4]};
            default: HC6 = 0;
        endcase
    end

    integer j;
    always@ (posedge clk or posedge reset) begin
        if(reset) begin
            order_r <= 0;
            split_r <= 0;

            for(j=0; j<=5; j=j+1) begin
                bits_r[j] <= 0;
                count_r[j] <= 0;
            end
        end
        else begin
            order_r <= order_w;
            split_r <= split_w;

            for(j=0; j<=5; j=j+1) begin
                bits_r[j] <= bits_w[j];
                count_r[j] <= count_w[j];
            end
        end
    end

endmodule


    