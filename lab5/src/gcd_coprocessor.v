//=========================================================================
// Template for GCD coprocessor onnnnnnne
//-------------------------------------------------------------------------
//

module gcd_coprocessor_single #( parameter W = 32 ) (
  input clk,
  input reset,

  input operands_val,
  input [W-1:0] operands_bits_A,
  input [W-1:0] operands_bits_B,
  output operands_rdy,

  output result_val,
  output [W-1:0] result_bits,
  input result_rdy

);

// You should be able to build this with mostly structural verilog!

// Define wires
wire B_mux_sel, A_en, B_en, B_zero, A_lt_B;
wire [1:0] A_mux_sel;

wire [W-1:0] A_fifo, B_fifo;
wire [W-1:0] data_result;
wire A_enq_rdy, B_enq_rdy, A_deq_vld, B_deq_vld;

wire ctrl_operands_val, ctrl_result_rdy, ctrl_operands_rdy, ctrl_result_vld;
wire C_enq_rdy;
assign ctrl_result_rdy = C_enq_rdy;

assign ctrl_operands_val = A_deq_vld & B_deq_vld;
assign operands_rdy = A_enq_rdy & B_enq_rdy;

// Instantiate gcd_datapath
gcd_datapath#(W) GCDdpath0(

	// external
	.operands_bits_A(A_fifo),
	.operands_bits_B(B_fifo),
	.result_bits_data(data_result),

	// system
	.clk(clk), 
	.reset(reset),

	// internal (between ctrl and dpath)
	.A_mux_sel(A_mux_sel[1:0]), 
	.A_en(A_en), 
	.B_en(B_en),
	.B_mux_sel(B_mux_sel),
	.B_zero(B_zero),
	.A_lt_B(A_lt_B)
);

// Instantiate gcd_control
gcd_control GCDctrl0(

	// external
	.operands_rdy(ctrl_operands_rdy),
	.operands_val(ctrl_operands_val), 
	.result_rdy(ctrl_result_rdy),
	.result_val(ctrl_result_vld), 

	// system
	.clk(clk), 
	.reset(reset), 

	// internal (between ctrl and dpath)
	.B_zero(B_zero), 
	.A_lt_B(A_lt_B),
	.A_mux_sel(A_mux_sel[1:0]), 
	.A_en(A_en), 
	.B_en(B_en),
	.B_mux_sel(B_mux_sel)

);
// Instantiate request FIFO
fifo#(W) request_A (
  .clk(clk),
  .reset(reset),

  .enq_val(operands_val),
  .enq_data(operands_bits_A),
  .enq_rdy(A_enq_rdy),

  .deq_val(A_deq_vld),
  .deq_data(A_fifo),
  .deq_rdy(ctrl_operands_rdy)
);
fifo#(W) request_B (
  .clk(clk),
  .reset(reset),

  .enq_val(operands_val),
  .enq_data(operands_bits_B),
  .enq_rdy(B_enq_rdy),

  .deq_val(B_deq_vld),
  .deq_data(B_fifo),
  .deq_rdy(ctrl_operands_rdy)
);
// Instantiate response FIFO
fifo#(W) response (
  .clk(clk),
  .reset(reset),

  .enq_val(ctrl_result_vld),
  .enq_data(data_result),
  .enq_rdy(C_enq_rdy),

  .deq_val(result_val),
  .deq_data(result_bits),
  .deq_rdy(ctrl_operands_rdy)
);

endmodule

//=========================================================================
// Template for GCD coprocessor twwwwwwo
//-------------------------------------------------------------------------
//

module gcd_coprocessor_dual #( parameter W = 32 ) (
  input clk,
  input reset,

  input operands_val,
  input [W-1:0] operands_bits_A,
  input [W-1:0] operands_bits_B,
  output operands_rdy,

  output result_val,
  output [W-1:0] result_bits,
  input result_rdy

);

// You should be able to build this with mostly structural verilog!

// Define wires
wire A_enq_rdy, B_enq_rdy, A_deq_vld, B_deq_vld;
wire [W-1:0] A_fifo, B_fifo;

wire request0_val, request0_rdy;
wire [W-1:0] request0_operands_bits_A;
wire [W-1:0] request0_operands_bits_B;
wire request1_val, request1_rdy;
wire [W-1:0] request1_operands_bits_A;
wire [W-1:0] request1_operands_bits_B;
wire response0_val, response0_rdy;
wire [W-1:0] response0_result_bits_data;
wire response1_val, response1_rdy;
wire [W-1:0] response1_result_bits_data;

