`timescale 1ns/10ps

module CONV(
	input		clk,
	input		reset,
	output		busy,	
	input		ready,	

	output		[11:0] iaddr,
	input		[19:0] idata,	

	output	 	cwr,
	output	 	[11:0] caddr_wr,
	output	 	[19:0] cdata_wr,

	output	 	crd,
	output	 	[11:0] caddr_rd,
	input	 	[19:0] cdata_rd,

	output	 	[2:0] csel
);

	localparam S_IDLE  = 0;
	localparam S_PREP  = 1;
	localparam S_LOAD  = 2;   
	localparam S_MULT  = 3;   
	localparam S_ADD   = 4;
	localparam S_OUT   = 5;
	localparam S_PREP2 = 6;
	localparam S_LOAD2 = 7;   
	localparam S_MULT2 = 8;
	localparam S_ADD2  = 9;
	localparam S_OUT2  = 10;
	localparam S_PREP3 = 11;
	localparam S_LOAD3 = 12;
	localparam S_MAX   = 13;
	localparam S_OUT3  = 14;
	localparam S_PREP4 = 15;
	localparam S_LOAD4 = 16;
	localparam S_MAX2  = 17;
	localparam S_OUT4  = 18;
	localparam S_PREP5 = 19;
	localparam S_FLAT  = 20;
	localparam S_PREP6 = 21;
	localparam S_FLAT2 = 22;
	localparam S_FINISH= 23;
	localparam S_WAIT  = 24;

	localparam KERNEL0_0 = 20'h0A89E;
	localparam KERNEL0_1 = 20'h092D5;
	localparam KERNEL0_2 = 20'h06D43;
	localparam KERNEL0_3 = 20'h01004;
	localparam KERNEL0_4 = 20'hF8F71;
	localparam KERNEL0_5 = 20'hF6E54;
	localparam KERNEL0_6 = 20'hFA6D7;
	localparam KERNEL0_7 = 20'hFC834;
	localparam KERNEL0_8 = 20'hFAC19;
	localparam KERNEL1_0 = 20'hFDB55;
	localparam KERNEL1_1 = 20'h02992;
	localparam KERNEL1_2 = 20'hFC994;
	localparam KERNEL1_3 = 20'h050FD;
	localparam KERNEL1_4 = 20'h02F20;
	localparam KERNEL1_5 = 20'h0202D;
	localparam KERNEL1_6 = 20'h03BD7;
	localparam KERNEL1_7 = 20'hFD369;
	localparam KERNEL1_8 = 20'h05E68;
	localparam KERNEL0_BIAS = 20'h01310;
	localparam KERNEL1_BIAS = 20'hF7295;

	//-----------------------------------//
	// for control
	reg [4:0] state_r, state_w;
	reg [3:0] count_calc_r, count_calc_w;
	reg [11:0] count_pixel_r, count_pixel_w;
	reg [11:0] coord;
	reg [19:0] load_data;
	wire case1, case2, case3, case4;
	wire [3:0] cases;
	wire [11:0] coord0, coord1, coord2, coord3, coord4, coord5, coord6, coord7, coord8;
	wire can_conv_change, can_max_change;
	reg is_zero;
	
	assign can_conv_change = (count_calc_r==4'd8);
	assign can_max_change  = (count_calc_r==4'd3); 

	//-----------------------------------//
	// for output
	reg busy_r;
	wire busy_w;
	reg cwr_r, cwr_w;
	reg crd_r, crd_w;
	reg [11:0] iaddr_r, iaddr_w;
	reg [11:0] caddr_rd_r, caddr_rd_w;
	reg [11:0] caddr_wr_r, caddr_wr_w;
	reg [19:0] cdata_wr_r, cdata_wr_w;
	reg [2:0]  csel_r, csel_w;

	assign busy = busy_r;
	assign cwr = cwr_r;
	assign crd = crd_r;
	assign iaddr = iaddr_r;
	assign caddr_rd = caddr_rd_r;
	assign caddr_wr = caddr_wr_r;
	assign cdata_wr = cdata_wr_r;
	assign csel = csel_r;

	//-----------------------------------//
	// for computation
	reg [39:0] data_r, data_w;
	reg [19:0] coeff_mult;
	reg [39:0] mult_result;
	reg [39:0] coeff_add;
	reg [42:0] conv_result;
	reg [42:0] result_r, result_w;
	reg [19:0] conv_RELU_output;
	reg [42:0] maxpool_result;

	always@ (posedge clk or posedge reset) begin
		if(reset) begin
			busy_r 			<= 0;
			crd_r 			<= 0;
			cwr_r 			<= 0;
			iaddr_r 		<= 0;
			caddr_rd_r 		<= 0;
			caddr_wr_r 		<= 0;
			cdata_wr_r 		<= 0;
			csel_r 			<= 0;

			state_r 		<= 0;
			count_calc_r 	<= 0;
			count_pixel_r   <= 0;

			data_r 			<= 0;
			result_r        <= 0;
		end
		else begin
			busy_r 			<= busy_w;
			crd_r 			<= crd_w;
			cwr_r 			<= cwr_w;
			iaddr_r 		<= iaddr_w;
			caddr_rd_r 		<= caddr_rd_w;
			caddr_wr_r 		<= caddr_wr_w;
			cdata_wr_r 		<= cdata_wr_w;
			csel_r 			<= csel_w;

			state_r 		<= state_w;
			count_calc_r 	<= count_calc_w;
			count_pixel_r   <= count_pixel_w;

			data_r 			<= data_w;
			result_r        <= result_w;
		end
	end

	always@ (*) begin
		case(state_r)
			S_IDLE : state_w = S_WAIT;
			S_WAIT : state_w = S_PREP;
			S_PREP : state_w = S_LOAD; 
			S_LOAD : state_w = S_MULT; 
			S_MULT : state_w = S_ADD; 
			S_ADD  : state_w = S_OUT; 
			S_OUT  : state_w = (can_conv_change && (&count_pixel_r)) ? S_PREP2 : S_PREP; 
			S_PREP2: state_w = S_LOAD2; 
			S_LOAD2: state_w = S_MULT2; 
			S_MULT2: state_w = S_ADD2; 
			S_ADD2 : state_w = S_OUT2; 
			S_OUT2 : state_w = (can_conv_change && (&count_pixel_r)) ? S_PREP3 : S_PREP2; 
			S_PREP3: state_w = S_LOAD3; 
			S_LOAD3: state_w = S_MAX; 
			S_MAX  : state_w = S_OUT3; 
			S_OUT3 : state_w = (can_max_change && (&count_pixel_r[9:0])) ? S_PREP4 : S_PREP3; 
			S_PREP4: state_w = S_LOAD4; 
			S_LOAD4: state_w = S_MAX2; 
			S_MAX2 : state_w = S_OUT4; 
			S_OUT4 : state_w = (can_max_change && (&count_pixel_r[9:0])) ? S_PREP5 : S_PREP4;
			S_PREP5: state_w = S_FLAT; 
			S_FLAT : state_w = S_PREP6;
			S_PREP6: state_w = S_FLAT2;
			S_FLAT2: state_w = (&count_pixel_r[9:0]) ? S_FINISH : S_PREP5;
			S_FINISH: state_w = S_IDLE;
			default: state_w = S_IDLE;
		endcase
	end

	wire [11:0] temp_pixel, temp_pixel2;
	assign temp_pixel = count_pixel_r + 1;
	assign temp_pixel2 = {count_pixel_r[10:0], 1'd0} + 1;
	
	wire [3:0] temp_calc;
	assign temp_calc = count_calc_r + 1;
	
	always@ (*) begin
		case(state_r) 
			S_OUT  : count_pixel_w = (can_conv_change) ? temp_pixel : count_pixel_r;
			S_OUT2 : count_pixel_w = (can_conv_change) ? temp_pixel : count_pixel_r; 
			S_OUT3 : count_pixel_w = (can_max_change && (&count_pixel_r[9:0])) ? 0 : (can_max_change) ?  temp_pixel : count_pixel_r;
			S_OUT4 : count_pixel_w = (can_max_change && (&count_pixel_r[9:0])) ? 0 : (can_max_change) ?  temp_pixel : count_pixel_r;
			S_FLAT2: count_pixel_w = temp_pixel;
			default: count_pixel_w = count_pixel_r; 
		endcase
	end

	always@ (*) begin
		case(state_r) 
			S_OUT  : count_calc_w = (can_conv_change) ? 0 : temp_calc;
			S_OUT2 : count_calc_w = (can_conv_change) ? 0 : temp_calc;
			S_OUT3 : count_calc_w = (can_max_change)  ? 0 : temp_calc;
			S_OUT4 : count_calc_w = (can_max_change)  ? 0 : temp_calc;
			default: count_calc_w = count_calc_r; 
		endcase 
	end

	// busy
	assign busy_w = !(state_w == S_IDLE);

	// iaddr
	always@ (*) begin
		case(state_r)
			S_PREP : iaddr_w = coord;
			S_PREP2: iaddr_w = coord;
			default: iaddr_w = iaddr_r;
		endcase
	end

	// cwr, caddr_wr, cdata_wr
	always@ (*) begin
		case(state_r)
			S_OUT  : begin
				cwr_w = (can_conv_change) ? 1 : 0;
				caddr_wr_w = count_pixel_r;
				cdata_wr_w = conv_RELU_output;
			end
			
			S_OUT2 : begin
				cwr_w = (can_conv_change) ? 1 : 0;
				caddr_wr_w = count_pixel_r;
				cdata_wr_w = conv_RELU_output;
			end

			S_OUT3 : begin
				cwr_w = (can_max_change) ? 1 : 0;
				caddr_wr_w = count_pixel_r;
				cdata_wr_w = result_r[16 +: 20];
			end

			S_OUT4 : begin
				cwr_w = (can_max_change) ? 1 : 0;
				caddr_wr_w = count_pixel_r;
				cdata_wr_w = result_r[16 +: 20];
			end

			S_FLAT : begin
				cwr_w = 1;
				caddr_wr_w = count_pixel_r << 1;
				cdata_wr_w = cdata_rd;
			end
			
			S_FLAT2: begin
				cwr_w = 1;
				caddr_wr_w = temp_pixel2;
				cdata_wr_w = cdata_rd;
			end
			
			default: begin
				cwr_w = 0;
				caddr_wr_w = 0;
				cdata_wr_w = 0;
			end 
		endcase
	end

	// crd, caddr_rd
	always@ (*) begin
		case(state_r)
			S_PREP3: begin
				crd_w = 1;
				caddr_rd_w = coord;
			end
			
			S_PREP4: begin
				crd_w = 1;
				caddr_rd_w = coord;
			end 
			
			S_PREP5: begin
				crd_w = 1;
				caddr_rd_w = count_pixel_r;
			end 
			
			S_PREP6: begin
				crd_w = 1;
				caddr_rd_w = count_pixel_r;
			end
			
			default: begin
				crd_w = 0;
				caddr_rd_w = 0;
			end 
		endcase
	end

	// csel
	always@ (*) begin
		case(state_r)
			S_OUT  : csel_w = 3'b001;
			S_OUT2 : csel_w = 3'b010;
			S_OUT3 : csel_w = 3'b011;
			S_OUT4 : csel_w = 3'b100;
			S_FLAT : csel_w = 3'b101;
			S_FLAT2: csel_w = 3'b101;
			S_PREP3: csel_w = 3'b001;
			S_PREP4: csel_w = 3'b010; 
			S_PREP5: csel_w = 3'b011; 
			S_PREP6: csel_w = 3'b100;
			default: csel_w = 3'b000; 
		endcase
	end

	// data
	always@ (*) begin
		case(state_r)
			S_LOAD : data_w = {{4{load_data[19]}} ,load_data , 16'd0};
			S_MULT : data_w = mult_result;
			S_LOAD2: data_w = {{4{load_data[19]}} ,load_data , 16'd0};
			S_MULT2: data_w = mult_result;
			S_LOAD3: data_w = {4'd0 ,cdata_rd , 16'd0};
			S_LOAD4: data_w = {4'd0 ,cdata_rd , 16'd0};
			default: data_w = 0;
		endcase
	end

	// conv & max shared reg
	always@ (*) begin
		case(state_r)
			S_ADD :  result_w = conv_result;
			S_OUT :  result_w = (can_conv_change) ? 0 : result_r;
			S_ADD2:  result_w = conv_result;
			S_OUT2:  result_w = (can_conv_change) ? 0 : result_r;
			S_MAX :  result_w = maxpool_result;
			S_OUT3:  result_w = (can_max_change)  ? 0 : result_r;
			S_MAX2:  result_w = maxpool_result;
			S_OUT4:  result_w = (can_max_change)  ? 0 : result_r;
			default: result_w = result_r;
		endcase
	end

	// mult coeff
	always@ (*) begin
		case(state_r)
			S_MULT : begin
				case(count_calc_r)
					4'd0: coeff_mult = KERNEL0_0;
					4'd1: coeff_mult = KERNEL0_1; 
					4'd2: coeff_mult = KERNEL0_2;
					4'd3: coeff_mult = KERNEL0_3;
					4'd4: coeff_mult = KERNEL0_4;
					4'd5: coeff_mult = KERNEL0_5;
					4'd6: coeff_mult = KERNEL0_6;
					4'd7: coeff_mult = KERNEL0_7;
					4'd8: coeff_mult = KERNEL0_8;
					default: coeff_mult = 0;
				endcase
			end

			S_MULT2: begin
				case(count_calc_r)
					4'd0: coeff_mult = KERNEL1_0;
					4'd1: coeff_mult = KERNEL1_1; 
					4'd2: coeff_mult = KERNEL1_2;
					4'd3: coeff_mult = KERNEL1_3;
					4'd4: coeff_mult = KERNEL1_4;
					4'd5: coeff_mult = KERNEL1_5;
					4'd6: coeff_mult = KERNEL1_6;
					4'd7: coeff_mult = KERNEL1_7;
					4'd8: coeff_mult = KERNEL1_8;
					default: coeff_mult = 0;
				endcase
			end
			
			default: coeff_mult = 0;
		endcase
	end

	// add coeff
	always@ (*) begin
		case(state_r)
			S_ADD : coeff_add = data_r;
			S_OUT : coeff_add = {4'd0, KERNEL0_BIAS, 16'd0};
			S_ADD2: coeff_add = data_r;
			S_OUT2: coeff_add = {4'b1111, KERNEL1_BIAS, 16'd0};
			default: coeff_add = 0;
		endcase
	end

	// coordinate
	assign case1 = &(~count_pixel_r[5 : 0]); 
	assign case2 = &(~count_pixel_r[11 : 6]);
	assign case3 = &(count_pixel_r[5 : 0]);
	assign case4 = &(count_pixel_r[11 : 6]);
	assign cases = {case1, case2, case3, case4};

	reg [11:0] coord_temp;
	always@ (*) begin
		if(state_r==S_PREP || state_r==S_PREP2) begin
			coord_temp = count_pixel_r;
		end
		else begin
			if (&(~count_pixel_r[4:0]))
				coord_temp = count_pixel_r << 2;
			else
				coord_temp = {count_pixel_r[9:5], 7'd0} + {6'd0, {count_pixel_r[4:0]} , 1'd0};
		end
	end

	assign coord0 = coord_temp - 11'd65;	
	assign coord1 = coord_temp - 11'd64;
	assign coord2 = coord_temp - 11'd63;
	assign coord3 = coord_temp - 11'd1;
	assign coord4 = coord_temp;	
	assign coord5 = coord_temp + 11'd1;	
	assign coord6 = coord_temp + 11'd63;
	assign coord7 = coord_temp + 11'd64;
	assign coord8 = coord_temp + 11'd65;

	always@ (*) begin
		if(is_zero && (state_r==S_PREP || state_r==S_PREP2)) begin
			coord = 0;
		end
		else begin
			case(count_calc_r)
				4'd0:    coord = (state_r==S_PREP3 || state_r==S_PREP4) ? coord4 : coord0;
				4'd1:    coord = (state_r==S_PREP3 || state_r==S_PREP4) ? coord5 : coord1;
				4'd2:    coord = (state_r==S_PREP3 || state_r==S_PREP4) ? coord7 : coord2;
				4'd3:    coord = (state_r==S_PREP3 || state_r==S_PREP4) ? coord8 : coord3;
				4'd4:    coord = coord4;
				4'd5:    coord = coord5;
				4'd6:    coord = coord6;
				4'd7:    coord = coord7;
				4'd8:    coord = coord8;
				default: coord = 0;
			endcase
		end
	end

	// load data
	always@ (*) begin
		case(cases)
			4'b1000: load_data = (is_zero) ? 0 : idata;
			4'b0100: load_data = (is_zero) ? 0 : idata;
			4'b0010: load_data = (is_zero) ? 0 : idata;
			4'b0001: load_data = (is_zero) ? 0 : idata;
			4'b1100: load_data = (is_zero) ? 0 : idata;
			4'b0110: load_data = (is_zero) ? 0 : idata;
			4'b0011: load_data = (is_zero) ? 0 : idata;
			4'b1001: load_data = (is_zero) ? 0 : idata;
			4'b0000: load_data = idata;
			default: load_data = idata;
		endcase
	end	

	always@ (*) begin
		case(cases)
			4'b1000: begin
				case(count_calc_r)
					4'd0:    is_zero = 1;
					4'd1:    is_zero = 0;
					4'd2:    is_zero = 0;
					4'd3:    is_zero = 1;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 0;
					4'd6:    is_zero = 1;
					4'd7:    is_zero = 0;
					4'd8:    is_zero = 0;
					default: is_zero = 0;
				endcase
			end
			
			4'b0100: begin
				case(count_calc_r)
					4'd0:    is_zero = 1;
					4'd1:    is_zero = 1;
					4'd2:    is_zero = 1;
					4'd3:    is_zero = 0;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 0;
					4'd6:    is_zero = 0;
					4'd7:    is_zero = 0;
					4'd8:    is_zero = 0;
					default: is_zero = 0;
				endcase
			end

			4'b0010: begin
				case(count_calc_r)
					4'd0:    is_zero = 0;
					4'd1:    is_zero = 0;
					4'd2:    is_zero = 1;
					4'd3:    is_zero = 0;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 1;
					4'd6:    is_zero = 0;
					4'd7:    is_zero = 0;
					4'd8:    is_zero = 1;
					default: is_zero = 0;
				endcase
			end
			
			4'b0001: begin
				case(count_calc_r)
					4'd0:    is_zero = 0;
					4'd1:    is_zero = 0;
					4'd2:    is_zero = 0;
					4'd3:    is_zero = 0;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 0;
					4'd6:    is_zero = 1;
					4'd7:    is_zero = 1;
					4'd8:    is_zero = 1;
					default: is_zero = 0;
				endcase
			end
			
			4'b1100: begin
				case(count_calc_r)
					4'd0:    is_zero = 1;
					4'd1:    is_zero = 1;
					4'd2:    is_zero = 1;
					4'd3:    is_zero = 1;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 0;
					4'd6:    is_zero = 1;
					4'd7:    is_zero = 0;
					4'd8:    is_zero = 0;
					default: is_zero = 0;
				endcase
			end
			
			4'b0110: begin
				case(count_calc_r)
					4'd0:    is_zero = 1;
					4'd1:    is_zero = 1;
					4'd2:    is_zero = 1;
					4'd3:    is_zero = 0;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 1;
					4'd6:    is_zero = 0;
					4'd7:    is_zero = 0;
					4'd8:    is_zero = 1;
					default: is_zero = 0;
				endcase
			end
			
			4'b0011: begin
				case(count_calc_r)
					4'd0:    is_zero = 0;
					4'd1:    is_zero = 0;
					4'd2:    is_zero = 1;
					4'd3:    is_zero = 0;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 1;
					4'd6:    is_zero = 1;
					4'd7:    is_zero = 1;
					4'd8:    is_zero = 1;
					default: is_zero = 0;
				endcase
			end
			
			4'b1001: begin
				case(count_calc_r)
					4'd0:    is_zero = 1;
					4'd1:    is_zero = 0;
					4'd2:    is_zero = 0;
					4'd3:    is_zero = 1;
					4'd4:    is_zero = 0;
					4'd5:    is_zero = 0;
					4'd6:    is_zero = 1;
					4'd7:    is_zero = 1;
					4'd8:    is_zero = 1;
					default: is_zero = 0;
				endcase
			end
			
			default: is_zero = 0;
		endcase
	end

	// conv
	always@ (*) begin
		mult_result = $signed(coeff_mult) * $signed(data_r[16 +: 20]);
		conv_result = $signed({{3{coeff_add[39]}} ,coeff_add}) + $signed(result_r);
		conv_RELU_output = (conv_result[42]) ? 20'd0 : (conv_result[15]) ? (conv_result[16+:20] + 1) : conv_result[16 +: 20];
	end

	// maxpool
	always@ (*) begin
		maxpool_result = (data_r[16 +: 20] > result_r[16 +: 20]) ? data_r : result_r;
	end

endmodule
