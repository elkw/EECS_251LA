
// Generated by Cadence Genus(TM) Synthesis Solution 19.15-s090_1
// Generated on: Jun  7 2023 14:22:24 PDT (Jun  7 2023 21:22:24 UTC)

// Verification Directory fv/fir 

module addertree_NUM_INPUT_BITS4_NUM_OUTPUT_BITS16(in0, in1, in2, in3,
     in4, Out);
  input [3:0] in0, in1, in2, in3, in4;
  output [15:0] Out;
  wire [3:0] in0, in1, in2, in3, in4;
  wire [15:0] Out;
  wire UNCONNECTED, UNCONNECTED0, UNCONNECTED1, UNCONNECTED2,
       UNCONNECTED3, UNCONNECTED4, UNCONNECTED5, n_0;
  wire n_10, n_11, n_12, n_13, n_14, n_15, n_16, n_17;
  wire n_18, n_19, n_20, n_21, n_22, n_23, n_24, n_25;
  wire n_26, n_27, n_28, n_29, n_30, n_31, n_32, n_33;
  wire n_34, n_35, n_36, n_37, n_38, n_39, n_40, n_41;
  wire n_42, n_43, n_44, n_45;
  sky130_fd_sc_hd__inv_2 g816(.A (n_44), .Y (Out[15]));
  sky130_fd_sc_hd__fa_1 g817__2398(.A (n_11), .B (n_24), .CIN (n_42),
       .COUT (n_44), .SUM (n_45));
  sky130_fd_sc_hd__fa_1 g818__5107(.A (n_25), .B (n_32), .CIN (n_40),
       .COUT (n_42), .SUM (n_43));
  sky130_fd_sc_hd__fa_1 g819__6260(.A (n_30), .B (n_33), .CIN (n_38),
       .COUT (n_40), .SUM (n_41));
  sky130_fd_sc_hd__fa_1 g820__4319(.A (n_22), .B (n_31), .CIN (n_36),
       .COUT (n_38), .SUM (n_39));
  sky130_fd_sc_hd__fa_1 g821__8428(.A (n_20), .B (n_23), .CIN (n_34),
       .COUT (n_36), .SUM (n_37));
  sky130_fd_sc_hd__fa_1 g822__5526(.A (in0[2]), .B (n_26), .CIN (n_21),
       .COUT (n_34), .SUM (n_35));
  sky130_fd_sc_hd__inv_2 g823(.A (n_29), .Y (n_33));
  sky130_fd_sc_hd__inv_2 g824(.A (n_28), .Y (n_32));
  sky130_fd_sc_hd__fa_1 g825__6783(.A (in1[2]), .B (n_18), .CIN (n_17),
       .COUT (n_30), .SUM (n_31));
  sky130_fd_sc_hd__fa_1 g826__3680(.A (in1[3]), .B (n_15), .CIN (n_16),
       .COUT (n_28), .SUM (n_29));
  sky130_fd_sc_hd__fa_1 g827__1617(.A (in0[1]), .B (in4[1]), .CIN
       (n_13), .COUT (n_26), .SUM (n_27));
  sky130_fd_sc_hd__ha_1 g828__2802(.A (in2[2]), .B (n_14), .COUT
       (n_24), .SUM (n_25));
  sky130_fd_sc_hd__fa_1 g829__1705(.A (in1[1]), .B (n_12), .CIN (n_19),
       .COUT (n_22), .SUM (n_23));
  sky130_fd_sc_hd__fa_1 g830__5122(.A (in1[0]), .B (in3[0]), .CIN
       (in4[2]), .COUT (n_20), .SUM (n_21));
  sky130_fd_sc_hd__ha_1 g831__8246(.A (in3[1]), .B (n_10), .COUT
       (n_18), .SUM (n_19));
  sky130_fd_sc_hd__a21o_1 g832__7098(.A1 (in2[0]), .A2 (in3[2]), .B1
       (n_15), .X (n_17));
  sky130_fd_sc_hd__xnor2_1 g834__6131(.A (in3[3]), .B (in2[1]), .Y
       (n_16));
  sky130_fd_sc_hd__nor2_1 g835__1881(.A (in3[2]), .B (in2[0]), .Y
       (n_15));
  sky130_fd_sc_hd__nand2b_1 g836__5115(.A_N (in2[1]), .B (in3[3]), .Y
       (n_14));
  sky130_fd_sc_hd__and2_1 g837__7482(.A (in0[0]), .B (in4[0]), .X
       (n_13));
  sky130_fd_sc_hd__inv_2 g838(.A (in0[3]), .Y (n_12));
  sky130_fd_sc_hd__inv_2 g839(.A (in2[3]), .Y (n_11));
  sky130_fd_sc_hd__inv_1 g841(.A (in4[3]), .Y (n_10));
  sky130_fd_sc_hd__buf_8 drc_bufs(.A (n_35), .X (Out[2]));
  sky130_fd_sc_hd__buf_8 drc_bufs842(.A (n_27), .X (Out[1]));
  sky130_fd_sc_hd__buf_8 drc_bufs843(.A (n_45), .X (Out[7]));
  sky130_fd_sc_hd__buf_8 drc_bufs844(.A (n_43), .X (Out[6]));
  sky130_fd_sc_hd__buf_8 drc_bufs845(.A (n_37), .X (Out[3]));
  sky130_fd_sc_hd__buf_8 drc_bufs846(.A (n_39), .X (Out[4]));
  sky130_fd_sc_hd__buf_8 drc_bufs847(.A (n_41), .X (Out[5]));
  sky130_fd_sc_hd__buf_8 drc_bufs848(.A (n_0), .X (Out[0]));
  sky130_fd_sc_hd__xor2_1 g2__4733(.A (in0[0]), .B (in4[0]), .X (n_0));
  sky130_fd_sc_hd__conb_1 tie_0_cell(.HI (UNCONNECTED), .LO (Out[10]));
  sky130_fd_sc_hd__conb_1 tie_0_cell1(.HI (UNCONNECTED0), .LO
       (Out[11]));
  sky130_fd_sc_hd__conb_1 tie_0_cell2(.HI (UNCONNECTED1), .LO
       (Out[12]));
  sky130_fd_sc_hd__conb_1 tie_0_cell3(.HI (UNCONNECTED2), .LO
       (Out[13]));
  sky130_fd_sc_hd__conb_1 tie_0_cell4(.HI (UNCONNECTED3), .LO
       (Out[14]));
  sky130_fd_sc_hd__conb_1 tie_0_cell5(.HI (UNCONNECTED4), .LO (Out[8]));
  sky130_fd_sc_hd__conb_1 tie_0_cell6(.HI (UNCONNECTED5), .LO (Out[9]));
