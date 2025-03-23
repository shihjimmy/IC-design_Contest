/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06
// Date      : Mon Mar 24 02:05:13 2025
/////////////////////////////////////////////////////////////


module DT ( clk, reset, done, sti_rd, sti_addr, sti_di, res_wr, res_rd, 
        res_addr, res_do, res_di );
  output [9:0] sti_addr;
  input [15:0] sti_di;
  output [13:0] res_addr;
  output [7:0] res_do;
  input [7:0] res_di;
  input clk, reset;
  output done, sti_rd, res_wr, res_rd;
  wire   n700, res_wr_w, is_pixel_r, \add_x_14/A[0] , n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486,
         n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541,
         n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n552,
         n553, n554, n555, n556, n557, n558, n559, n560, n561, n562, n563,
         n564, n565, n566, n567, n568, n569, n570, n571, n572, n573, n574,
         n575, n576, n577, n578, n579, n580, n581, n582, n583, n584, n585,
         n586, n587, n588, n589, n590, n591, n592, n593, n594, n595, n596,
         n597, n598, n599, n600, n601, n602, n603, n604, n605, n606, n607,
         n608, n609, n610, n611, n612, n613, n614, n615, n616, n617, n618,
         n619, n620, n621, n622, n623, n624, n625, n626, n627, n628, n629,
         n630, n631, n632, n633, n634, n635, n636, n637, n638, n639, n640,
         n641, n642, n643, n644, n645, n646, n647, n648, n649, n650, n651,
         n652, n653, n654, n655, n656, n657, n658, n659, n660, n661, n662,
         n663, n664, n665, n666, n667, n668, n669, n670, n671, n672, n673,
         n674, n675, n676, n677, n678, n679, n680, n681, n682, n683, n684,
         n685, n686, n687, n688, n689, n690, n691, n692, n693, n694, n695,
         n696, n697, n698, n699;
  wire   [3:0] state_r;
  wire   [3:0] state_w;
  wire   [3:0] temp4;
  wire   [7:0] cur_data_r;
  wire   [3:0] state_temp_r;
  wire   [7:0] temp3;
  wire   [6:0] count_row_w;
  wire   [6:0] count_col_w;
  wire   [13:0] res_addr_w;
  assign sti_addr[3] = \add_x_14/A[0] ;

  DFFRX4 \state_temp_r_reg[3]  ( .D(state_r[3]), .CK(clk), .RN(reset), .Q(
        state_temp_r[3]) );
  DFFRX4 \state_temp_r_reg[0]  ( .D(state_r[0]), .CK(clk), .RN(n695), .Q(
        state_temp_r[0]) );
  DFFRX4 \count_row_r_reg[6]  ( .D(count_row_w[6]), .CK(clk), .RN(n695), .Q(
        sti_addr[9]) );
  DFFRX4 \count_row_r_reg[1]  ( .D(n661), .CK(clk), .RN(n694), .Q(sti_addr[4]), 
        .QN(n671) );
  DFFRX4 \count_row_r_reg[2]  ( .D(count_row_w[2]), .CK(clk), .RN(n694), .Q(
        sti_addr[5]), .QN(n691) );
  DFFRX4 \count_row_r_reg[3]  ( .D(n181), .CK(clk), .RN(n694), .Q(sti_addr[6]), 
        .QN(n673) );
  DFFRX4 \count_row_r_reg[4]  ( .D(count_row_w[4]), .CK(clk), .RN(n694), .Q(
        sti_addr[7]), .QN(n692) );
  DFFRX4 \count_row_r_reg[5]  ( .D(count_row_w[5]), .CK(clk), .RN(n694), .Q(
        sti_addr[8]), .QN(n685) );
  DFFRX4 \cur_data_r_reg[6]  ( .D(res_di[6]), .CK(clk), .RN(n694), .Q(
        cur_data_r[6]) );
  DFFRX4 \cur_data_r_reg[4]  ( .D(res_di[4]), .CK(clk), .RN(n694), .Q(
        cur_data_r[4]) );
  DFFRX4 \cur_data_r_reg[2]  ( .D(res_di[2]), .CK(clk), .RN(reset), .Q(
        cur_data_r[2]) );
  DFFRX4 \cur_data_r_reg[1]  ( .D(res_di[1]), .CK(clk), .RN(reset), .Q(
        cur_data_r[1]) );
  DFFRX2 \res_data_r_reg[1]  ( .D(temp3[1]), .CK(clk), .RN(reset), .Q(
        res_do[1]), .QN(n688) );
  DFFRX4 \count_col_r_reg[2]  ( .D(count_col_w[2]), .CK(clk), .RN(n695), .Q(
        temp4[2]), .QN(n664) );
  DFFRX2 \state_r_reg[3]  ( .D(state_w[3]), .CK(clk), .RN(reset), .Q(
        state_r[3]), .QN(n678) );
  DFFRX2 \res_data_r_reg[2]  ( .D(temp3[2]), .CK(clk), .RN(reset), .Q(
        res_do[2]), .QN(n669) );
  DFFRX2 \res_data_r_reg[4]  ( .D(temp3[4]), .CK(clk), .RN(reset), .Q(
        res_do[4]), .QN(n668) );
  DFFSX2 \count_row_r_reg[0]  ( .D(n592), .CK(clk), .SN(reset), .Q(n700), .QN(
        n684) );
  DFFRX4 \state_r_reg[2]  ( .D(state_w[2]), .CK(clk), .RN(n695), .Q(state_r[2]), .QN(n662) );
  DFFRX4 \count_col_r_reg[4]  ( .D(count_col_w[4]), .CK(clk), .RN(n694), .Q(
        sti_addr[0]), .QN(n670) );
  DFFRX4 \state_r_reg[1]  ( .D(state_w[1]), .CK(clk), .RN(n695), .Q(state_r[1]), .QN(n666) );
  DFFRX4 \state_r_reg[0]  ( .D(state_w[0]), .CK(clk), .RN(n695), .Q(state_r[0]), .QN(n682) );
  DFFRX4 \count_col_r_reg[5]  ( .D(count_col_w[5]), .CK(clk), .RN(n695), .Q(
        sti_addr[1]), .QN(n686) );
  DFFRX1 \count_col_r_reg[0]  ( .D(n696), .CK(clk), .RN(reset), .Q(n663), .QN(
        temp4[0]) );
  DFFRX2 \res_addr_reg[11]  ( .D(res_addr_w[11]), .CK(clk), .RN(reset), .Q(
        res_addr[11]) );
  DFFRX2 \res_addr_reg[5]  ( .D(res_addr_w[5]), .CK(clk), .RN(reset), .Q(
        res_addr[5]) );
  DFFRX2 \res_addr_reg[9]  ( .D(res_addr_w[9]), .CK(clk), .RN(n693), .Q(
        res_addr[9]) );
  DFFRX2 \res_addr_reg[6]  ( .D(res_addr_w[6]), .CK(clk), .RN(n693), .Q(
        res_addr[6]) );
  DFFRX2 \res_addr_reg[7]  ( .D(res_addr_w[7]), .CK(clk), .RN(n693), .Q(
        res_addr[7]) );
  DFFRX2 \res_addr_reg[4]  ( .D(res_addr_w[4]), .CK(clk), .RN(n693), .Q(
        res_addr[4]) );
  DFFRX2 \res_addr_reg[8]  ( .D(n699), .CK(clk), .RN(n693), .Q(res_addr[8]) );
  DFFRX2 \res_addr_reg[3]  ( .D(res_addr_w[3]), .CK(clk), .RN(n693), .Q(
        res_addr[3]) );
  DFFRX2 \res_addr_reg[13]  ( .D(res_addr_w[13]), .CK(clk), .RN(reset), .Q(
        res_addr[13]) );
  DFFRX2 \res_addr_reg[0]  ( .D(res_addr_w[0]), .CK(clk), .RN(n694), .Q(
        res_addr[0]) );
  DFFRX2 \res_addr_reg[12]  ( .D(res_addr_w[12]), .CK(clk), .RN(n693), .Q(
        res_addr[12]) );
  DFFRX2 \res_addr_reg[10]  ( .D(n698), .CK(clk), .RN(n693), .Q(res_addr[10])
         );
  DFFRX2 \res_data_r_reg[3]  ( .D(temp3[3]), .CK(clk), .RN(n693), .Q(res_do[3]), .QN(n675) );
  DFFRX2 \res_data_r_reg[6]  ( .D(temp3[6]), .CK(clk), .RN(n693), .Q(res_do[6]), .QN(n676) );
  DFFRX2 \res_data_r_reg[7]  ( .D(temp3[7]), .CK(clk), .RN(n695), .Q(res_do[7]), .QN(n674) );
  DFFRX2 \res_data_r_reg[0]  ( .D(temp3[0]), .CK(clk), .RN(n693), .Q(res_do[0]), .QN(n690) );
  DFFRX2 \res_addr_reg[1]  ( .D(res_addr_w[1]), .CK(clk), .RN(n693), .Q(
        res_addr[1]) );
  DFFRX2 \res_addr_reg[2]  ( .D(res_addr_w[2]), .CK(clk), .RN(n693), .Q(
        res_addr[2]) );
  DFFRX2 res_wr_reg ( .D(res_wr_w), .CK(clk), .RN(reset), .Q(res_wr) );
  DFFRX4 \count_col_r_reg[6]  ( .D(count_col_w[6]), .CK(clk), .RN(n695), .Q(
        sti_addr[2]), .QN(n687) );
  DFFRX2 \count_col_r_reg[1]  ( .D(count_col_w[1]), .CK(clk), .RN(n695), .Q(
        temp4[1]), .QN(n665) );
  DFFRX2 \cur_data_r_reg[5]  ( .D(res_di[5]), .CK(clk), .RN(n694), .Q(
        cur_data_r[5]), .QN(n680) );
  DFFRX2 is_pixel_r_reg ( .D(n660), .CK(clk), .RN(reset), .Q(is_pixel_r), .QN(
        n683) );
  DFFSX2 \res_data_r_reg[5]  ( .D(n659), .CK(clk), .SN(reset), .Q(n689), .QN(
        res_do[5]) );
  DFFRHQX2 \state_temp_r_reg[2]  ( .D(state_r[2]), .CK(clk), .RN(n695), .Q(
        state_temp_r[2]) );
  DFFSHQX4 \count_col_r_reg[3]  ( .D(n697), .CK(clk), .SN(reset), .Q(n667) );
  DFFRX2 \cur_data_r_reg[0]  ( .D(res_di[0]), .CK(clk), .RN(reset), .Q(
        cur_data_r[0]), .QN(n679) );
  DFFRX2 \cur_data_r_reg[7]  ( .D(res_di[7]), .CK(clk), .RN(n694), .Q(
        cur_data_r[7]), .QN(n681) );
  DFFRX2 \cur_data_r_reg[3]  ( .D(res_di[3]), .CK(clk), .RN(n694), .Q(
        cur_data_r[3]), .QN(n672) );
  DFFRX1 \state_temp_r_reg[1]  ( .D(state_r[1]), .CK(clk), .RN(n695), .Q(
        state_temp_r[1]), .QN(n677) );
  NAND4X1 U230 ( .A(n620), .B(n619), .C(n618), .D(n617), .Y(n699) );
  NOR2X4 U231 ( .A(n446), .B(n448), .Y(n453) );
  AOI21X2 U232 ( .A0(count_col_w[6]), .A1(n589), .B0(n506), .Y(n519) );
  OR2X4 U233 ( .A(n515), .B(n377), .Y(n381) );
  AOI21X2 U234 ( .A0(n425), .A1(n424), .B0(n423), .Y(n426) );
  NAND2X1 U235 ( .A(count_col_w[1]), .B(n484), .Y(n201) );
  INVX1 U236 ( .A(n656), .Y(n657) );
  INVX2 U237 ( .A(n592), .Y(n612) );
  INVX4 U238 ( .A(n204), .Y(n203) );
  AND2X2 U239 ( .A(count_row_w[4]), .B(n639), .Y(n424) );
  NAND2X1 U240 ( .A(n457), .B(n622), .Y(n462) );
  INVX4 U241 ( .A(n377), .Y(n378) );
  NOR3X4 U242 ( .A(count_col_w[5]), .B(count_col_w[6]), .C(n512), .Y(n516) );
  NAND2X6 U243 ( .A(count_col_w[4]), .B(n589), .Y(n377) );
  NAND2X2 U244 ( .A(count_row_w[4]), .B(n615), .Y(n422) );
  NAND2X1 U245 ( .A(n186), .B(n639), .Y(n604) );
  INVX4 U246 ( .A(n437), .Y(n438) );
  NAND2X6 U247 ( .A(n583), .B(n593), .Y(n440) );
  NAND3X6 U248 ( .A(n393), .B(n410), .C(n411), .Y(count_row_w[2]) );
  MXI2X6 U249 ( .A(n338), .B(n339), .S0(n205), .Y(n696) );
  ADDHXL U250 ( .A(sti_addr[8]), .B(n565), .CO(n566), .S(n445) );
  OR2X6 U251 ( .A(n493), .B(n667), .Y(n364) );
  OR2X2 U252 ( .A(n391), .B(n474), .Y(n339) );
  NAND2X2 U253 ( .A(n628), .B(n523), .Y(n257) );
  CLKINVX1 U254 ( .A(n642), .Y(n205) );
  INVX6 U255 ( .A(n181), .Y(n593) );
  BUFX12 U256 ( .A(n602), .Y(n186) );
  OR2X1 U257 ( .A(n533), .B(state_r[2]), .Y(n537) );
  NAND2X4 U258 ( .A(n571), .B(sti_addr[6]), .Y(n397) );
  NAND2X6 U259 ( .A(n567), .B(n595), .Y(n396) );
  NAND3X1 U260 ( .A(n412), .B(\add_x_14/A[0] ), .C(n647), .Y(n416) );
  INVX1 U261 ( .A(n413), .Y(n352) );
  INVX4 U262 ( .A(n331), .Y(n177) );
  NAND2X4 U263 ( .A(n543), .B(n207), .Y(res_wr_w) );
  NAND2X2 U264 ( .A(n539), .B(n369), .Y(n543) );
  INVX3 U265 ( .A(n647), .Y(n638) );
  NAND2X1 U266 ( .A(n541), .B(n561), .Y(n207) );
  NOR2X1 U267 ( .A(n682), .B(n666), .Y(n541) );
  NOR2BX2 U268 ( .AN(n326), .B(n642), .Y(n413) );
  NOR2X1 U269 ( .A(n460), .B(n674), .Y(n249) );
  NAND2X1 U270 ( .A(n247), .B(n246), .Y(n458) );
  NAND4X1 U271 ( .A(n319), .B(n318), .C(n317), .D(n316), .Y(n320) );
  OAI22XL U272 ( .A0(n332), .A1(n335), .B0(n323), .B1(n315), .Y(n316) );
  INVXL U273 ( .A(n308), .Y(n375) );
  NAND2X6 U274 ( .A(n200), .B(n199), .Y(n197) );
  NOR2X1 U275 ( .A(n254), .B(res_do[1]), .Y(n229) );
  NAND2X1 U276 ( .A(n235), .B(n680), .Y(n236) );
  NOR2X2 U277 ( .A(n663), .B(n554), .Y(n403) );
  INVX3 U278 ( .A(n376), .Y(n335) );
  BUFX4 U279 ( .A(n700), .Y(\add_x_14/A[0] ) );
  NAND2X6 U280 ( .A(n289), .B(n667), .Y(n291) );
  NOR2X2 U281 ( .A(n218), .B(cur_data_r[1]), .Y(n211) );
  NOR2X1 U282 ( .A(n662), .B(n678), .Y(n299) );
  NOR2X1 U283 ( .A(sti_addr[0]), .B(n358), .Y(n301) );
  NOR2X6 U284 ( .A(n273), .B(n277), .Y(n189) );
  NAND2X4 U285 ( .A(n286), .B(n285), .Y(n287) );
  NAND2X4 U286 ( .A(n294), .B(n664), .Y(n297) );
  INVX3 U287 ( .A(n214), .Y(n215) );
  NOR2X1 U288 ( .A(n222), .B(n679), .Y(n226) );
  NAND2X2 U289 ( .A(n225), .B(n224), .Y(n240) );
  NAND2X6 U290 ( .A(n180), .B(sti_di[1]), .Y(n282) );
  NOR2X4 U291 ( .A(sti_di[4]), .B(n271), .Y(n273) );
  NOR2X4 U292 ( .A(sti_di[10]), .B(n275), .Y(n266) );
  NOR2X4 U293 ( .A(sti_di[8]), .B(n274), .Y(n267) );
  NAND2X4 U294 ( .A(sti_di[15]), .B(n361), .Y(n285) );
  INVX4 U295 ( .A(sti_di[3]), .Y(n288) );
  INVX4 U296 ( .A(sti_di[13]), .Y(n294) );
  INVX3 U297 ( .A(sti_di[9]), .Y(n293) );
  NAND2X4 U298 ( .A(sti_di[7]), .B(n284), .Y(n286) );
  INVX3 U299 ( .A(n667), .Y(n358) );
  NAND2X2 U300 ( .A(state_temp_r[2]), .B(is_pixel_r), .Y(n223) );
  NOR2X2 U301 ( .A(cur_data_r[1]), .B(cur_data_r[2]), .Y(n212) );
  BUFX4 U302 ( .A(temp4[0]), .Y(n642) );
  NAND2XL U303 ( .A(temp4[2]), .B(n281), .Y(n179) );
  INVXL U304 ( .A(n179), .Y(n180) );
  INVX4 U305 ( .A(sti_di[11]), .Y(n289) );
  INVXL U306 ( .A(n458), .Y(n248) );
  XNOR2X2 U307 ( .A(n235), .B(cur_data_r[5]), .Y(n260) );
  AOI22X1 U308 ( .A0(n226), .A1(n225), .B0(n240), .B1(n679), .Y(n227) );
  INVXL U309 ( .A(n484), .Y(n429) );
  NAND2XL U310 ( .A(n502), .B(n640), .Y(n505) );
  NAND2X1 U311 ( .A(n627), .B(n628), .Y(n522) );
  NOR2X2 U312 ( .A(n184), .B(n375), .Y(n647) );
  NOR2XL U313 ( .A(n485), .B(n441), .Y(n486) );
  NAND2XL U314 ( .A(n534), .B(n533), .Y(n535) );
  INVXL U315 ( .A(n628), .Y(n626) );
  NAND2X2 U316 ( .A(n539), .B(n305), .Y(n376) );
  NAND3X1 U317 ( .A(n590), .B(n181), .C(n589), .Y(n599) );
  NAND2XL U318 ( .A(n634), .B(n633), .Y(n635) );
  OAI21X1 U319 ( .A0(n610), .A1(n440), .B0(n426), .Y(res_addr_w[11]) );
  AND3X4 U320 ( .A(n333), .B(n334), .C(n332), .Y(n175) );
  NAND3X6 U321 ( .A(n406), .B(n405), .C(n404), .Y(count_row_w[4]) );
  NAND3X2 U322 ( .A(n387), .B(n386), .C(n385), .Y(res_addr_w[3]) );
  BUFX16 U323 ( .A(n455), .Y(n255) );
  NAND2X4 U324 ( .A(n245), .B(n244), .Y(n251) );
  AOI2BB2X2 U325 ( .B0(n460), .B1(n674), .A0N(n456), .A1N(res_do[6]), .Y(n244)
         );
  CLKINVX1 U326 ( .A(n463), .Y(n461) );
  INVX3 U327 ( .A(n228), .Y(n252) );
  NOR2X4 U328 ( .A(n249), .B(n248), .Y(n250) );
  NOR2X6 U329 ( .A(n234), .B(cur_data_r[4]), .Y(n235) );
  NAND2X1 U330 ( .A(n568), .B(n685), .Y(n569) );
  INVX12 U331 ( .A(n197), .Y(n334) );
  AOI21X1 U332 ( .A0(n651), .A1(n650), .B0(\add_x_14/A[0] ), .Y(n652) );
  AND2X2 U333 ( .A(n359), .B(n358), .Y(n284) );
  NAND2X1 U334 ( .A(n642), .B(n332), .Y(n318) );
  NAND3X6 U335 ( .A(n189), .B(n188), .C(n187), .Y(n199) );
  NAND2X1 U336 ( .A(n458), .B(n674), .Y(n459) );
  NOR2X6 U337 ( .A(sti_di[2]), .B(n275), .Y(n276) );
  NAND2X4 U338 ( .A(n678), .B(n307), .Y(n650) );
  NAND2X4 U339 ( .A(n466), .B(n203), .Y(n202) );
  NAND2X6 U340 ( .A(n575), .B(n594), .Y(n590) );
  NAND2X1 U341 ( .A(n615), .B(n661), .Y(n618) );
  NAND2X1 U342 ( .A(n530), .B(n633), .Y(n531) );
  NAND2X1 U343 ( .A(n628), .B(n633), .Y(n629) );
  NAND2X1 U344 ( .A(n454), .B(n633), .Y(n263) );
  NAND2X1 U345 ( .A(n523), .B(n633), .Y(n524) );
  NAND2X1 U346 ( .A(n623), .B(n633), .Y(n624) );
  INVX12 U347 ( .A(n392), .Y(n567) );
  INVX16 U348 ( .A(n176), .Y(n570) );
  OAI2BB1X2 U349 ( .A0N(n233), .A1N(n232), .B0(n231), .Y(n239) );
  INVX6 U350 ( .A(n243), .Y(n456) );
  AOI21X1 U351 ( .A0(n445), .A1(n649), .B0(n444), .Y(n447) );
  NOR2BX4 U352 ( .AN(n321), .B(n320), .Y(n412) );
  NAND2X1 U353 ( .A(n576), .B(n649), .Y(n579) );
  NAND2X4 U354 ( .A(n215), .B(cur_data_r[3]), .Y(n216) );
  AOI2BB2X2 U355 ( .B0(n566), .B1(sti_addr[9]), .A0N(n566), .A1N(sti_addr[9]), 
        .Y(n576) );
  CLKMX2X2 U356 ( .A(n644), .B(n643), .S0(n642), .Y(n645) );
  INVX3 U357 ( .A(n648), .Y(n639) );
  NAND2X1 U358 ( .A(n419), .B(n649), .Y(n420) );
  INVX1 U359 ( .A(n641), .Y(n468) );
  CLKINVX1 U360 ( .A(n546), .Y(n540) );
  NAND2X6 U361 ( .A(n546), .B(n335), .Y(n648) );
  INVX1 U362 ( .A(n467), .Y(n469) );
  NAND3X6 U363 ( .A(n292), .B(n291), .C(n290), .Y(n193) );
  INVX4 U364 ( .A(res_wr_w), .Y(n633) );
  NOR2X6 U365 ( .A(n266), .B(n267), .Y(n192) );
  NOR2X1 U366 ( .A(n370), .B(state_r[2]), .Y(n371) );
  NAND2X1 U367 ( .A(n388), .B(sti_addr[5]), .Y(n389) );
  NAND2X2 U368 ( .A(n562), .B(n418), .Y(n649) );
  INVX1 U369 ( .A(n561), .Y(n563) );
  NAND2X1 U370 ( .A(n561), .B(n666), .Y(n418) );
  NOR2X6 U371 ( .A(sti_di[12]), .B(n271), .Y(n269) );
  NAND2X6 U372 ( .A(n288), .B(n358), .Y(n292) );
  ADDHX1 U373 ( .A(sti_addr[4]), .B(\add_x_14/A[0] ), .CO(n395), .S(n616) );
  NOR3X1 U374 ( .A(state_temp_r[3]), .B(state_temp_r[0]), .C(n683), .Y(n246)
         );
  NOR2X1 U375 ( .A(n665), .B(n667), .Y(n280) );
  OAI2BB1X1 U376 ( .A0N(res_wr_w), .A1N(n630), .B0(n629), .Y(temp3[2]) );
  XOR2X2 U377 ( .A(n262), .B(n261), .Y(n264) );
  NAND3X2 U378 ( .A(n427), .B(n466), .C(n696), .Y(n435) );
  OAI2BB1X1 U379 ( .A0N(res_wr_w), .A1N(n625), .B0(n624), .Y(temp3[4]) );
  NOR2X6 U380 ( .A(n590), .B(n440), .Y(n442) );
  NAND2X2 U381 ( .A(n622), .B(n623), .Y(n262) );
  OAI2BB1X1 U382 ( .A0N(res_wr_w), .A1N(n636), .B0(n635), .Y(temp3[1]) );
  NAND2X6 U383 ( .A(n634), .B(n631), .Y(n520) );
  INVX1 U384 ( .A(n634), .Y(n632) );
  INVX8 U385 ( .A(count_row_w[4]), .Y(n583) );
  NAND3X1 U386 ( .A(n564), .B(n563), .C(n562), .Y(state_w[3]) );
  INVX3 U387 ( .A(n530), .Y(n528) );
  INVX1 U388 ( .A(n623), .Y(n621) );
  INVX1 U389 ( .A(n523), .Y(n521) );
  NAND2X6 U390 ( .A(n567), .B(n606), .Y(n410) );
  NAND2X4 U391 ( .A(n567), .B(n419), .Y(n406) );
  NAND3X1 U392 ( .A(n560), .B(n559), .C(n558), .Y(state_w[1]) );
  NAND4X1 U393 ( .A(n538), .B(n543), .C(n537), .D(n536), .Y(state_w[0]) );
  NAND2X1 U394 ( .A(n560), .B(n545), .Y(state_w[2]) );
  NAND2X1 U395 ( .A(n660), .B(n535), .Y(n538) );
  NAND2X1 U396 ( .A(n557), .B(n660), .Y(n558) );
  AOI21X1 U397 ( .A0(n483), .A1(n640), .B0(n374), .Y(n380) );
  NOR3X2 U398 ( .A(n413), .B(\add_x_14/A[0] ), .C(n638), .Y(n414) );
  NOR2X1 U399 ( .A(n556), .B(n555), .Y(n559) );
  NOR2X1 U400 ( .A(n507), .B(n484), .Y(n485) );
  INVX1 U401 ( .A(n258), .Y(n259) );
  INVX1 U402 ( .A(n511), .Y(n512) );
  AOI21X1 U403 ( .A0(\add_x_14/A[0] ), .A1(n653), .B0(n652), .Y(n654) );
  INVX3 U404 ( .A(n653), .Y(n600) );
  NAND2X1 U405 ( .A(n402), .B(n401), .Y(n417) );
  NAND2X1 U406 ( .A(n489), .B(n640), .Y(n490) );
  AND2X2 U407 ( .A(n460), .B(n459), .Y(n463) );
  INVX1 U408 ( .A(n568), .Y(n402) );
  NOR2X1 U409 ( .A(n641), .B(n640), .Y(n644) );
  NOR2X1 U410 ( .A(n658), .B(n656), .Y(n555) );
  NAND2X6 U411 ( .A(n283), .B(n282), .Y(n196) );
  NAND2X1 U412 ( .A(n595), .B(n649), .Y(n596) );
  NAND2X1 U413 ( .A(n390), .B(n389), .Y(n601) );
  NAND2X1 U414 ( .A(n345), .B(n344), .Y(n428) );
  INVX1 U415 ( .A(n403), .Y(n306) );
  NAND2X1 U416 ( .A(n616), .B(n649), .Y(n617) );
  INVX3 U417 ( .A(n589), .Y(n441) );
  INVX1 U418 ( .A(n649), .Y(n651) );
  INVX1 U419 ( .A(n394), .Y(n390) );
  NAND2X1 U420 ( .A(n642), .B(n335), .Y(n319) );
  NAND2X1 U421 ( .A(n367), .B(state_r[0]), .Y(n368) );
  NAND2X4 U422 ( .A(n326), .B(n323), .Y(n546) );
  NAND2X1 U423 ( .A(n606), .B(n649), .Y(n607) );
  OR2X1 U424 ( .A(n376), .B(n642), .Y(n183) );
  INVX1 U425 ( .A(n418), .Y(n367) );
  NAND2X1 U426 ( .A(n351), .B(n350), .Y(n467) );
  NOR3X4 U427 ( .A(n314), .B(n313), .C(n312), .Y(n326) );
  NOR2X1 U428 ( .A(n351), .B(n664), .Y(n290) );
  NAND2X1 U429 ( .A(n388), .B(n304), .Y(n614) );
  NAND3X2 U430 ( .A(n303), .B(n302), .C(n301), .Y(n554) );
  NAND2X1 U431 ( .A(n541), .B(n539), .Y(n562) );
  NAND2X1 U432 ( .A(n642), .B(n358), .Y(n272) );
  INVX1 U433 ( .A(n369), .Y(n370) );
  NAND2X4 U434 ( .A(n369), .B(n299), .Y(n308) );
  NAND2X1 U435 ( .A(n642), .B(n667), .Y(n268) );
  NAND2X1 U436 ( .A(\add_x_14/A[0] ), .B(sti_addr[4]), .Y(n304) );
  NOR2X1 U437 ( .A(n665), .B(n358), .Y(n295) );
  NAND2X1 U438 ( .A(sti_addr[9]), .B(sti_addr[4]), .Y(n311) );
  NAND3X6 U439 ( .A(n334), .B(n333), .C(n324), .Y(n325) );
  NAND2X6 U440 ( .A(n330), .B(n441), .Y(n322) );
  NAND2X6 U441 ( .A(n210), .B(n209), .Y(n218) );
  NOR4X4 U442 ( .A(n222), .B(cur_data_r[0]), .C(n677), .D(n223), .Y(n209) );
  OAI2BB1X1 U443 ( .A0N(res_wr_w), .A1N(n525), .B0(n524), .Y(temp3[3]) );
  NAND2X6 U444 ( .A(n570), .B(n684), .Y(n407) );
  NOR2X4 U445 ( .A(count_row_w[2]), .B(n181), .Y(n574) );
  NAND2X2 U446 ( .A(n573), .B(n572), .Y(count_row_w[6]) );
  NAND2X6 U447 ( .A(n349), .B(n348), .Y(count_col_w[2]) );
  NOR2X6 U448 ( .A(n661), .B(n648), .Y(n611) );
  NAND2X6 U449 ( .A(n176), .B(n614), .Y(n329) );
  NAND3X6 U450 ( .A(n192), .B(n191), .C(n190), .Y(n200) );
  NOR2X6 U451 ( .A(n269), .B(n268), .Y(n191) );
  NAND2X6 U452 ( .A(n571), .B(sti_addr[4]), .Y(n328) );
  NAND2X4 U453 ( .A(n571), .B(sti_addr[7]), .Y(n404) );
  AND2X8 U454 ( .A(n185), .B(n403), .Y(n176) );
  NAND2X1 U455 ( .A(sti_addr[6]), .B(sti_addr[5]), .Y(n310) );
  BUFX6 U456 ( .A(n602), .Y(n661) );
  INVX12 U457 ( .A(n331), .Y(n474) );
  OAI2BB1X2 U458 ( .A0N(res_wr_w), .A1N(n465), .B0(n464), .Y(temp3[7]) );
  NAND2X2 U459 ( .A(n623), .B(n454), .Y(n526) );
  INVX6 U460 ( .A(n697), .Y(n178) );
  INVX4 U461 ( .A(n585), .Y(count_row_w[5]) );
  NOR3X4 U462 ( .A(n637), .B(count_col_w[5]), .C(n510), .Y(n518) );
  NAND2X2 U463 ( .A(n509), .B(n508), .Y(n510) );
  ADDHX2 U464 ( .A(sti_addr[1]), .B(n494), .CO(n495), .S(n489) );
  INVX8 U465 ( .A(n513), .Y(n697) );
  NOR2X6 U466 ( .A(n276), .B(n272), .Y(n188) );
  NOR2BX2 U467 ( .AN(n280), .B(n642), .Y(n281) );
  INVX4 U468 ( .A(n493), .Y(n338) );
  NOR2X2 U469 ( .A(count_row_w[6]), .B(n581), .Y(n587) );
  OAI2BB1X4 U470 ( .A0N(n474), .A1N(n373), .B0(n570), .Y(n340) );
  NAND2X4 U471 ( .A(n334), .B(n333), .Y(n330) );
  NAND4X4 U472 ( .A(n575), .B(n583), .C(n574), .D(n585), .Y(n580) );
  NAND2X4 U473 ( .A(n474), .B(n428), .Y(n346) );
  NOR2X6 U474 ( .A(count_row_w[2]), .B(n592), .Y(n584) );
  NAND3X6 U475 ( .A(n492), .B(n491), .C(n490), .Y(res_addr_w[5]) );
  NAND2X6 U476 ( .A(n384), .B(n206), .Y(n385) );
  CLKINVX1 U477 ( .A(n265), .Y(n659) );
  NAND2X4 U478 ( .A(n571), .B(sti_addr[5]), .Y(n411) );
  OR2X8 U479 ( .A(n493), .B(n665), .Y(n356) );
  NAND3X8 U480 ( .A(n328), .B(n327), .C(n329), .Y(n602) );
  AND2X4 U481 ( .A(n411), .B(n410), .Y(n594) );
  NOR2X6 U482 ( .A(n175), .B(n335), .Y(n336) );
  NAND4X2 U483 ( .A(n610), .B(n609), .C(n608), .D(n607), .Y(res_addr_w[9]) );
  NOR2X8 U484 ( .A(n439), .B(n438), .Y(n585) );
  NAND2X4 U485 ( .A(n584), .B(n611), .Y(n610) );
  INVX12 U486 ( .A(n185), .Y(n331) );
  NAND3X4 U487 ( .A(n516), .B(n515), .C(n514), .Y(n517) );
  NAND2X6 U488 ( .A(n477), .B(n476), .Y(count_col_w[5]) );
  NOR2X8 U489 ( .A(n257), .B(n520), .Y(n622) );
  INVX12 U490 ( .A(n337), .Y(n493) );
  NOR2X8 U491 ( .A(n186), .B(n615), .Y(n575) );
  NOR3X4 U492 ( .A(n186), .B(n181), .C(n648), .Y(n582) );
  XNOR2X4 U493 ( .A(n234), .B(cur_data_r[4]), .Y(n258) );
  NAND2X6 U494 ( .A(n214), .B(n672), .Y(n234) );
  NOR2X4 U495 ( .A(n223), .B(n677), .Y(n225) );
  MXI2X4 U496 ( .A(n639), .B(n638), .S0(n637), .Y(n646) );
  INVXL U497 ( .A(n643), .Y(n372) );
  NOR2X1 U498 ( .A(state_r[1]), .B(state_r[2]), .Y(n307) );
  NAND2XL U499 ( .A(n540), .B(n175), .Y(n560) );
  NAND3X6 U500 ( .A(sti_di[5]), .B(n281), .C(n664), .Y(n283) );
  NAND2X1 U501 ( .A(n665), .B(temp4[2]), .Y(n275) );
  NOR2XL U502 ( .A(n359), .B(n667), .Y(n360) );
  NAND2XL U503 ( .A(n642), .B(temp4[1]), .Y(n350) );
  NOR2X1 U504 ( .A(n663), .B(n648), .Y(n511) );
  AND2X1 U505 ( .A(n480), .B(n640), .Y(n182) );
  NAND2X2 U506 ( .A(n647), .B(n183), .Y(n484) );
  NOR2BX1 U507 ( .AN(n335), .B(n546), .Y(n184) );
  INVX4 U508 ( .A(n696), .Y(n637) );
  ADDHX1 U509 ( .A(sti_addr[0]), .B(n473), .CO(n494), .S(n483) );
  NOR2X4 U510 ( .A(n662), .B(state_r[3]), .Y(n539) );
  NOR2X2 U511 ( .A(n678), .B(state_r[2]), .Y(n561) );
  NAND2XL U512 ( .A(n400), .B(sti_addr[7]), .Y(n401) );
  AOI2BB2X2 U513 ( .B0(n217), .B1(n675), .A0N(res_do[2]), .A1N(n252), .Y(n233)
         );
  CLKINVX1 U514 ( .A(n253), .Y(n217) );
  AOI2BB2X1 U515 ( .B0(n253), .B1(res_do[3]), .A0N(n258), .A1N(n668), .Y(n231)
         );
  INVX3 U516 ( .A(n224), .Y(n222) );
  NAND3X1 U517 ( .A(n221), .B(n220), .C(n219), .Y(n241) );
  NOR2X6 U518 ( .A(sti_di[0]), .B(n274), .Y(n277) );
  NAND2X4 U519 ( .A(n278), .B(n303), .Y(n187) );
  INVX3 U520 ( .A(sti_di[6]), .Y(n278) );
  NAND2X4 U521 ( .A(n270), .B(n303), .Y(n190) );
  INVX3 U522 ( .A(sti_di[14]), .Y(n270) );
  NOR2X4 U523 ( .A(temp4[1]), .B(temp4[2]), .Y(n303) );
  INVXL U524 ( .A(n326), .Y(n315) );
  NAND3XL U525 ( .A(n658), .B(n534), .C(n376), .Y(n317) );
  NOR2X2 U526 ( .A(count_col_w[2]), .B(n648), .Y(n427) );
  OAI21X1 U527 ( .A0(n430), .A1(n648), .B0(n429), .Y(n431) );
  INVX3 U528 ( .A(count_col_w[1]), .Y(n466) );
  NAND2X1 U529 ( .A(n612), .B(n611), .Y(n620) );
  NOR2X2 U530 ( .A(count_col_w[4]), .B(n513), .Y(n514) );
  NOR2X4 U531 ( .A(n533), .B(n662), .Y(n557) );
  NOR2XL U532 ( .A(n546), .B(state_r[3]), .Y(n547) );
  AND2X4 U533 ( .A(n391), .B(n352), .Y(n499) );
  AND2X2 U534 ( .A(n445), .B(n567), .Y(n439) );
  MXI2X4 U535 ( .A(n546), .B(n177), .S0(n336), .Y(n337) );
  NOR2X4 U536 ( .A(res_wr_w), .B(n589), .Y(res_rd) );
  NAND2X2 U537 ( .A(n472), .B(n534), .Y(sti_rd) );
  OAI2BB1X1 U538 ( .A0N(res_wr_w), .A1N(n532), .B0(n531), .Y(temp3[6]) );
  OAI2BB1X1 U539 ( .A0N(res_wr_w), .A1N(n264), .B0(n263), .Y(n265) );
  NOR2BX1 U540 ( .AN(n383), .B(n182), .Y(n386) );
  MX2X1 U541 ( .A(n648), .B(n647), .S0(n592), .Y(n655) );
  NAND2XL U542 ( .A(n474), .B(n656), .Y(n564) );
  CLKBUFX3 U543 ( .A(n330), .Y(n660) );
  NAND3X2 U544 ( .A(n185), .B(n403), .C(n417), .Y(n405) );
  NAND2X2 U545 ( .A(n176), .B(n601), .Y(n393) );
  CLKINVX1 U546 ( .A(n447), .Y(n448) );
  NAND3X8 U547 ( .A(n396), .B(n398), .C(n397), .Y(n181) );
  ADDHX1 U548 ( .A(sti_addr[5]), .B(n395), .CO(n399), .S(n606) );
  ADDHX1 U549 ( .A(sti_addr[7]), .B(n436), .CO(n565), .S(n419) );
  ADDHX1 U550 ( .A(sti_addr[6]), .B(n399), .CO(n436), .S(n595) );
  NAND2BX1 U551 ( .AN(n686), .B(sti_addr[2]), .Y(n314) );
  NOR2X1 U552 ( .A(sti_addr[1]), .B(sti_addr[2]), .Y(n302) );
  XOR2X1 U553 ( .A(n497), .B(sti_addr[2]), .Y(n503) );
  OAI21X1 U554 ( .A0(n394), .A1(n673), .B0(n400), .Y(n591) );
  NAND2X1 U555 ( .A(n394), .B(n673), .Y(n400) );
  NOR2X4 U556 ( .A(n388), .B(sti_addr[5]), .Y(n394) );
  NAND3X1 U557 ( .A(n202), .B(n471), .C(n201), .Y(res_addr_w[1]) );
  NOR2X4 U558 ( .A(count_row_w[2]), .B(count_row_w[4]), .Y(n449) );
  AND2X8 U559 ( .A(n365), .B(n570), .Y(n348) );
  OAI22X4 U560 ( .A0(n588), .A1(n587), .B0(n586), .B1(count_row_w[6]), .Y(
        res_addr_w[13]) );
  INVX16 U561 ( .A(n198), .Y(n333) );
  NAND2X4 U562 ( .A(n376), .B(n308), .Y(n589) );
  AOI21X4 U563 ( .A0(n589), .A1(n580), .B0(n581), .Y(n588) );
  NOR2X8 U564 ( .A(n407), .B(n567), .Y(n409) );
  NAND2X8 U565 ( .A(n300), .B(n308), .Y(n185) );
  NAND3X8 U566 ( .A(n195), .B(n194), .C(n193), .Y(n198) );
  NAND3X6 U567 ( .A(n298), .B(n297), .C(n296), .Y(n194) );
  NOR2X8 U568 ( .A(n287), .B(n196), .Y(n195) );
  NAND2X6 U569 ( .A(n696), .B(n639), .Y(n204) );
  NAND2X8 U570 ( .A(n356), .B(n355), .Y(count_col_w[1]) );
  NAND2X2 U571 ( .A(n646), .B(n645), .Y(res_addr_w[0]) );
  NAND3X2 U572 ( .A(n422), .B(n421), .C(n420), .Y(n423) );
  AND2X4 U573 ( .A(n513), .B(n589), .Y(n206) );
  NOR2XL U574 ( .A(n479), .B(n478), .Y(n481) );
  NOR2X1 U575 ( .A(n682), .B(state_r[1]), .Y(n305) );
  NOR2X4 U576 ( .A(state_r[0]), .B(state_r[1]), .Y(n369) );
  NOR3X2 U577 ( .A(cur_data_r[3]), .B(cur_data_r[7]), .C(cur_data_r[6]), .Y(
        n208) );
  NOR2X4 U578 ( .A(cur_data_r[4]), .B(cur_data_r[5]), .Y(n219) );
  NAND3X2 U579 ( .A(n208), .B(n212), .C(n219), .Y(n210) );
  NOR2X8 U580 ( .A(state_temp_r[3]), .B(state_temp_r[0]), .Y(n224) );
  XOR2X4 U581 ( .A(n211), .B(cur_data_r[2]), .Y(n228) );
  INVX1 U582 ( .A(n212), .Y(n213) );
  NOR2X8 U583 ( .A(n218), .B(n213), .Y(n214) );
  AND2X8 U584 ( .A(n234), .B(n216), .Y(n253) );
  XOR2X4 U585 ( .A(n218), .B(cur_data_r[1]), .Y(n254) );
  NOR3X2 U586 ( .A(cur_data_r[3]), .B(cur_data_r[1]), .C(cur_data_r[6]), .Y(
        n221) );
  NOR2X1 U587 ( .A(cur_data_r[0]), .B(cur_data_r[2]), .Y(n220) );
  OAI21X4 U588 ( .A0(cur_data_r[7]), .A1(n241), .B0(n227), .Y(n256) );
  AOI21X2 U589 ( .A0(n254), .A1(res_do[1]), .B0(n256), .Y(n230) );
  OAI22X1 U590 ( .A0(n230), .A1(n229), .B0(n228), .B1(n669), .Y(n232) );
  AOI2BB2X2 U591 ( .B0(n258), .B1(n668), .A0N(n260), .A1N(res_do[5]), .Y(n238)
         );
  XNOR2X4 U592 ( .A(n236), .B(cur_data_r[6]), .Y(n243) );
  AOI2BB2X4 U593 ( .B0(res_do[5]), .B1(n260), .A0N(n243), .A1N(n676), .Y(n237)
         );
  OAI2BB1X4 U594 ( .A0N(n239), .A1N(n238), .B0(n237), .Y(n245) );
  NOR2X2 U595 ( .A(n241), .B(n240), .Y(n242) );
  NOR2X2 U596 ( .A(n242), .B(n681), .Y(n460) );
  XNOR2X1 U597 ( .A(state_temp_r[1]), .B(state_temp_r[2]), .Y(n247) );
  NAND2X8 U598 ( .A(n251), .B(n250), .Y(n455) );
  MXI2X4 U599 ( .A(n669), .B(n252), .S0(n455), .Y(n628) );
  MXI2X4 U600 ( .A(n675), .B(n253), .S0(n455), .Y(n523) );
  MXI2X4 U601 ( .A(n688), .B(n254), .S0(n255), .Y(n634) );
  MXI2X4 U602 ( .A(n690), .B(n256), .S0(n255), .Y(n631) );
  MXI2X4 U603 ( .A(n668), .B(n259), .S0(n455), .Y(n623) );
  MXI2X4 U604 ( .A(n689), .B(n260), .S0(n455), .Y(n454) );
  CLKINVX1 U605 ( .A(n454), .Y(n261) );
  NAND2X1 U606 ( .A(temp4[1]), .B(temp4[2]), .Y(n274) );
  NAND2X1 U607 ( .A(n664), .B(temp4[1]), .Y(n271) );
  NOR2X2 U608 ( .A(n666), .B(state_r[0]), .Y(n279) );
  NAND2X2 U609 ( .A(n678), .B(n279), .Y(n533) );
  NAND2BX2 U610 ( .AN(n642), .B(n665), .Y(n351) );
  NOR2X4 U611 ( .A(n351), .B(temp4[2]), .Y(n359) );
  INVX3 U612 ( .A(n359), .Y(n345) );
  NOR2X4 U613 ( .A(n345), .B(n358), .Y(n361) );
  NAND2X6 U614 ( .A(n293), .B(temp4[2]), .Y(n298) );
  NOR2BX1 U615 ( .AN(n295), .B(n642), .Y(n296) );
  NAND3X8 U616 ( .A(n334), .B(n333), .C(n557), .Y(n300) );
  NAND2BX2 U617 ( .AN(\add_x_14/A[0] ), .B(n671), .Y(n388) );
  OAI21XL U618 ( .A0(n375), .A1(n557), .B0(n306), .Y(n321) );
  NOR2X8 U619 ( .A(n650), .B(state_r[0]), .Y(n332) );
  INVX3 U620 ( .A(n557), .Y(n472) );
  AND2X4 U621 ( .A(n472), .B(n308), .Y(n658) );
  INVX3 U622 ( .A(n332), .Y(n534) );
  NAND2X1 U623 ( .A(sti_addr[7]), .B(sti_addr[8]), .Y(n309) );
  NOR3X2 U624 ( .A(n311), .B(n310), .C(n309), .Y(n323) );
  NAND2X1 U625 ( .A(sti_addr[0]), .B(temp4[1]), .Y(n313) );
  NAND2X1 U626 ( .A(n358), .B(temp4[2]), .Y(n312) );
  NAND2X8 U627 ( .A(n322), .B(n412), .Y(n571) );
  AND2X2 U628 ( .A(n332), .B(n546), .Y(n324) );
  NAND2X8 U629 ( .A(n325), .B(n648), .Y(n391) );
  NAND3X2 U630 ( .A(n391), .B(n413), .C(n616), .Y(n327) );
  OR2X8 U631 ( .A(n493), .B(n670), .Y(n342) );
  NAND2X1 U632 ( .A(n361), .B(n670), .Y(n496) );
  OAI21XL U633 ( .A0(n361), .A1(n670), .B0(n496), .Y(n373) );
  AOI21X4 U634 ( .A0(n499), .A1(n483), .B0(n340), .Y(n341) );
  NAND2X8 U635 ( .A(n342), .B(n341), .Y(count_col_w[4]) );
  OR2X8 U636 ( .A(n493), .B(n664), .Y(n349) );
  ADDHX1 U637 ( .A(temp4[2]), .B(n343), .CO(n357), .S(n479) );
  NAND3X2 U638 ( .A(n391), .B(n479), .C(n352), .Y(n347) );
  NAND2XL U639 ( .A(n351), .B(temp4[2]), .Y(n344) );
  AND2X8 U640 ( .A(n347), .B(n346), .Y(n365) );
  NAND2X4 U641 ( .A(n474), .B(n467), .Y(n354) );
  ADDHX2 U642 ( .A(temp4[1]), .B(n642), .CO(n343), .S(n478) );
  NAND3X2 U643 ( .A(n391), .B(n478), .C(n352), .Y(n353) );
  AND2X8 U644 ( .A(n354), .B(n353), .Y(n430) );
  AND2X8 U645 ( .A(n430), .B(n570), .Y(n355) );
  ADDHX1 U646 ( .A(n358), .B(n357), .CO(n473), .S(n480) );
  OR2X1 U647 ( .A(n361), .B(n360), .Y(n382) );
  OAI2BB1X4 U648 ( .A0N(n474), .A1N(n382), .B0(n570), .Y(n362) );
  AOI21X4 U649 ( .A0(n499), .A1(n480), .B0(n362), .Y(n363) );
  NAND2X8 U650 ( .A(n364), .B(n363), .Y(n513) );
  NAND3X2 U651 ( .A(n430), .B(n365), .C(n511), .Y(n366) );
  NOR3X6 U652 ( .A(count_col_w[4]), .B(n513), .C(n366), .Y(n487) );
  NOR2X8 U653 ( .A(count_col_w[2]), .B(count_col_w[1]), .Y(n515) );
  OAI2BB2X2 U654 ( .B0(n650), .B1(n682), .A0N(state_r[1]), .A1N(n539), .Y(n640) );
  NAND2X2 U655 ( .A(n537), .B(n368), .Y(n641) );
  NOR2X2 U656 ( .A(res_wr_w), .B(n371), .Y(n643) );
  AO22X1 U657 ( .A0(n373), .A1(n641), .B0(sti_addr[0]), .B1(n372), .Y(n374) );
  OAI21X4 U658 ( .A0(n484), .A1(n178), .B0(n378), .Y(n379) );
  NAND4BX4 U659 ( .AN(n487), .B(n381), .C(n380), .D(n379), .Y(res_addr_w[4])
         );
  NAND3X2 U660 ( .A(n515), .B(n697), .C(n511), .Y(n387) );
  AOI2BB2X1 U661 ( .B0(n382), .B1(n641), .A0N(n643), .A1N(n667), .Y(n383) );
  NAND2X4 U662 ( .A(n515), .B(n429), .Y(n384) );
  NAND2X8 U663 ( .A(n391), .B(n413), .Y(n392) );
  NAND3X4 U664 ( .A(n474), .B(n403), .C(n591), .Y(n398) );
  NOR2X2 U665 ( .A(n400), .B(sti_addr[7]), .Y(n568) );
  NOR2X4 U666 ( .A(n571), .B(n684), .Y(n408) );
  NOR2X8 U667 ( .A(n409), .B(n408), .Y(n592) );
  NOR2X4 U668 ( .A(n181), .B(n186), .Y(n450) );
  NAND2X2 U669 ( .A(n450), .B(n594), .Y(n425) );
  NOR2X1 U670 ( .A(n414), .B(n441), .Y(n415) );
  AND2X2 U671 ( .A(n416), .B(n415), .Y(n615) );
  CLKINVX1 U672 ( .A(n650), .Y(n613) );
  NAND2X1 U673 ( .A(n633), .B(n533), .Y(n653) );
  AOI2BB2X1 U674 ( .B0(n417), .B1(n613), .A0N(n600), .A1N(n692), .Y(n421) );
  AOI2BB2X1 U675 ( .B0(n428), .B1(n641), .A0N(n643), .A1N(n664), .Y(n434) );
  NAND2X1 U676 ( .A(count_col_w[2]), .B(n431), .Y(n433) );
  NAND2X1 U677 ( .A(n479), .B(n640), .Y(n432) );
  NAND4X2 U678 ( .A(n435), .B(n434), .C(n433), .D(n432), .Y(res_addr_w[2]) );
  XOR2X1 U679 ( .A(n568), .B(n685), .Y(n443) );
  AOI2BB2X4 U680 ( .B0(sti_addr[8]), .B1(n571), .A0N(n570), .A1N(n443), .Y(
        n437) );
  NOR2X8 U681 ( .A(n442), .B(n441), .Y(n446) );
  OAI22X1 U682 ( .A0(n443), .A1(n650), .B0(n600), .B1(n685), .Y(n444) );
  NOR2X2 U683 ( .A(count_row_w[5]), .B(n448), .Y(n452) );
  NAND4BX2 U684 ( .AN(n592), .B(n450), .C(n449), .D(n639), .Y(n451) );
  OAI22X4 U685 ( .A0(n453), .A1(n452), .B0(count_row_w[5]), .B1(n451), .Y(
        res_addr_w[12]) );
  MXI2X2 U686 ( .A(n676), .B(n456), .S0(n455), .Y(n530) );
  NOR2X1 U687 ( .A(n526), .B(n528), .Y(n457) );
  XOR2X1 U688 ( .A(n462), .B(n461), .Y(n465) );
  NAND2X1 U689 ( .A(n463), .B(n633), .Y(n464) );
  OAI22XL U690 ( .A0(n469), .A1(n468), .B0(n643), .B1(n665), .Y(n470) );
  AOI21X1 U691 ( .A0(n478), .A1(n640), .B0(n470), .Y(n471) );
  OR2X4 U692 ( .A(n493), .B(n686), .Y(n477) );
  XNOR2X1 U693 ( .A(n496), .B(sti_addr[1]), .Y(n488) );
  OAI2BB1X2 U694 ( .A0N(n488), .A1N(n474), .B0(n570), .Y(n475) );
  AOI21X4 U695 ( .A0(n499), .A1(n489), .B0(n475), .Y(n476) );
  NOR2BX1 U696 ( .AN(n481), .B(n480), .Y(n482) );
  NAND2BX1 U697 ( .AN(n483), .B(n482), .Y(n507) );
  MXI2X4 U698 ( .A(n487), .B(n486), .S0(count_col_w[5]), .Y(n492) );
  AOI2BB2X1 U699 ( .B0(n488), .B1(n641), .A0N(n643), .A1N(n686), .Y(n491) );
  OR2X2 U700 ( .A(n493), .B(n687), .Y(n501) );
  AOI2BB2X1 U701 ( .B0(n495), .B1(sti_addr[2]), .A0N(n495), .A1N(sti_addr[2]), 
        .Y(n502) );
  NOR2X1 U702 ( .A(n496), .B(sti_addr[1]), .Y(n497) );
  OAI2BB1X2 U703 ( .A0N(n503), .A1N(n474), .B0(n570), .Y(n498) );
  AOI21X4 U704 ( .A0(n499), .A1(n502), .B0(n498), .Y(n500) );
  NAND2X6 U705 ( .A(n501), .B(n500), .Y(count_col_w[6]) );
  AOI2BB2X1 U706 ( .B0(n503), .B1(n641), .A0N(n643), .A1N(n687), .Y(n504) );
  NAND2X2 U707 ( .A(n505), .B(n504), .Y(n506) );
  INVX1 U708 ( .A(n506), .Y(n509) );
  NOR2X1 U709 ( .A(n507), .B(n638), .Y(n508) );
  OAI21X4 U710 ( .A0(n519), .A1(n518), .B0(n517), .Y(res_addr_w[6]) );
  INVX3 U711 ( .A(n520), .Y(n627) );
  XOR2X1 U712 ( .A(n522), .B(n521), .Y(n525) );
  INVX1 U713 ( .A(n526), .Y(n527) );
  NAND2X1 U714 ( .A(n622), .B(n527), .Y(n529) );
  XOR2X1 U715 ( .A(n529), .B(n528), .Y(n532) );
  CLKBUFX3 U716 ( .A(reset), .Y(n693) );
  CLKBUFX3 U717 ( .A(reset), .Y(n695) );
  CLKBUFX3 U718 ( .A(reset), .Y(n694) );
  XOR2X1 U719 ( .A(n631), .B(res_wr_w), .Y(temp3[0]) );
  NAND2XL U720 ( .A(n561), .B(n682), .Y(n536) );
  NAND3XL U721 ( .A(n540), .B(n539), .C(n666), .Y(n544) );
  NAND2XL U722 ( .A(n541), .B(n662), .Y(n542) );
  AND4X1 U723 ( .A(n544), .B(n658), .C(n543), .D(n542), .Y(n545) );
  OAI21XL U724 ( .A0(n547), .A1(n662), .B0(n666), .Y(n549) );
  NAND2XL U725 ( .A(n662), .B(state_r[1]), .Y(n548) );
  MXI2X1 U726 ( .A(n549), .B(n548), .S0(n682), .Y(n556) );
  NOR2X1 U727 ( .A(sti_addr[9]), .B(sti_addr[4]), .Y(n552) );
  NOR2X1 U728 ( .A(sti_addr[6]), .B(sti_addr[5]), .Y(n551) );
  NOR2X1 U729 ( .A(sti_addr[7]), .B(sti_addr[8]), .Y(n550) );
  NAND3X1 U730 ( .A(n552), .B(n551), .C(n550), .Y(n553) );
  NOR2X4 U731 ( .A(n554), .B(n553), .Y(n656) );
  NAND2X2 U732 ( .A(n576), .B(n567), .Y(n573) );
  XOR2X1 U733 ( .A(n569), .B(sti_addr[9]), .Y(n577) );
  AOI2BB2X2 U734 ( .B0(sti_addr[9]), .B1(n571), .A0N(n570), .A1N(n577), .Y(
        n572) );
  AOI2BB2X1 U735 ( .B0(sti_addr[9]), .B1(n653), .A0N(n577), .A1N(n650), .Y(
        n578) );
  NAND2X1 U736 ( .A(n579), .B(n578), .Y(n581) );
  NAND4X2 U737 ( .A(n585), .B(n584), .C(n583), .D(n582), .Y(n586) );
  AOI2BB2X1 U738 ( .B0(n591), .B1(n613), .A0N(n600), .A1N(n673), .Y(n598) );
  NAND4X2 U739 ( .A(n612), .B(n594), .C(n611), .D(n593), .Y(n597) );
  NAND4X2 U740 ( .A(n599), .B(n598), .C(n597), .D(n596), .Y(n698) );
  AOI2BB2X1 U741 ( .B0(n601), .B1(n613), .A0N(n600), .A1N(n691), .Y(n609) );
  INVX1 U742 ( .A(n615), .Y(n603) );
  NAND2X2 U743 ( .A(n604), .B(n603), .Y(n605) );
  NAND2X2 U744 ( .A(n605), .B(count_row_w[2]), .Y(n608) );
  AOI22X1 U745 ( .A0(n614), .A1(n613), .B0(sti_addr[4]), .B1(n653), .Y(n619)
         );
  XNOR2X1 U746 ( .A(n622), .B(n621), .Y(n625) );
  XNOR2X1 U747 ( .A(n627), .B(n626), .Y(n630) );
  XNOR2X1 U748 ( .A(n632), .B(n631), .Y(n636) );
  NAND2X1 U749 ( .A(n655), .B(n654), .Y(res_addr_w[7]) );
  NOR2X8 U750 ( .A(n658), .B(n657), .Y(done) );
endmodule

