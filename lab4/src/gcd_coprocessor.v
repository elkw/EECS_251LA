//=========================================================================
// Template for GCD coprocessor
//-------------------------------------------------------------------------
//

module gcd_coprocessor #( parameter W = 32 ) (
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