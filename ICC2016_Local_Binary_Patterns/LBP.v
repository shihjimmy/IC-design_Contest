module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
    input   	clk;
    input   	reset;
    output  reg  [13:0] gray_addr;
    output         	gray_req;
    input   	    gray_ready;
    input   [7:0] 	gray_data;
    output  [13:0]  lbp_addr;
    output  	    lbp_valid;
    output  [7:0] 	lbp_data;
    output  reg     finish;
//====================================================================

    localparam S_IDLE = 0;
    localparam S_GET_CUR = 1;
    localparam S_GET_7 = 2;
    localparam S_GET_6 = 3;
    localparam S_GET_5 = 4;
    localparam S_GET_4 = 5;
    localparam S_GET_3 = 6;
    localparam S_GET_2 = 7;
    localparam S_GET_1 = 8;
    localparam S_GET_0 = 9;

    reg [3:0] state_r, state_w;
    reg [7:0]  cur_data_r;
    wire [7:0] cur_data_w;
    reg [7:0]  lbp_data_r;
    wire [7:0] lbp_data_w;
    reg [13:0]  lbp_addr_r;
    wire [13:0] lbp_addr_w;
    reg  lbp_valid_r;
    wire lbp_valid_w;
    wire finish_w;

    reg [6:0] count_row_r, count_row_w;
    reg [6:0] count_col_r, count_col_w;

    assign lbp_data = lbp_data_r;
    assign lbp_valid = lbp_valid_r;
    assign lbp_addr = lbp_addr_r;
    assign gray_req = (|state_r);
    assign finish_w = ({count_row_r, count_col_r} == {7'd126, 7'd126}) && (state_r==S_GET_0);

    always@ (*) begin
        case(state_r)
            S_IDLE:     state_w = (gray_ready) ? S_GET_CUR : S_IDLE;
            S_GET_CUR:  state_w = S_GET_7;
            S_GET_7:    state_w = S_GET_6;
            S_GET_6:    state_w = S_GET_5;
            S_GET_5:    state_w = S_GET_4;
            S_GET_4:    state_w = S_GET_3;
            S_GET_3:    state_w = S_GET_2;
            S_GET_2:    state_w = S_GET_1;
            S_GET_1:    state_w = S_GET_0;
            S_GET_0:    state_w = ({count_row_r, count_col_r} == {7'd126, 7'd126}) ? S_IDLE : S_GET_CUR;
            default:    state_w = S_IDLE;
        endcase
    end 

    wire [6:0] temp1, temp2, temp3, temp4;
    assign temp1 = count_row_r + 7'b1;
    assign temp2 = count_col_r + 7'b1;
    assign temp3 = count_row_r - 7'b1;
    assign temp4 = count_col_r - 7'b1;

    always@ (*) begin
        case(state_r) 
            S_GET_CUR:  gray_addr = {count_row_r, count_col_r};
            S_GET_7:    gray_addr = {temp1 , temp2};
            S_GET_6:    gray_addr = {temp1 , count_col_r};
            S_GET_5:    gray_addr = {temp1 , temp4};
            S_GET_4:    gray_addr = {count_row_r , temp2};
            S_GET_3:    gray_addr = {count_row_r , temp4};
            S_GET_2:    gray_addr = {temp3 , temp2};
            S_GET_1:    gray_addr = {temp3 , count_col_r};
            S_GET_0:    gray_addr = {temp3 , temp4};
            default:    gray_addr = 14'd0;
        endcase
    end

    assign lbp_addr_w  = {count_row_r, count_col_r};
    assign lbp_valid_w = (state_r == S_GET_0);
    assign cur_data_w = (state_r == S_GET_CUR) ? gray_data : cur_data_r;

    wire bigger;
    assign bigger = gray_data >= cur_data_r;
    assign lbp_data_w = (state_r==S_IDLE || state_r==S_GET_CUR) ? 8'd0 : {lbp_data_r[6:0], bigger};

    always@ (*) begin
        if(state_r == S_GET_0) begin
            if(count_col_r == 7'd126) begin
                count_row_w = temp1;
                count_col_w = 1;
            end
            else begin
                count_row_w = count_row_r;
                count_col_w = temp2;
            end
        end
        else begin
            count_row_w = count_row_r;
            count_col_w = count_col_r;
        end
    end

    always@ (posedge clk or posedge reset) begin
        if(reset) begin
            state_r <= S_IDLE;
            cur_data_r <= 0;
            lbp_data_r <= 0;
            lbp_addr_r <= 0;
            lbp_valid_r <= 0;
            count_row_r <= 1;
            count_col_r <= 1;
            finish <= 0;
        end
        else begin
            state_r <= state_w;
            cur_data_r <= cur_data_w;
            lbp_data_r <= lbp_data_w;
            lbp_addr_r <= lbp_addr_w;
            lbp_valid_r <= lbp_valid_w;
            count_row_r <= count_row_w;
            count_col_r <= count_col_w;
            finish <= finish_w;
        end
    end

//====================================================================
endmodule
