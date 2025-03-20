/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06
// Date      : Thu Mar 20 23:09:05 2025
/////////////////////////////////////////////////////////////


module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, 
        lbp_valid, lbp_data, finish );
  output [13:0] gray_addr;
  input [7:0] gray_data;
  output [13:0] lbp_addr;
  output [7:0] lbp_data;
  input clk, reset, gray_ready;
  output gray_req, lbp_valid, finish;
  wire   n393, n394, n395, n396, n397, n398, n399, finish_w, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n96, n97, n98, n99, n100, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n328,
         n330, n332, n334, n336, n338, n340, n342, n344, n346, n348, n350,
         n352, n354, n356, n358, n360, n362, n364, n366, n368, n370, n372,
         n374, n375, n376, n377, n378, n379, n380, n381, n382, n384, n389,
         n390, n391, n392;
  wire   [3:0] state_r;
  wire   [3:0] state_w;
  wire   [13:0] lbp_addr_w;
  wire   [7:0] cur_data_r;
  wire   [7:0] lbp_data_w;

  DFFRX1 \cur_data_r_reg[7]  ( .D(n87), .CK(clk), .RN(n392), .Q(cur_data_r[7]), 
        .QN(n317) );
  DFFRX1 \cur_data_r_reg[0]  ( .D(n86), .CK(clk), .RN(n392), .QN(n323) );
  DFFRX1 \cur_data_r_reg[1]  ( .D(n85), .CK(clk), .RN(n392), .QN(n315) );
  DFFRX1 \cur_data_r_reg[2]  ( .D(n84), .CK(clk), .RN(n392), .Q(cur_data_r[2]), 
        .QN(n320) );
  DFFRX1 \cur_data_r_reg[3]  ( .D(n83), .CK(clk), .RN(n392), .Q(cur_data_r[3]), 
        .QN(n316) );
  DFFRX1 \cur_data_r_reg[4]  ( .D(n82), .CK(clk), .RN(n392), .Q(cur_data_r[4]), 
        .QN(n321) );
  DFFRX1 \cur_data_r_reg[5]  ( .D(n81), .CK(clk), .RN(n392), .Q(cur_data_r[5]), 
        .QN(n322) );
  DFFRX1 \cur_data_r_reg[6]  ( .D(n80), .CK(clk), .RN(n392), .Q(cur_data_r[6]), 
        .QN(n324) );
  DFFRX1 \count_col_r_reg[6]  ( .D(n79), .CK(clk), .RN(n392), .Q(lbp_addr_w[6]), .QN(n319) );
  DFFRX1 \lbp_data_r_reg[6]  ( .D(lbp_data_w[6]), .CK(clk), .RN(n392), .Q(n393), .QN(n372) );
  DFFRX1 \lbp_data_r_reg[5]  ( .D(lbp_data_w[5]), .CK(clk), .RN(n392), .Q(n394), .QN(n370) );
  DFFRX1 \lbp_data_r_reg[4]  ( .D(lbp_data_w[4]), .CK(clk), .RN(n392), .Q(n395), .QN(n368) );
  DFFRX1 \lbp_data_r_reg[3]  ( .D(lbp_data_w[3]), .CK(clk), .RN(n392), .Q(n396), .QN(n366) );
  DFFRX1 \lbp_data_r_reg[2]  ( .D(lbp_data_w[2]), .CK(clk), .RN(n392), .Q(n397), .QN(n364) );
  DFFRX1 \lbp_data_r_reg[1]  ( .D(lbp_data_w[1]), .CK(clk), .RN(n392), .Q(n398), .QN(n362) );
  DFFRX1 \lbp_data_r_reg[0]  ( .D(lbp_data_w[0]), .CK(clk), .RN(n392), .Q(n399), .QN(n360) );
  DFFRX1 \lbp_addr_r_reg[13]  ( .D(lbp_addr_w[13]), .CK(clk), .RN(n392), .QN(
        n358) );
  DFFRX1 \lbp_addr_r_reg[12]  ( .D(lbp_addr_w[12]), .CK(clk), .RN(n392), .QN(
        n356) );
  DFFRX1 \lbp_addr_r_reg[11]  ( .D(lbp_addr_w[11]), .CK(clk), .RN(n392), .QN(
        n354) );
  DFFRX1 \lbp_addr_r_reg[10]  ( .D(lbp_addr_w[10]), .CK(clk), .RN(n392), .QN(
        n352) );
  DFFRX1 \lbp_addr_r_reg[9]  ( .D(lbp_addr_w[9]), .CK(clk), .RN(n392), .QN(
        n350) );
  DFFRX1 \lbp_addr_r_reg[8]  ( .D(lbp_addr_w[8]), .CK(clk), .RN(n392), .QN(
        n348) );
  DFFRX1 \lbp_addr_r_reg[7]  ( .D(lbp_addr_w[7]), .CK(clk), .RN(n392), .QN(
        n346) );
  DFFRX1 \lbp_addr_r_reg[6]  ( .D(lbp_addr_w[6]), .CK(clk), .RN(n392), .QN(
        n344) );
  DFFRX1 \lbp_addr_r_reg[5]  ( .D(n318), .CK(clk), .RN(n392), .QN(n342) );
  DFFRX1 \lbp_addr_r_reg[4]  ( .D(lbp_addr_w[4]), .CK(clk), .RN(n392), .QN(
        n340) );
  DFFRX1 \lbp_addr_r_reg[3]  ( .D(lbp_addr_w[3]), .CK(clk), .RN(n392), .QN(
        n338) );
  DFFRX1 \lbp_addr_r_reg[2]  ( .D(lbp_addr_w[2]), .CK(clk), .RN(n392), .QN(
        n336) );
  DFFRX1 \lbp_addr_r_reg[1]  ( .D(lbp_addr_w[1]), .CK(clk), .RN(n392), .QN(
        n334) );
  DFFRX1 \lbp_addr_r_reg[0]  ( .D(n314), .CK(clk), .RN(n392), .QN(n332) );
  DFFRX1 lbp_valid_r_reg ( .D(n391), .CK(clk), .RN(n392), .QN(n330) );
  DFFRX1 \lbp_data_r_reg[7]  ( .D(lbp_data_w[7]), .CK(clk), .RN(n392), .QN(
        n328) );
  DFFRX1 finish_reg ( .D(finish_w), .CK(clk), .RN(n392), .QN(n326) );
  DFFRX4 \state_r_reg[3]  ( .D(state_w[3]), .CK(clk), .RN(n392), .Q(state_r[3]), .QN(n384) );
  DFFRX4 \count_col_r_reg[1]  ( .D(n78), .CK(clk), .RN(n392), .Q(lbp_addr_w[1]), .QN(n376) );
  DFFRX4 \state_r_reg[2]  ( .D(state_w[2]), .CK(clk), .RN(n392), .Q(n102), 
        .QN(n381) );
  DFFRX4 \count_row_r_reg[3]  ( .D(n90), .CK(clk), .RN(n392), .Q(
        lbp_addr_w[10]), .QN(n374) );
  DFFRX2 \count_col_r_reg[4]  ( .D(n75), .CK(clk), .RN(n392), .Q(lbp_addr_w[4]), .QN(n378) );
  DFFRX4 \state_r_reg[0]  ( .D(state_w[0]), .CK(clk), .RN(n392), .Q(state_r[0]), .QN(n380) );
  DFFRX4 \count_col_r_reg[2]  ( .D(n77), .CK(clk), .RN(n392), .Q(lbp_addr_w[2]), .QN(n377) );
  DFFSX4 \count_row_r_reg[0]  ( .D(n94), .CK(clk), .SN(n392), .Q(lbp_addr_w[7]), .QN(n390) );
  DFFSHQX4 \count_col_r_reg[0]  ( .D(n73), .CK(clk), .SN(n392), .Q(
        lbp_addr_w[0]) );
  DFFRX4 \state_r_reg[1]  ( .D(state_w[1]), .CK(clk), .RN(n392), .Q(state_r[1]), .QN(n382) );
  DFFRX2 \count_row_r_reg[6]  ( .D(n93), .CK(clk), .RN(n392), .Q(
        lbp_addr_w[13]), .QN(n325) );
  DFFSRHQX4 \count_col_r_reg[5]  ( .D(n74), .CK(clk), .SN(1'b1), .RN(n392), 
        .Q(n318) );
  DFFRX4 \count_row_r_reg[1]  ( .D(n92), .CK(clk), .RN(n392), .Q(lbp_addr_w[8]), .QN(n375) );
  DFFSRHQX4 \count_col_r_reg[3]  ( .D(n76), .CK(clk), .SN(1'b1), .RN(n392), 
        .Q(lbp_addr_w[3]) );
  DFFSRHQX4 \count_row_r_reg[2]  ( .D(n91), .CK(clk), .SN(1'b1), .RN(n392), 
        .Q(lbp_addr_w[9]) );
  DFFRX2 \count_row_r_reg[4]  ( .D(n89), .CK(clk), .RN(n392), .Q(
        lbp_addr_w[11]), .QN(n389) );
  DFFRX2 \count_row_r_reg[5]  ( .D(n88), .CK(clk), .RN(n392), .Q(
        lbp_addr_w[12]), .QN(n379) );
  INVX12 U126 ( .A(n176), .Y(gray_req) );
  NOR2X1 U127 ( .A(n196), .B(n292), .Y(n294) );
  INVX6 U128 ( .A(n263), .Y(n264) );
  INVX6 U129 ( .A(n98), .Y(n100) );
  NAND2X6 U130 ( .A(n124), .B(n117), .Y(n227) );
  NOR2X6 U131 ( .A(n246), .B(n143), .Y(n144) );
  NOR3X6 U132 ( .A(n161), .B(n159), .C(n158), .Y(n157) );
  NOR3X6 U133 ( .A(n103), .B(n260), .C(n107), .Y(n155) );
  MX2X4 U134 ( .A(n228), .B(n258), .S0(n314), .Y(n229) );
  MXI2X4 U135 ( .A(n212), .B(n211), .S0(n390), .Y(n213) );
  INVX1 U136 ( .A(n307), .Y(n310) );
  NOR2X4 U137 ( .A(n193), .B(n292), .Y(n306) );
  NAND2X2 U138 ( .A(n293), .B(n273), .Y(n148) );
  AND2X4 U139 ( .A(n160), .B(lbp_addr_w[11]), .Y(n159) );
  NOR2X2 U140 ( .A(n116), .B(n273), .Y(n228) );
  INVX4 U141 ( .A(n133), .Y(n128) );
  NAND2X2 U142 ( .A(n106), .B(n97), .Y(n105) );
  AND2X4 U143 ( .A(n288), .B(n297), .Y(n158) );
  INVX3 U144 ( .A(n156), .Y(n107) );
  AND2X4 U145 ( .A(n119), .B(n118), .Y(n117) );
  INVX3 U146 ( .A(n391), .Y(n292) );
  INVXL U147 ( .A(n196), .Y(n193) );
  AO21XL U148 ( .A0(n274), .A1(lbp_addr_w[10]), .B0(n241), .Y(n243) );
  NAND2X1 U149 ( .A(n287), .B(n389), .Y(n162) );
  CLKINVX3 U150 ( .A(n126), .Y(n139) );
  NAND2X4 U151 ( .A(n250), .B(lbp_addr_w[1]), .Y(n156) );
  NOR2BX2 U152 ( .AN(n192), .B(n154), .Y(n132) );
  XNOR2X1 U153 ( .A(n279), .B(n389), .Y(n297) );
  NAND2X4 U154 ( .A(n152), .B(n130), .Y(n133) );
  NAND3X4 U155 ( .A(n123), .B(n121), .C(n120), .Y(n119) );
  NAND2X2 U156 ( .A(n253), .B(n258), .Y(n134) );
  NOR2X1 U157 ( .A(n167), .B(n166), .Y(n169) );
  OR2X6 U158 ( .A(n270), .B(n318), .Y(n123) );
  CLKINVX1 U159 ( .A(lbp_addr_w[3]), .Y(n205) );
  INVX8 U160 ( .A(n286), .Y(n126) );
  NOR2X1 U161 ( .A(n389), .B(n379), .Y(n192) );
  NAND2BX1 U162 ( .AN(lbp_addr_w[12]), .B(lbp_addr_w[11]), .Y(n140) );
  NAND2X1 U163 ( .A(n266), .B(lbp_addr_w[4]), .Y(n125) );
  NAND3X1 U164 ( .A(n285), .B(lbp_addr_w[12]), .C(n389), .Y(n238) );
  NOR2X1 U165 ( .A(n114), .B(lbp_addr_w[4]), .Y(n269) );
  NAND2X4 U166 ( .A(n242), .B(n282), .Y(n287) );
  NOR2BX2 U167 ( .AN(n247), .B(n104), .Y(n113) );
  OAI21X2 U168 ( .A0(n314), .A1(n257), .B0(n116), .Y(n259) );
  AND2X4 U169 ( .A(n224), .B(n223), .Y(n137) );
  CLKINVX1 U170 ( .A(gray_data[5]), .Y(n187) );
  INVX4 U171 ( .A(n249), .Y(n268) );
  INVX1 U172 ( .A(n256), .Y(n257) );
  NAND2BX1 U173 ( .AN(n319), .B(n115), .Y(n114) );
  AND2X4 U174 ( .A(n249), .B(n378), .Y(n254) );
  NAND2X1 U175 ( .A(n220), .B(n109), .Y(n224) );
  INVX1 U176 ( .A(n282), .Y(n153) );
  NOR2X1 U177 ( .A(n378), .B(n115), .Y(n265) );
  NOR2X4 U178 ( .A(n191), .B(n244), .Y(n279) );
  NAND2X2 U179 ( .A(lbp_addr_w[9]), .B(lbp_addr_w[10]), .Y(n191) );
  INVX3 U180 ( .A(n244), .Y(n248) );
  NAND2X6 U181 ( .A(n179), .B(n177), .Y(n282) );
  INVX4 U182 ( .A(n242), .Y(n281) );
  CLKINVX1 U183 ( .A(gray_data[2]), .Y(n183) );
  NAND2X4 U184 ( .A(n390), .B(n375), .Y(n274) );
  OR2X4 U185 ( .A(lbp_addr_w[10]), .B(lbp_addr_w[9]), .Y(n237) );
  NAND2X6 U186 ( .A(n215), .B(n146), .Y(n218) );
  NAND2X4 U187 ( .A(n215), .B(n108), .Y(n226) );
  NAND2X2 U188 ( .A(n380), .B(n384), .Y(n216) );
  CLKINVX3 U189 ( .A(n178), .Y(n174) );
  OAI22X1 U190 ( .A0(cur_data_r[2]), .A1(n183), .B0(n188), .B1(cur_data_r[3]), 
        .Y(n163) );
  NAND2X4 U191 ( .A(n258), .B(n110), .Y(n250) );
  NAND2X2 U192 ( .A(n131), .B(n325), .Y(n130) );
  AND3X2 U193 ( .A(n284), .B(n285), .C(lbp_addr_w[13]), .Y(n96) );
  AND2X2 U194 ( .A(n287), .B(n140), .Y(n97) );
  AO21X2 U195 ( .A0(n301), .A1(n288), .B0(n111), .Y(n98) );
  AND2X2 U196 ( .A(n273), .B(n291), .Y(n99) );
  INVX3 U197 ( .A(n126), .Y(n212) );
  INVX12 U198 ( .A(n137), .Y(n273) );
  CLKINVX1 U199 ( .A(n195), .Y(n182) );
  NOR2X4 U200 ( .A(n219), .B(n230), .Y(n266) );
  NAND2X4 U201 ( .A(n273), .B(n290), .Y(n124) );
  NAND2X6 U202 ( .A(n208), .B(n207), .Y(n286) );
  AND2X4 U203 ( .A(n239), .B(n238), .Y(n106) );
  AND2X1 U204 ( .A(n195), .B(n396), .Y(lbp_data_w[4]) );
  AND2X1 U205 ( .A(n195), .B(n399), .Y(lbp_data_w[1]) );
  AND2X1 U206 ( .A(n195), .B(n398), .Y(lbp_data_w[2]) );
  NAND2X1 U207 ( .A(n207), .B(n200), .Y(state_w[1]) );
  AND2X1 U208 ( .A(n195), .B(n395), .Y(lbp_data_w[5]) );
  AND2X1 U209 ( .A(n195), .B(n393), .Y(lbp_data_w[7]) );
  AND2X1 U210 ( .A(n195), .B(n394), .Y(lbp_data_w[6]) );
  INVX6 U211 ( .A(n200), .Y(n180) );
  INVX3 U212 ( .A(n279), .Y(n154) );
  NAND2X2 U213 ( .A(n279), .B(lbp_addr_w[11]), .Y(n240) );
  CLKINVX1 U214 ( .A(gray_data[7]), .Y(n184) );
  CLKINVX1 U215 ( .A(gray_data[6]), .Y(n185) );
  NAND2X1 U216 ( .A(n306), .B(n295), .Y(n296) );
  NAND2X1 U217 ( .A(n306), .B(n297), .Y(n298) );
  NAND2X1 U218 ( .A(n306), .B(n304), .Y(n305) );
  NOR2X1 U219 ( .A(n198), .B(n292), .Y(finish_w) );
  NAND2X1 U220 ( .A(gray_data[1]), .B(n310), .Y(n309) );
  NAND2X1 U221 ( .A(gray_data[0]), .B(n310), .Y(n308) );
  AND2X4 U222 ( .A(n173), .B(n195), .Y(lbp_data_w[0]) );
  NAND2X2 U223 ( .A(n235), .B(n234), .Y(n236) );
  NOR2X4 U224 ( .A(n268), .B(n122), .Y(n121) );
  INVX1 U225 ( .A(n289), .Y(n194) );
  NAND2X1 U226 ( .A(n198), .B(n281), .Y(n201) );
  NAND2X6 U227 ( .A(n180), .B(n102), .Y(n208) );
  XOR2X2 U228 ( .A(n206), .B(n205), .Y(n233) );
  NAND2X2 U229 ( .A(n266), .B(n265), .Y(n267) );
  NAND4X1 U230 ( .A(n196), .B(n241), .C(n190), .D(n390), .Y(n198) );
  NAND2X6 U231 ( .A(state_r[1]), .B(n203), .Y(n200) );
  INVX1 U232 ( .A(n303), .Y(n112) );
  OR2X4 U233 ( .A(n216), .B(n381), .Y(n217) );
  INVX1 U234 ( .A(gray_data[3]), .Y(n188) );
  INVX1 U235 ( .A(gray_data[4]), .Y(n186) );
  NAND2X6 U236 ( .A(n382), .B(n175), .Y(n242) );
  NOR2X4 U237 ( .A(n380), .B(n145), .Y(n146) );
  NOR2X4 U238 ( .A(n145), .B(n109), .Y(n108) );
  NAND2X1 U239 ( .A(n272), .B(n318), .Y(n118) );
  NAND2X8 U240 ( .A(n226), .B(n225), .Y(n272) );
  AOI2BB2X4 U241 ( .B0(n304), .B1(n288), .A0N(n274), .A1N(n278), .Y(n275) );
  NAND2X4 U242 ( .A(n248), .B(lbp_addr_w[9]), .Y(n245) );
  NAND2X4 U243 ( .A(lbp_addr_w[2]), .B(lbp_addr_w[3]), .Y(n230) );
  AOI22X2 U244 ( .A0(n233), .A1(n273), .B0(lbp_addr_w[3]), .B1(n272), .Y(n234)
         );
  NAND2X4 U245 ( .A(lbp_addr_w[8]), .B(lbp_addr_w[7]), .Y(n244) );
  INVX4 U246 ( .A(n272), .Y(n258) );
  NAND2X2 U247 ( .A(n288), .B(n299), .Y(n142) );
  NAND2X2 U248 ( .A(n284), .B(n285), .Y(n131) );
  NOR2X4 U249 ( .A(n174), .B(n102), .Y(n175) );
  INVX3 U250 ( .A(lbp_addr_w[9]), .Y(n303) );
  XNOR2X1 U251 ( .A(n248), .B(n303), .Y(n301) );
  NAND2X2 U252 ( .A(n220), .B(n199), .Y(n210) );
  XNOR2X1 U253 ( .A(n375), .B(lbp_addr_w[7]), .Y(n304) );
  CLKINVX1 U254 ( .A(lbp_addr_w[0]), .Y(n197) );
  NOR2X1 U255 ( .A(n378), .B(n318), .Y(n122) );
  AND2X2 U256 ( .A(n384), .B(n381), .Y(n222) );
  NOR2X6 U257 ( .A(n380), .B(state_r[3]), .Y(n179) );
  NOR2X4 U258 ( .A(n251), .B(n268), .Y(n260) );
  NAND2X1 U259 ( .A(n231), .B(n230), .Y(n232) );
  CLKBUFX8 U260 ( .A(n249), .Y(n116) );
  INVXL U261 ( .A(n285), .Y(n280) );
  XNOR2X1 U262 ( .A(n204), .B(n377), .Y(n262) );
  XNOR2X2 U263 ( .A(n266), .B(n378), .Y(n291) );
  CLKXOR2X2 U264 ( .A(n245), .B(n374), .Y(n299) );
  NAND2X4 U265 ( .A(n138), .B(n105), .Y(n141) );
  AOI22X2 U266 ( .A0(n139), .A1(lbp_addr_w[12]), .B0(n295), .B1(n288), .Y(n138) );
  XOR2X1 U267 ( .A(n314), .B(n391), .Y(n73) );
  XOR2X1 U268 ( .A(n306), .B(lbp_addr_w[7]), .Y(n94) );
  NAND2XL U269 ( .A(n282), .B(n226), .Y(state_w[3]) );
  AND2X2 U270 ( .A(n281), .B(state_r[0]), .Y(n391) );
  AND2X1 U271 ( .A(n195), .B(n397), .Y(lbp_data_w[3]) );
  MXI2X1 U272 ( .A(n185), .B(n324), .S0(n307), .Y(n80) );
  MXI2X1 U273 ( .A(n187), .B(n322), .S0(n307), .Y(n81) );
  MXI2X1 U274 ( .A(n186), .B(n321), .S0(n307), .Y(n82) );
  MXI2X1 U275 ( .A(n188), .B(n316), .S0(n307), .Y(n83) );
  MXI2X1 U276 ( .A(n183), .B(n320), .S0(n307), .Y(n84) );
  MXI2X1 U277 ( .A(n184), .B(n317), .S0(n307), .Y(n87) );
  NAND2X6 U278 ( .A(n210), .B(n209), .Y(n288) );
  AND2X2 U279 ( .A(n273), .B(n252), .Y(n103) );
  INVX3 U280 ( .A(n318), .Y(n115) );
  INVX3 U281 ( .A(n384), .Y(n178) );
  BUFX4 U282 ( .A(n384), .Y(n145) );
  AND2X2 U283 ( .A(n303), .B(n274), .Y(n104) );
  XNOR2X1 U284 ( .A(n376), .B(lbp_addr_w[0]), .Y(n252) );
  INVX12 U285 ( .A(n358), .Y(lbp_addr[13]) );
  INVX12 U286 ( .A(n356), .Y(lbp_addr[12]) );
  INVX12 U287 ( .A(n354), .Y(lbp_addr[11]) );
  INVX12 U288 ( .A(n352), .Y(lbp_addr[10]) );
  INVX12 U289 ( .A(n350), .Y(lbp_addr[9]) );
  INVX12 U290 ( .A(n348), .Y(lbp_addr[8]) );
  INVX12 U291 ( .A(n346), .Y(lbp_addr[7]) );
  INVX12 U292 ( .A(n344), .Y(lbp_addr[6]) );
  INVX12 U293 ( .A(n342), .Y(lbp_addr[5]) );
  INVX12 U294 ( .A(n340), .Y(lbp_addr[4]) );
  INVX12 U295 ( .A(n338), .Y(lbp_addr[3]) );
  INVX12 U296 ( .A(n336), .Y(lbp_addr[2]) );
  INVX12 U297 ( .A(n334), .Y(lbp_addr[1]) );
  INVX12 U298 ( .A(n332), .Y(lbp_addr[0]) );
  INVX12 U299 ( .A(n330), .Y(lbp_valid) );
  INVX12 U300 ( .A(n328), .Y(lbp_data[7]) );
  INVX12 U301 ( .A(n372), .Y(lbp_data[6]) );
  INVX12 U302 ( .A(n370), .Y(lbp_data[5]) );
  INVX12 U303 ( .A(n368), .Y(lbp_data[4]) );
  INVX12 U304 ( .A(n366), .Y(lbp_data[3]) );
  INVX12 U305 ( .A(n364), .Y(lbp_data[2]) );
  INVX12 U306 ( .A(n362), .Y(lbp_data[1]) );
  INVX12 U307 ( .A(n360), .Y(lbp_data[0]) );
  INVX12 U308 ( .A(n326), .Y(finish) );
  INVX12 U309 ( .A(reset), .Y(n392) );
  INVX3 U310 ( .A(n380), .Y(n109) );
  NAND2X6 U311 ( .A(n116), .B(n314), .Y(n110) );
  INVX20 U312 ( .A(n100), .Y(gray_addr[9]) );
  AO22X4 U313 ( .A0(n113), .A1(n287), .B0(n286), .B1(n112), .Y(n111) );
  NAND3X2 U314 ( .A(n270), .B(n318), .C(n378), .Y(n120) );
  NAND2X8 U315 ( .A(n217), .B(n218), .Y(n249) );
  NOR2X8 U316 ( .A(n214), .B(n251), .Y(n270) );
  XOR2X4 U317 ( .A(n125), .B(n115), .Y(n290) );
  INVX20 U318 ( .A(n127), .Y(gray_addr[13]) );
  AOI22X4 U319 ( .A0(n129), .A1(n128), .B0(n288), .B1(n289), .Y(n127) );
  XOR2X4 U320 ( .A(n132), .B(lbp_addr_w[13]), .Y(n289) );
  OAI21X4 U321 ( .A0(n96), .A1(n278), .B0(n126), .Y(n129) );
  AND2X8 U322 ( .A(n134), .B(lbp_addr_w[4]), .Y(n136) );
  INVX20 U323 ( .A(n135), .Y(gray_addr[4]) );
  NOR3X8 U324 ( .A(n136), .B(n255), .C(n99), .Y(n135) );
  XOR2X4 U325 ( .A(n240), .B(n379), .Y(n295) );
  BUFX20 U326 ( .A(n141), .Y(gray_addr[12]) );
  NOR2X8 U327 ( .A(state_r[0]), .B(n178), .Y(n203) );
  OAI21X4 U328 ( .A0(n374), .A1(n126), .B0(n142), .Y(n143) );
  INVX20 U329 ( .A(n144), .Y(gray_addr[10]) );
  AND2X8 U330 ( .A(n382), .B(n381), .Y(n215) );
  INVX20 U331 ( .A(n147), .Y(gray_addr[6]) );
  AND2X8 U332 ( .A(n149), .B(n148), .Y(n147) );
  OAI22X4 U333 ( .A0(n151), .A1(n272), .B0(n150), .B1(lbp_addr_w[6]), .Y(n149)
         );
  NOR2X8 U334 ( .A(n271), .B(n318), .Y(n150) );
  AOI21X4 U335 ( .A0(n269), .A1(n270), .B0(n268), .Y(n151) );
  NAND2BX4 U336 ( .AN(n153), .B(n283), .Y(n152) );
  INVX20 U337 ( .A(n155), .Y(gray_addr[1]) );
  OAI21X4 U338 ( .A0(n278), .A1(n285), .B0(n126), .Y(n160) );
  INVX20 U339 ( .A(n157), .Y(gray_addr[11]) );
  NOR2X4 U340 ( .A(n162), .B(n280), .Y(n161) );
  NOR2X2 U341 ( .A(n382), .B(n381), .Y(n177) );
  NOR2BX1 U342 ( .AN(n376), .B(n377), .Y(n256) );
  NAND2X2 U343 ( .A(n215), .B(n145), .Y(n195) );
  MXI2X1 U344 ( .A(n325), .B(n194), .S0(n306), .Y(n93) );
  BUFX4 U348 ( .A(lbp_addr_w[0]), .Y(n314) );
  AOI211XL U349 ( .A0(gray_data[1]), .A1(n315), .B0(gray_data[0]), .C0(n323), 
        .Y(n165) );
  OAI22XL U350 ( .A0(gray_data[1]), .A1(n315), .B0(gray_data[2]), .B1(n320), 
        .Y(n164) );
  AOI2BB1X2 U351 ( .A0N(n165), .A1N(n164), .B0(n163), .Y(n167) );
  OAI22XL U352 ( .A0(gray_data[3]), .A1(n316), .B0(gray_data[4]), .B1(n321), 
        .Y(n166) );
  OAI22XL U353 ( .A0(cur_data_r[4]), .A1(n186), .B0(n187), .B1(cur_data_r[5]), 
        .Y(n168) );
  OAI22X2 U354 ( .A0(n169), .A1(n168), .B0(gray_data[5]), .B1(n322), .Y(n170)
         );
  OA21X2 U355 ( .A0(cur_data_r[6]), .A1(n185), .B0(n170), .Y(n172) );
  OAI22XL U356 ( .A0(gray_data[7]), .A1(n317), .B0(gray_data[6]), .B1(n324), 
        .Y(n171) );
  OAI22X2 U357 ( .A0(n172), .A1(n171), .B0(cur_data_r[7]), .B1(n184), .Y(n173)
         );
  NOR2X4 U358 ( .A(n195), .B(state_r[0]), .Y(n176) );
  NAND2X2 U359 ( .A(n179), .B(n382), .Y(n207) );
  NAND2X4 U360 ( .A(n179), .B(n381), .Y(n225) );
  NOR2X4 U361 ( .A(n381), .B(state_r[3]), .Y(n220) );
  NAND2XL U362 ( .A(n220), .B(n382), .Y(n181) );
  OAI211XL U363 ( .A0(n225), .A1(n382), .B0(n208), .C0(n181), .Y(state_w[2])
         );
  NAND2X2 U364 ( .A(n182), .B(n109), .Y(n307) );
  NAND4XL U365 ( .A(n318), .B(lbp_addr_w[6]), .C(lbp_addr_w[1]), .D(
        lbp_addr_w[4]), .Y(n189) );
  NOR3X1 U366 ( .A(n314), .B(n230), .C(n189), .Y(n196) );
  AND2X2 U367 ( .A(lbp_addr_w[10]), .B(lbp_addr_w[9]), .Y(n241) );
  AND4X1 U368 ( .A(lbp_addr_w[8]), .B(lbp_addr_w[12]), .C(lbp_addr_w[13]), .D(
        lbp_addr_w[11]), .Y(n190) );
  OR2X4 U369 ( .A(n376), .B(n197), .Y(n219) );
  INVX3 U370 ( .A(n219), .Y(n204) );
  AO22X1 U371 ( .A0(n294), .A1(n262), .B0(lbp_addr_w[2]), .B1(n292), .Y(n77)
         );
  NOR2X2 U372 ( .A(state_r[1]), .B(state_r[0]), .Y(n199) );
  NAND4XL U373 ( .A(n201), .B(n226), .C(n210), .D(n200), .Y(n202) );
  AO21X1 U374 ( .A0(gray_ready), .A1(n203), .B0(n202), .Y(state_w[0]) );
  NAND2X1 U375 ( .A(n204), .B(lbp_addr_w[2]), .Y(n206) );
  AO22X1 U376 ( .A0(n294), .A1(n233), .B0(lbp_addr_w[3]), .B1(n292), .Y(n76)
         );
  AO22X1 U377 ( .A0(n294), .A1(n252), .B0(lbp_addr_w[1]), .B1(n292), .Y(n78)
         );
  NAND2X2 U378 ( .A(n222), .B(state_r[1]), .Y(n209) );
  OR2X4 U379 ( .A(n287), .B(n288), .Y(n211) );
  INVX20 U380 ( .A(n213), .Y(gray_addr[7]) );
  OR2X6 U381 ( .A(n314), .B(lbp_addr_w[1]), .Y(n251) );
  OR2X4 U382 ( .A(lbp_addr_w[3]), .B(lbp_addr_w[2]), .Y(n214) );
  NOR2X2 U383 ( .A(n382), .B(state_r[0]), .Y(n221) );
  NAND2X2 U384 ( .A(n222), .B(n221), .Y(n223) );
  BUFX20 U385 ( .A(n227), .Y(gray_addr[5]) );
  INVX20 U386 ( .A(n229), .Y(gray_addr[0]) );
  NAND2X2 U387 ( .A(n251), .B(lbp_addr_w[3]), .Y(n231) );
  OAI21X1 U388 ( .A0(n270), .A1(n232), .B0(n116), .Y(n235) );
  BUFX20 U389 ( .A(n236), .Y(gray_addr[3]) );
  NOR2X8 U390 ( .A(n274), .B(n237), .Y(n285) );
  OR2X2 U391 ( .A(n285), .B(lbp_addr_w[12]), .Y(n239) );
  AND2X4 U392 ( .A(n242), .B(n282), .Y(n278) );
  AOI2BB1X2 U393 ( .A0N(n243), .A1N(n285), .B0(n278), .Y(n246) );
  NAND3BX1 U394 ( .AN(lbp_addr_w[7]), .B(lbp_addr_w[9]), .C(n375), .Y(n247) );
  OR2X4 U395 ( .A(n270), .B(n268), .Y(n253) );
  NAND2X6 U396 ( .A(n254), .B(n270), .Y(n271) );
  CLKINVX6 U397 ( .A(n271), .Y(n255) );
  OAI2BB2X4 U398 ( .B0(n260), .B1(lbp_addr_w[2]), .A0N(n259), .A1N(n258), .Y(
        n261) );
  OAI2BB1X4 U399 ( .A0N(n262), .A1N(n273), .B0(n261), .Y(n263) );
  INVX20 U400 ( .A(n264), .Y(gray_addr[2]) );
  XOR2X4 U401 ( .A(n267), .B(n319), .Y(n293) );
  OAI2BB1X2 U402 ( .A0N(n287), .A1N(lbp_addr_w[7]), .B0(n126), .Y(n276) );
  OAI2BB1X4 U403 ( .A0N(lbp_addr_w[8]), .A1N(n276), .B0(n275), .Y(n277) );
  BUFX20 U404 ( .A(n277), .Y(gray_addr[8]) );
  NOR2X2 U405 ( .A(n281), .B(lbp_addr_w[13]), .Y(n283) );
  NOR2X4 U406 ( .A(lbp_addr_w[12]), .B(lbp_addr_w[11]), .Y(n284) );
  AO22X1 U407 ( .A0(n294), .A1(n290), .B0(n318), .B1(n292), .Y(n74) );
  AO22X1 U408 ( .A0(n294), .A1(n291), .B0(lbp_addr_w[4]), .B1(n292), .Y(n75)
         );
  AO22X1 U409 ( .A0(n294), .A1(n293), .B0(lbp_addr_w[6]), .B1(n292), .Y(n79)
         );
  OAI21XL U410 ( .A0(n306), .A1(n379), .B0(n296), .Y(n88) );
  OAI21XL U411 ( .A0(n306), .A1(n389), .B0(n298), .Y(n89) );
  NAND2XL U412 ( .A(n306), .B(n299), .Y(n300) );
  OAI21XL U413 ( .A0(n306), .A1(n374), .B0(n300), .Y(n90) );
  NAND2XL U414 ( .A(n306), .B(n301), .Y(n302) );
  OAI21XL U415 ( .A0(n306), .A1(n303), .B0(n302), .Y(n91) );
  OAI21XL U416 ( .A0(n306), .A1(n375), .B0(n305), .Y(n92) );
  OAI21XL U417 ( .A0(n310), .A1(n323), .B0(n308), .Y(n86) );
  OAI21XL U418 ( .A0(n310), .A1(n315), .B0(n309), .Y(n85) );
endmodule

