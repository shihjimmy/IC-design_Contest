module DT(
	input 			clk, 
	input			reset,
	output			done,
	output			sti_rd,
	output	 		[9:0]	sti_addr,
	input		    [15:0]	sti_di,
	output	reg		res_wr,
	output			res_rd,
	output	reg		[13:0]	res_addr,
	output		 	[7:0]	res_do,
	input		    [7:0]	res_di
);
	localparam S_FW_NW = 0; 
	localparam S_FW_N = 1; 
	localparam S_FW_NE = 2; 
	localparam S_FW_W = 3; 
	localparam S_STALL1 = 4;
	localparam S_STALL2 = 5; 
	localparam S_BW_GET = 6;
	localparam S_BW_E = 7;
	localparam S_BW_SE = 8;
	localparam S_BW_S = 9;
	localparam S_BW_SW = 10;
	localparam S_STALL3 = 11;
	localparam S_STALL4 = 12; 

	reg [3:0] state_r, state_w;
	reg [3:0] state_temp_r;
	reg [6:0] count_row_r, count_row_w;
	reg [6:0] count_col_r, count_col_w;

	wire res_wr_w;
	reg [13:0] res_addr_w;

	reg [7:0]  cur_data_r;
	wire [7:0] cur_data_w;
	reg [7:0]  res_data_r;
	wire [7:0]  res_data_w;

	wire [7:0] temp1, temp2, temp3;
	wire [13:0] temp4;
	wire [6:0]  temp5, temp6, temp7, temp8;
	wire is_pixel;
	reg is_pixel_r;
	wire FW_finish;

	always@ (*) begin
		case(state_r)
			S_FW_NW:  state_w = (is_pixel) ? S_FW_N : (&({count_row_r[6:1],1'b1,count_col_r[6:1],1'b1})) ? S_BW_GET : S_FW_NW;
			S_FW_N:   state_w = S_FW_NE;
			S_FW_NE:  state_w = S_FW_W;
			S_FW_W:   state_w = S_STALL1;
			S_STALL1: state_w = S_STALL2;
			S_STALL2: state_w = &({count_row_r[6:1],1'b1,count_col_r[6:1],1'b1}) ? S_BW_GET : S_FW_NW;
			S_BW_GET: state_w = (is_pixel) ? S_BW_E : (&(~{count_row_r[6:1],count_col_r[6:1]})) ? S_STALL4 : S_BW_GET;
			S_BW_E:   state_w = S_BW_SE;
			S_BW_SE:  state_w = S_BW_S;
			S_BW_S:   state_w = S_BW_SW;
			S_BW_SW:  state_w = S_STALL3;
			S_STALL3: state_w = S_STALL4;
			S_STALL4: state_w = &(~{count_row_r[6:1],count_col_r[6:1]}) ? S_STALL4 : S_BW_GET;
			default:  state_w = S_FW_NW;
		endcase
	end
	
	// Output
	assign FW_finish = (&({count_row_r[6:1],1'b1,count_col_r[6:1],1'b1})) && (state_r==S_STALL2 || state_r==S_FW_NW);
	assign done = (&(~{count_row_r[6:1],count_col_r[6:1]})) && (state_r==S_STALL4 || state_r==S_BW_GET);
	assign res_rd = (state_r!=S_STALL1) && (state_r!=S_STALL2) && (state_r!=S_STALL3) && (state_r!=S_STALL4);
	assign res_do = res_data_r;
	assign res_wr_w = state_r==S_STALL1 || state_r==S_STALL3;
	assign sti_rd = state_r==S_BW_GET || state_r==S_FW_NW;
	assign sti_addr = temp4[13:4];
	assign is_pixel = sti_di[ (4'd15-count_col_r[3:0]) ];

	
	//FW & BW
	assign cur_data_w = res_di;
	assign temp1 = (state_temp_r == S_BW_GET && is_pixel_r && cur_data_r>=8'd1) ? (cur_data_r - 8'd1) : cur_data_r;
	assign temp2 = (temp1 < res_data_r || (state_temp_r==S_FW_NW && is_pixel_r) || (state_temp_r==S_BW_GET && is_pixel_r)) ? temp1 : res_data_r;
	assign temp3 = (state_r == S_STALL1 || state_r == S_STALL3) ? (temp2 + 8'd1) : temp2;
	assign res_data_w = temp3;


	// For res_addr	
	assign temp4 = {count_row_r, count_col_r};
	assign temp5 = count_row_r + 7'd1;
	assign temp6 = count_col_r + 7'd1;
	assign temp7 = count_row_r - 7'd1;
	assign temp8 = count_col_r - 7'd1;

	always@ (*) begin
		case(state_r)
			S_FW_NW:  res_addr_w = {temp7, count_col_r};
			S_FW_N:   res_addr_w = {temp7, temp6};
			S_FW_NE:  res_addr_w = {count_row_r, temp8};
			S_STALL1, S_STALL3: res_addr_w = {count_row_r, count_col_r};
			S_STALL2: res_addr_w = (FW_finish) ? {count_row_w, count_col_w} : {count_row_w-7'd1, count_col_w-7'd1};
			S_BW_GET: res_addr_w = {count_row_r, temp6};
			S_BW_E:   res_addr_w = {temp5, temp6};
			S_BW_SE:  res_addr_w = {temp5, count_col_r};
			S_BW_S:   res_addr_w = {temp5, temp8};
			S_STALL4: res_addr_w = {count_row_w, count_col_w};
			default:  res_addr_w = 0;
		endcase
	end
	
	always@ (*) begin
		if( (state_r == S_FW_NW && (!is_pixel)) || (state_r == S_STALL2) ) begin
			if( &({count_row_r[6:1],1'b1, count_col_r[6:1],1'b1}) ) begin
				count_col_w = count_col_r;
				count_row_w = count_row_r;
			end
			else if(count_col_r == 7'd126) begin
				count_col_w = 1;
				count_row_w = temp5;
			end
			else begin
				count_col_w = temp6;
				count_row_w = count_row_r;
			end
		end
		else if ((state_r == S_BW_GET && (!is_pixel)) || (state_r == S_STALL4)) begin
			if(count_col_r == 7'd1) begin
				count_col_w = 7'd126;
				count_row_w = temp7;
			end
			else begin
				count_col_w = temp8;
				count_row_w = count_row_r;
			end
		end
		else begin
			count_col_w = count_col_r;
			count_row_w = count_row_r;
		end
	end

	
	always@ (posedge clk or negedge reset) begin
		if (!reset) begin
			state_r <= 0;
			state_temp_r <= 0;
			count_row_r <= 1;
			count_col_r <= 1;
			cur_data_r <= 0;
			res_wr <= 0;
			res_addr <= 0;
			res_data_r <= 0;
			is_pixel_r <= 0;
		end	
		else begin
			state_r <= state_w;
			state_temp_r <= state_r;
			count_row_r <= count_row_w;
			count_col_r <= count_col_w;
			cur_data_r <= cur_data_w;
			res_wr <= res_wr_w;
			res_addr <= res_addr_w;
			res_data_r <= res_data_w;
			is_pixel_r <= is_pixel;
		end
	end

endmodule