endmodule

module REGISTER_R_N4(q, d, rst, clk);
  input [3:0] d;
  input rst, clk;
  output [3:0] q;
  wire [3:0] d;
  wire rst, clk;
  wire [3:0] q;
  wire n_0, n_1, n_2, n_3;
  sky130_fd_sc_hd__dfxtp_1 \q_reg[3] (.CLK (clk), .D (n_3), .Q (q[3]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[2] (.CLK (clk), .D (n_0), .Q (q[2]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[0] (.CLK (clk), .D (n_2), .Q (q[0]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[1] (.CLK (clk), .D (n_1), .Q (q[1]));
  sky130_fd_sc_hd__nor2b_1 g7__6161(.A (rst), .B_N (d[3]), .Y (n_3));
  sky130_fd_sc_hd__nor2b_1 g8__9315(.A (rst), .B_N (d[0]), .Y (n_2));
  sky130_fd_sc_hd__nor2b_1 g9__9945(.A (rst), .B_N (d[1]), .Y (n_1));
  sky130_fd_sc_hd__nor2b_1 g10__2883(.A (rst), .B_N (d[2]), .Y (n_0));
endmodule

module REGISTER_R_N4_12(q, d, rst, clk);
  input [3:0] d;
  input rst, clk;
  output [3:0] q;
  wire [3:0] d;
  wire rst, clk;
  wire [3:0] q;
  wire n_0, n_1, n_2, n_3;
  sky130_fd_sc_hd__dfxtp_1 \q_reg[3] (.CLK (clk), .D (n_3), .Q (q[3]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[2] (.CLK (clk), .D (n_0), .Q (q[2]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[0] (.CLK (clk), .D (n_2), .Q (q[0]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[1] (.CLK (clk), .D (n_1), .Q (q[1]));
  sky130_fd_sc_hd__nor2b_1 g7__2346(.A (rst), .B_N (d[3]), .Y (n_3));
  sky130_fd_sc_hd__nor2b_1 g8__1666(.A (rst), .B_N (d[0]), .Y (n_2));
  sky130_fd_sc_hd__nor2b_1 g9__7410(.A (rst), .B_N (d[1]), .Y (n_1));
  sky130_fd_sc_hd__nor2b_1 g10__6417(.A (rst), .B_N (d[2]), .Y (n_0));
endmodule

module REGISTER_R_N4_11(q, d, rst, clk);
  input [3:0] d;
  input rst, clk;
  output [3:0] q;
  wire [3:0] d;
  wire rst, clk;
  wire [3:0] q;
  wire n_0, n_1, n_2, n_3;
  sky130_fd_sc_hd__dfxtp_1 \q_reg[3] (.CLK (clk), .D (n_3), .Q (q[3]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[2] (.CLK (clk), .D (n_0), .Q (q[2]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[0] (.CLK (clk), .D (n_2), .Q (q[0]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[1] (.CLK (clk), .D (n_1), .Q (q[1]));
  sky130_fd_sc_hd__nor2b_1 g7__5477(.A (rst), .B_N (d[3]), .Y (n_3));
  sky130_fd_sc_hd__nor2b_1 g8__2398(.A (rst), .B_N (d[0]), .Y (n_2));
  sky130_fd_sc_hd__nor2b_1 g9__5107(.A (rst), .B_N (d[1]), .Y (n_1));
  sky130_fd_sc_hd__nor2b_1 g10__6260(.A (rst), .B_N (d[2]), .Y (n_0));
endmodule

module REGISTER_R_N4_10(q, d, rst, clk);
  input [3:0] d;
  input rst, clk;
  output [3:0] q;
  wire [3:0] d;
  wire rst, clk;
  wire [3:0] q;
  wire n_0, n_1, n_2, n_3;
  sky130_fd_sc_hd__dfxtp_1 \q_reg[3] (.CLK (clk), .D (n_3), .Q (q[3]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[2] (.CLK (clk), .D (n_0), .Q (q[2]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[0] (.CLK (clk), .D (n_2), .Q (q[0]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[1] (.CLK (clk), .D (n_1), .Q (q[1]));
  sky130_fd_sc_hd__nor2b_1 g7__4319(.A (rst), .B_N (d[3]), .Y (n_3));
  sky130_fd_sc_hd__nor2b_1 g8__8428(.A (rst), .B_N (d[0]), .Y (n_2));
  sky130_fd_sc_hd__nor2b_1 g9__5526(.A (rst), .B_N (d[1]), .Y (n_1));
  sky130_fd_sc_hd__nor2b_1 g10__6783(.A (rst), .B_N (d[2]), .Y (n_0));
endmodule

module REGISTER_R_N4_9(q, d, rst, clk);
  input [3:0] d;
  input rst, clk;
  output [3:0] q;
  wire [3:0] d;
  wire rst, clk;
  wire [3:0] q;
  wire n_0, n_1, n_2, n_3;
  sky130_fd_sc_hd__dfxtp_1 \q_reg[3] (.CLK (clk), .D (n_3), .Q (q[3]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[2] (.CLK (clk), .D (n_0), .Q (q[2]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[0] (.CLK (clk), .D (n_2), .Q (q[0]));
  sky130_fd_sc_hd__dfxtp_1 \q_reg[1] (.CLK (clk), .D (n_1), .Q (q[1]));
  sky130_fd_sc_hd__nor2b_1 g7__3680(.A (rst), .B_N (d[3]), .Y (n_3));
  sky130_fd_sc_hd__nor2b_1 g8__1617(.A (rst), .B_N (d[0]), .Y (n_2));
  sky130_fd_sc_hd__nor2b_1 g9__2802(.A (rst), .B_N (d[1]), .Y (n_1));
  sky130_fd_sc_hd__nor2b_1 g10__1705(.A (rst), .B_N (d[2]), .Y (n_0));
endmodule

module fir(clk, rst, In, Out);
  input clk, rst;
  input [3:0] In;
  output [15:0] Out;
  wire clk, rst;
  wire [3:0] In;
  wire [15:0] Out;
  wire [3:0] delay_chain0;
  wire [3:0] delay_chain1;
  wire [3:0] delay_chain2;
  wire [3:0] delay_chain3;
  wire [3:0] delay_chain4;
  wire UNCONNECTED6, UNCONNECTED7, UNCONNECTED8, UNCONNECTED9,
       UNCONNECTED10, UNCONNECTED11, UNCONNECTED12, n_0;
  wire n_2, n_4, n_9, n_12;
  addertree_NUM_INPUT_BITS4_NUM_OUTPUT_BITS16 add0(.in0 (delay_chain0),
       .in1 (delay_chain1), .in2 (delay_chain2), .in3 (delay_chain3),
       .in4 (delay_chain4), .Out ({n_12, UNCONNECTED12, UNCONNECTED11,
       UNCONNECTED10, UNCONNECTED9, UNCONNECTED8, UNCONNECTED7,
       UNCONNECTED6, Out[7:0]}));
  REGISTER_R_N4 delay_step0(.q (delay_chain0), .d (In), .rst (rst),
       .clk (clk));
  REGISTER_R_N4_12 delay_step1(.q (delay_chain1), .d (delay_chain0),
       .rst (rst), .clk (clk));
  REGISTER_R_N4_11 delay_step2(.q (delay_chain2), .d (delay_chain1),
       .rst (rst), .clk (clk));
  REGISTER_R_N4_10 delay_step3(.q (delay_chain3), .d (delay_chain2),
       .rst (rst), .clk (clk));
  REGISTER_R_N4_9 delay_step4(.q (delay_chain4), .d (delay_chain3),
       .rst (rst), .clk (clk));
  sky130_fd_sc_hd__inv_16 g4(.A (n_9), .Y (Out[12]));
  sky130_fd_sc_hd__inv_16 g5(.A (n_9), .Y (Out[10]));
  sky130_fd_sc_hd__inv_16 g2(.A (n_4), .Y (Out[14]));
  sky130_fd_sc_hd__inv_16 g8(.A (n_2), .Y (Out[11]));
  sky130_fd_sc_hd__inv_16 g11(.A (n_0), .Y (Out[9]));
  sky130_fd_sc_hd__inv_16 g1(.A (n_4), .Y (Out[8]));
  sky130_fd_sc_hd__inv_16 g7(.A (n_2), .Y (Out[13]));
  sky130_fd_sc_hd__inv_16 g10(.A (n_0), .Y (Out[15]));
  sky130_fd_sc_hd__inv_1 g12(.A (n_12), .Y (n_0));
  sky130_fd_sc_hd__inv_1 g9(.A (n_12), .Y (n_2));
  sky130_fd_sc_hd__inv_1 g6(.A (n_12), .Y (n_9));
  sky130_fd_sc_hd__inv_1 g3(.A (n_12), .Y (n_4));
endmodule
