module geofence ( clk,reset,X,Y,R,valid,is_inside);
    input clk;
    input reset;
    input [9:0] X;
    input [9:0] Y;
    input [10:0] R;
    output valid;
    output is_inside;

    parameter S_GET = 0;
    parameter S_SORT = 1;
    parameter S_SORT2 = 10;
    parameter S_AREA = 2;
    parameter S_AREA2 = 11;
    parameter S_AREA3 = 12;
    parameter S_PREP = 3;
    parameter S_PREP2 = 4;
    parameter S_PREP3 = 5;
    parameter S_SQRT = 6;
    parameter S_SQRT2 = 7;
    parameter S_SQRT3 = 8;
    parameter S_OUT = 9;

    reg [3:0] state_r, state_w;
    reg [2:0] count_r, count_w;

    reg [9:0] X_data_r[0:5], X_data_w[0:5];
    reg [9:0] Y_data_r[0:5], Y_data_w[0:5];
    reg [10:0] R_data_r[0:5], R_data_w[0:5];
    
    reg [23:0] area_r, area_w;
    reg [10:0] sqrt0_r, sqrt0_w;
    reg [10:0] sqrt1_r, sqrt1_w;

    wire count_or_not;
    wire current_S_get;
    wire current_S_sort;
    wire current_S_sort2;
    wire current_S_area;
    wire current_S_area2;
    wire current_S_area3;
    wire current_S_prep;
    wire current_S_prep2;
    wire current_S_prep3;
    wire current_S_sqrt;
    wire current_S_sqrt2;
    wire current_S_sqrt3;
    wire current_S_out;

    //for sorting
    reg exchange;
    reg [9:0] X0,X1,X2,Y0,Y1,Y2;
    reg [10:0] R1,R2;

    //for addsub
    reg [11:0] inst_A_addsub_0, inst_B_addsub_0;
    reg [11:0] inst_A_addsub_1, inst_B_addsub_1;
    reg [11:0] inst_A_addsub_2, inst_B_addsub_2;
    reg [11:0] inst_A_addsub_3, inst_B_addsub_3;
    reg [23:0] inst_A_addsub_4, inst_B_addsub_4;
    wire [11:0] SUM_inst_addsub_0;
    wire [11:0] SUM_inst_addsub_1;
    wire [11:0] SUM_inst_addsub_2;
    wire [11:0] SUM_inst_addsub_3;
    wire [23:0] SUM_inst_addsub_4;

    //for mult
    reg [11:0] inst_A_mult_0, inst_B_mult_0;
    reg [11:0] inst_A_mult_1, inst_B_mult_1;
    wire [23:0] PRODUCT_inst_mult_0, PRODUCT_inst_mult_1;

    //for sqrt
    reg [19:0] radicand_0, radicand_1;
    wire [9:0] square_root_0, square_root_1;

    assign valid = current_S_out;
    assign is_inside = !area_r[23];
    assign current_S_get = state_r==S_GET;
    assign current_S_sort = state_r==S_SORT;
    assign current_S_sort2 = state_r==S_SORT2;
    assign current_S_area = state_r==S_AREA;
    assign current_S_area2 = state_r==S_AREA2;
    assign current_S_area3 = state_r==S_AREA3;
    assign current_S_prep = state_r==S_PREP;
    assign current_S_prep2 = state_r==S_PREP2;
    assign current_S_prep3 = state_r==S_PREP3;
    assign current_S_sqrt = state_r==S_SQRT;
    assign current_S_sqrt2 = state_r==S_SQRT2;
    assign current_S_sqrt3 = state_r==S_SQRT3;
    assign current_S_out = state_r==S_OUT;
    assign count_or_not = current_S_get || current_S_sort2 || current_S_area3 || current_S_sqrt3;

    wire [2:0] count_temp, count_temp2;
    assign count_temp = count_r + 3'd1;
    assign count_temp2 = count_r + 3'd2;

    reg  [23:0] SUM_inst4_pipeline_r;
    wire [23:0] SUM_inst4_pipeline_w;
    assign SUM_inst4_pipeline_w = SUM_inst_addsub_4;

    reg  [23:0] PRODUCT_mult_pipeline0_r;
    wire [23:0] PRODUCT_mult_pipeline0_w;
    assign PRODUCT_mult_pipeline0_w = PRODUCT_inst_mult_0;

    reg  [23:0] PRODUCT_mult_pipeline1_r;
    wire [23:0] PRODUCT_mult_pipeline1_w;
    assign PRODUCT_mult_pipeline1_w = PRODUCT_inst_mult_1;

    reg inst_ADD_SUB_0, inst_ADD_SUB_1, inst_ADD_SUB_2, inst_ADD_SUB_3, inst_ADD_SUB_4;
    wire CO_inst_0;
    wire inst_CI_1;
    assign inst_CI_1 = (current_S_area3) ? CO_inst_0 : 0;

    always@ (*) begin
        if((count_r==3'd4 && current_S_sort2 && (!exchange)) || (exchange && current_S_sort2)) begin
            count_w = 0;
        end
        else if ((current_S_area3 || current_S_sqrt3) && count_r==3'd5)begin
            count_w = 0;
        end
        else if(count_or_not) begin
            count_w = count_r + 1;
        end
        else begin
            count_w = count_r;
        end
    end

    always@ (*) begin
        case(state_r) 
            S_GET:  state_w = (count_r==3'd5) ? S_SORT : S_GET;
            S_SORT: state_w = S_SORT2;
            S_SORT2: state_w = (count_r==3'd4 && (!exchange)) ? S_AREA : S_SORT;
            S_AREA: state_w = S_AREA2;
            S_AREA2: state_w = S_AREA3;
            S_AREA3: state_w = (count_r==3'd5) ? S_PREP : S_AREA;
            S_PREP: state_w = S_PREP2;
            S_PREP2: state_w = S_PREP3;
            S_PREP3: state_w = S_SQRT;
            S_SQRT: state_w = S_SQRT2;
            S_SQRT2: state_w = S_SQRT3;
            S_SQRT3: state_w = (count_r==3'd5) ? S_OUT : S_PREP;
            S_OUT: state_w = S_GET;
            default: state_w = state_r;
        endcase
    end

    always@ (*) begin
        X0 = (count_r==3'd4) ? X_data_r[1] : X_data_r[0];
        Y0 = (count_r==3'd4) ? Y_data_r[1] : Y_data_r[0];
        
        X1 = (current_S_sort || current_S_sort2) ? X_data_r[count_temp] : X_data_r[count_r];
        Y1 = (current_S_sort || current_S_sort2) ? Y_data_r[count_temp] : Y_data_r[count_r];
        R1 =  R_data_r[count_r]; 
        
        X2 = ((current_S_sort || current_S_sort2)&&(count_r!=3'd4)) ? X_data_r[count_temp2] : (((current_S_sort || current_S_sort2)&&count_r==3'd4) || (count_r==3'd5)) ? X_data_r[0] : X_data_r[count_temp];
        Y2 = ((current_S_sort || current_S_sort2)&&(count_r!=3'd4)) ? Y_data_r[count_temp2] : (((current_S_sort || current_S_sort2)&&count_r==3'd4) || (count_r==3'd5)) ? Y_data_r[0] : Y_data_r[count_temp];
        R2 = (((current_S_sort || current_S_sort2)&&count_r==3'd4) || (count_r==3'd5)) ? R_data_r[0] : R_data_r[count_temp];
    end

    always@ (*) begin
        case(state_r)
            S_SORT: begin   
                inst_A_addsub_0 = {2'd0, X1};
                inst_B_addsub_0 = {2'd0, X0};

                inst_A_addsub_1 = {2'd0, Y1};
                inst_B_addsub_1 = {2'd0, Y0};

                inst_A_addsub_2 = {2'd0, X2};
                inst_B_addsub_2 = {2'd0, X0};

                inst_A_addsub_3 = {2'd0, Y2};
                inst_B_addsub_3 = {2'd0, Y0};

                inst_ADD_SUB_0 = 1;
                inst_ADD_SUB_1 = 1;
                inst_ADD_SUB_2 = 1;
                inst_ADD_SUB_3 = 1;
            end

            S_AREA3: begin   
                inst_A_addsub_0 = SUM_inst4_pipeline_r[0 +: 12];
                inst_B_addsub_0 = area_r[0 +: 12];

                inst_A_addsub_1 = SUM_inst4_pipeline_r[12 +: 12];
                inst_B_addsub_1 = area_r[12 +: 12];

                inst_A_addsub_2 = 0;
                inst_B_addsub_2 = 0;

                inst_A_addsub_3 = 0;
                inst_B_addsub_3 = 0;

                inst_ADD_SUB_0 = 0;
                inst_ADD_SUB_1 = 0;
                inst_ADD_SUB_2 = 0;
                inst_ADD_SUB_3 = 0;
            end

            S_PREP: begin
                inst_A_addsub_0 = {2'd0, X2};
                inst_B_addsub_0 = {2'd0, X1};

                inst_A_addsub_1 = {2'd0, Y2};
                inst_B_addsub_1 = {2'd0, Y1};

                inst_A_addsub_2 = 0;
                inst_B_addsub_2 = 0;

                inst_A_addsub_3 = 0;
                inst_B_addsub_3 = 0;

                inst_ADD_SUB_0 = 1;
                inst_ADD_SUB_1 = 1;
                inst_ADD_SUB_2 = 0;
                inst_ADD_SUB_3 = 0;
            end

            S_PREP3: begin
                inst_A_addsub_0 = 0;
                inst_B_addsub_0 = 0;

                inst_A_addsub_1 = 0;
                inst_B_addsub_1 = 0;

                inst_A_addsub_2 = {1'd0, sqrt1_r};
                inst_B_addsub_2 = {1'd0, R1};

                inst_A_addsub_3 = SUM_inst_addsub_2;
                inst_B_addsub_3 = {2'd0, R2};

                inst_ADD_SUB_0 = 1;
                inst_ADD_SUB_1 = 1;
                inst_ADD_SUB_2 = 0;
                inst_ADD_SUB_3 = 0;
            end

            S_SQRT: begin
                inst_A_addsub_0 = {1'd0, sqrt0_r};
                inst_B_addsub_0 = {1'd0, sqrt1_r};

                inst_A_addsub_1 = {1'd0, sqrt0_r};
                inst_B_addsub_1 = {1'd0, R1};

                inst_A_addsub_2 = {1'd0, sqrt0_r};
                inst_B_addsub_2 = {1'd0, R2};

                inst_A_addsub_3 = 0;
                inst_B_addsub_3 = 0;

                inst_ADD_SUB_0 = 1;
                inst_ADD_SUB_1 = 1;
                inst_ADD_SUB_2 = 1;
                inst_ADD_SUB_3 = 0;
            end

            default: begin
                inst_A_addsub_0 = 0;
                inst_B_addsub_0 = 0;

                inst_A_addsub_1 = 0;
                inst_B_addsub_1 = 0;

                inst_A_addsub_2 = 0;
                inst_B_addsub_2 = 0;

                inst_A_addsub_3 = 0;
                inst_B_addsub_3 = 0;

                inst_ADD_SUB_0 =  0;
                inst_ADD_SUB_1 =  0;
                inst_ADD_SUB_2 =  0;
                inst_ADD_SUB_3 =  0;
            end
        endcase
    end

    always@ (*) begin
        case(state_r)
            S_SORT: begin
                inst_A_mult_0 = SUM_inst_addsub_0;
                inst_B_mult_0 = SUM_inst_addsub_3;

                inst_A_mult_1 = SUM_inst_addsub_1;
                inst_B_mult_1 = SUM_inst_addsub_2;
            end

            S_AREA: begin
                inst_A_mult_0 = {2'd0, X1};
                inst_B_mult_0 = {2'd0, Y2};

                inst_A_mult_1 = {2'd0, X2};
                inst_B_mult_1 = {2'd0, Y1};
            end

            S_PREP: begin
                inst_A_mult_0 = SUM_inst_addsub_0;
                inst_B_mult_0 = SUM_inst_addsub_0;

                inst_A_mult_1 = SUM_inst_addsub_1;
                inst_B_mult_1 = SUM_inst_addsub_1;
            end

            S_SQRT: begin
                inst_A_mult_0 = {2'd0, sqrt0_r};
                inst_B_mult_0 = (SUM_inst_addsub_0[11]) ? (~SUM_inst_addsub_0+1) : SUM_inst_addsub_0;

                inst_A_mult_1 = (SUM_inst_addsub_1[11]) ? (~SUM_inst_addsub_1+1) : SUM_inst_addsub_1;
                inst_B_mult_1 = (SUM_inst_addsub_2[11]) ? (~SUM_inst_addsub_2+1) : SUM_inst_addsub_2;
            end

            S_SQRT3: begin
                inst_A_mult_0 = {1'd0, sqrt0_r};
                inst_B_mult_0 = {1'd0, sqrt1_r};

                inst_A_mult_1 = 0;
                inst_B_mult_1 = 0;
            end 

            default: begin
                inst_A_mult_0 = 0;
                inst_B_mult_0 = 0;

                inst_A_mult_1 = 0;
                inst_B_mult_1 = 0;
            end
        endcase
    end


    //----------------------------------------------------------//
    // main calculation elements
    assign PRODUCT_inst_mult_0 = $signed(inst_A_mult_0) * $signed(inst_B_mult_0);
    assign PRODUCT_inst_mult_1 = $signed(inst_A_mult_1) * $signed(inst_B_mult_1);
    DW01_addsub_inst #(.width(12)) addsub0 (.inst_A(inst_A_addsub_0), .inst_B(inst_B_addsub_0), .inst_CI(1'd0), .inst_ADD_SUB(inst_ADD_SUB_0), .SUM_inst(SUM_inst_addsub_0), .CO_inst(CO_inst_0));
    DW01_addsub_inst #(.width(12)) addsub1 (.inst_A(inst_A_addsub_1), .inst_B(inst_B_addsub_1), .inst_CI(inst_CI_1), .inst_ADD_SUB(inst_ADD_SUB_1), .SUM_inst(SUM_inst_addsub_1), .CO_inst());
    DW01_addsub_inst #(.width(12)) addsub2 (.inst_A(inst_A_addsub_2), .inst_B(inst_B_addsub_2), .inst_CI(1'd0), .inst_ADD_SUB(inst_ADD_SUB_2), .SUM_inst(SUM_inst_addsub_2), .CO_inst());
    DW01_addsub_inst #(.width(12)) addsub3 (.inst_A(inst_A_addsub_3), .inst_B(inst_B_addsub_3), .inst_CI(1'd0), .inst_ADD_SUB(inst_ADD_SUB_3), .SUM_inst(SUM_inst_addsub_3), .CO_inst());
    DW01_addsub_inst #(.width(24)) addsub4 (.inst_A(inst_A_addsub_4), .inst_B(inst_B_addsub_4), .inst_CI(1'd0), .inst_ADD_SUB(inst_ADD_SUB_4), .SUM_inst(SUM_inst_addsub_4), .CO_inst());

    DW_sqrt_inst #(.radicand_width(20), .tc_mode(0)) sqrt0 (.radicand(radicand_0), .square_root(square_root_0));
    DW_sqrt_inst #(.radicand_width(20), .tc_mode(0)) sqrt1 (.radicand(radicand_1), .square_root(square_root_1));
    //----------------------------------------------------------//


    always@ (*) begin
        case(state_r)
            S_SORT2: begin
                inst_A_addsub_4 = PRODUCT_mult_pipeline0_r;
                inst_B_addsub_4 = PRODUCT_mult_pipeline1_r;
                inst_ADD_SUB_4 = 1;
            end

            S_AREA2: begin
                inst_A_addsub_4 = PRODUCT_mult_pipeline0_r;
                inst_B_addsub_4 = PRODUCT_mult_pipeline1_r;
                inst_ADD_SUB_4 = 1;
            end

            S_PREP: begin
                inst_A_addsub_4 = PRODUCT_inst_mult_0;
                inst_B_addsub_4 = PRODUCT_inst_mult_1;
                inst_ADD_SUB_4 = 0;
            end

            S_SQRT3: begin
                inst_A_addsub_4 = area_r;
                inst_B_addsub_4 = PRODUCT_inst_mult_0;
                inst_ADD_SUB_4 = 1;
            end

            default: begin
                inst_A_addsub_4 = 0;
                inst_B_addsub_4 = 0;
                inst_ADD_SUB_4 = 0;
            end 
        endcase
    end

    always@ (*) begin
        case(state_r) 
            S_PREP2: begin
                radicand_0 = SUM_inst4_pipeline_r[0 +: 20];
                radicand_1 = 0;
            end

            S_SQRT2: begin
                radicand_0 = PRODUCT_mult_pipeline0_r[0 +: 20];
                radicand_1 = PRODUCT_mult_pipeline1_r[0 +: 20];
            end

            default: begin
                radicand_0 = 0;
                radicand_1 = 0;
            end
        endcase
    end

    always@ (*) begin
        if(current_S_prep2) begin
            sqrt0_w = 0;
            sqrt1_w = {1'd0, square_root_0};
        end
        else if(current_S_prep3) begin
            sqrt0_w = SUM_inst_addsub_3[1 +: 11];
            sqrt1_w = sqrt1_r;
        end
        else if(current_S_sqrt2) begin
            sqrt0_w = {1'd0, square_root_0};
            sqrt1_w = {1'd0, square_root_1};
        end
        else begin
            sqrt0_w = sqrt0_r;
            sqrt1_w = sqrt1_r;
        end
    end

    always@ (*) begin
        if(current_S_get) begin
            area_w = 0;
        end
        else if(current_S_area3 && count_r!=3'd5) begin
            area_w = {SUM_inst_addsub_1, SUM_inst_addsub_0};
        end
        else if(current_S_area3 && count_r==3'd5) begin
            area_w = {SUM_inst_addsub_1, SUM_inst_addsub_0} >> 1;
        end
        else if(current_S_sqrt3) begin
            area_w = SUM_inst_addsub_4;
        end
        else begin
            area_w = area_r;
        end
    end

    always@ (*) begin
        exchange = SUM_inst_addsub_4[23] && current_S_sort2;
    end

    integer j;
    always@ (*) begin
        for(j=0; j<=5; j=j+1) begin
            X_data_w[j] = X_data_r[j];
            Y_data_w[j] = Y_data_r[j];
            R_data_w[j] = R_data_r[j];
        end

        if(current_S_get) begin
            X_data_w[0] = X_data_r[1];
            Y_data_w[0] = Y_data_r[1];
            R_data_w[0] = R_data_r[1];

            X_data_w[1] = X_data_r[2];
            Y_data_w[1] = Y_data_r[2];
            R_data_w[1] = R_data_r[2];

            X_data_w[2] = X_data_r[3];
            Y_data_w[2] = Y_data_r[3];
            R_data_w[2] = R_data_r[3];

            X_data_w[3] = X_data_r[4];
            Y_data_w[3] = Y_data_r[4];
            R_data_w[3] = R_data_r[4];

            X_data_w[4] = X_data_r[5];
            Y_data_w[4] = Y_data_r[5];
            R_data_w[4] = R_data_r[5];

            X_data_w[5] = X;
            Y_data_w[5] = Y;
            R_data_w[5] = R;
        end
        else if(exchange) begin
            if(count_r==3'd4) begin
                X_data_w[0] = X_data_r[5];
                X_data_w[5] = X_data_r[0];
                Y_data_w[0] = Y_data_r[5];
                Y_data_w[5] = Y_data_r[0];
                R_data_w[0] = R_data_r[5];
                R_data_w[5] = R_data_r[0];
            end
            else begin
                X_data_w[count_temp] = X2;
                X_data_w[count_temp2] = X1;
                Y_data_w[count_temp] = Y2;
                Y_data_w[count_temp2] = Y1;
                R_data_w[count_temp] = R_data_r[count_temp2];
                R_data_w[count_temp2] = R_data_r[count_temp];
            end
        end
    end

    integer i;
    always@ (posedge clk or posedge reset) begin
        if(reset) begin
            state_r <= 0;
            count_r <= 0;

            area_r <= 0;
            sqrt0_r <= 0;
            sqrt1_r <= 0;

            SUM_inst4_pipeline_r <= 0;
            PRODUCT_mult_pipeline0_r <= 0;
            PRODUCT_mult_pipeline1_r <= 0;

            for(i=0; i<=5; i=i+1) begin
                X_data_r[i] <= 0;
                Y_data_r[i] <= 0;
                R_data_r[i] <= 0;
            end
        end
        else begin
            state_r <= state_w;
            count_r <= count_w;

            area_r <= area_w;
            sqrt0_r <= sqrt0_w;
            sqrt1_r <= sqrt1_w;

            SUM_inst4_pipeline_r <= SUM_inst4_pipeline_w;
            PRODUCT_mult_pipeline0_r <= PRODUCT_mult_pipeline0_w;
            PRODUCT_mult_pipeline1_r <= PRODUCT_mult_pipeline1_w;

            for(i=0; i<=5; i=i+1) begin
                X_data_r[i] <= X_data_w[i];
                Y_data_r[i] <= Y_data_w[i];
                R_data_r[i] <= R_data_w[i];
            end
        end
    end
endmodule

module DW01_addsub_inst( inst_A, inst_B, inst_CI, inst_ADD_SUB, SUM_inst, CO_inst );
    parameter width = 8;
    
    input [width-1 : 0] inst_A;
    input [width-1 : 0] inst_B;
    input inst_CI;
    input inst_ADD_SUB;
    output [width-1 : 0] SUM_inst;
    output CO_inst;

    // Instance of DW01_addsub
    DW01_addsub #(width)
    U1 ( .A(inst_A), .B(inst_B), .CI(inst_CI), .ADD_SUB(inst_ADD_SUB), .SUM(SUM_inst), .CO(CO_inst) );
endmodule


module DW_sqrt_inst (radicand, square_root);
    parameter radicand_width = 8;
    parameter tc_mode = 0;

    input [radicand_width-1 : 0] radicand;
    output [(radicand_width+1)/2-1 : 0] square_root;
    // Please add +incdir+$SYNOPSYS/dw/sim_ver+ to your verilog simulator
    // command line (for simulation).
    // instance of DW_sqrt
    DW_sqrt #(radicand_width, tc_mode)
    U1 (.a(radicand), .root(square_root));
endmodule