wire arb_oper_val, arb_oper_rdy;
assign arb_oper_val = A_deq_vld & B_deq_vld;
assign operands_rdy = A_enq_rdy & B_enq_rdy;

wire arb_result_val;
wire [W-1:0] data_result;
wire C_enq_rdy;

// Instantiate gcd_arbiter
gcd_arbiter#(W) GCDarbiter(
  .clk(clk),
  .reset(reset),
    // this will be connected to the input FIFO
  .operands_val(arb_oper_val),
  .operands_bits_A(A_fifo),
  .operands_bits_B(B_fifo),
  .operands_rdy(arb_oper_rdy),

  .request0_val(request0_val),
  .request0_operands_bits_A(request0_operands_bits_A),
  .request0_operands_bits_B(request0_operands_bits_B),
  .request0_rdy(request0_rdy),

  .request1_val(request1_val),
  .request1_operands_bits_A(request1_operands_bits_A),
  .request1_operands_bits_B(request1_operands_bits_B),
  .request1_rdy(request1_rdy),

  // This will be connected to the output FIFO
  .result_val(arb_result_val),
  .result_bits_data(data_result),
  .result_rdy(C_enq_rdy),

  .response0_val(response0_val),
  .response0_result_bits_data(response0_result_bits_data),
  .response0_rdy(response0_rdy),

  .response1_val(response1_val),
  .response1_result_bits_data(response1_result_bits_data),
  .response1_rdy(response1_rdy)
);
// Instantiate request FIFO
fifo#(W) request_A (
  .clk(clk),
  .reset(reset),

  .enq_val(operands_val),
  .enq_data(operands_bits_A),
  .enq_rdy(A_enq_rdy),

  .deq_val(A_deq_vld),
  .deq_data(A_fifo),
  .deq_rdy(arb_oper_rdy)
);
fifo#(W) request_B (
  .clk(clk),
  .reset(reset),

  .enq_val(operands_val),
  .enq_data(operands_bits_B),
  .enq_rdy(B_enq_rdy),

  .deq_val(B_deq_vld),
  .deq_data(B_fifo),
  .deq_rdy(arb_oper_rdy)
);
// Instantiate response FIFO
fifo#(W) response (
  .clk(clk),
  .reset(reset),

  .enq_val(arb_result_val),
  .enq_data(data_result),
  .enq_rdy(C_enq_rdy),

  .deq_val(result_val),
  .deq_data(result_bits),
  .deq_rdy(1'b1)
);
// Instantiate gcd_unit
gcd_unit#(W) GCDunit0(
  .clk(clk),
  .reset(reset),
  .operands_val(request0_val),
  .operands_bits_A(request0_operands_bits_A),
  .operands_bits_B(request0_operands_bits_B),
  .operands_rdy(request0_rdy),
  .result_val(response0_val),
  .result_bits_data(response0_result_bits_data),
  .result_rdy(response0_rdy)
);
gcd_unit#(W) GCDunit1(
  .clk(clk),
  .reset(reset),
  .operands_val(request1_val),
  .operands_bits_A(request1_operands_bits_A),
  .operands_bits_B(request1_operands_bits_B),
  .operands_rdy(request1_rdy),
  .result_val(response1_val),
  .result_bits_data(response1_result_bits_data),
  .result_rdy(response1_rdy)
);

endmodule

// Top Level Design: Use a parameter to choose either one
module gcd_coprocessor #( parameter W = 32 , parameter TARGET_NUMBER_OF_CYCLES = 325)(	
  input clk,
  input reset,

  input operands_val,
  input [W-1:0] operands_bits_A,
  input [W-1:0] operands_bits_B,
  output operands_rdy,

  output result_val,
  output [W-1:0] result_bits,
  input result_rdy
  );

  generate
  	if (TARGET_NUMBER_OF_CYCLES >= 325)
      gcd_coprocessor_single #(W) g0 (
      .clk(clk),
      .reset(reset),
      .operands_val(operands_val),
      .operands_bits_A(operands_bits_A),
      .operands_bits_B(operands_bits_B),
      .operands_rdy(operands_rdy),
      .result_val(result_val),
      .result_bits(result_bits),
      .result_rdy(result_rdy)
      );
    else
      gcd_coprocessor_dual #(W) g1 (
      .clk(clk),
      .reset(reset),
      .operands_val(operands_val),
      .operands_bits_A(operands_bits_A),
      .operands_bits_B(operands_bits_B),
      .operands_rdy(operands_rdy),
      .result_val(result_val),
      .result_bits(result_bits),
      .result_rdy(result_rdy)
      );
  endgenerate

endmodule