`include "/home/ff/eecs151/verilog_lib/EECS151.v"

module divider #(
    WIDTH = 32
) (
  input clk,
  input rst,
  input start,
  output done,

  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output [WIDTH-1:0] quotient,
  output [WIDTH-1:0] remainder
);

  // Feel free to change the code as long as your final code implements a divider
  // Check the algorithm described in the slides (URL in the spec)
  // Pay attention to the block diagram(s)

  // Definition of states
  parameter IDLE = 2'd0;
  parameter DIV = 2'd1;
  parameter DONE = 2'd2;

  // Initiation of Reg and Wire
  reg [1:0] state, nxt_state;
  reg [4:0] cnt, nxt_cnt;
  reg [2*WIDTH-1:0] shiftreg, nxt_shiftreg;
  reg [WIDTH:0] alu_out;

  // FSM
  always@(*) begin
    case(state)
      IDLE:
      begin
        if(start)
          nxt_state = DIV;
        else
          nxt_state = state;
      end
      DIV:
      begin
        if(cnt != (WIDTH-1))
          nxt_state = state;
        else
          nxt_state = DONE;
      end
      DONE:
        nxt_state = IDLE;
      default:
        nxt_state = IDLE;
    endcase
  end

  // Counter
  always@(*) begin
    if(state == 1)
      nxt_cnt = cnt + 5'd1;
    else if (state == 0)
      nxt_cnt = 5'd0;
    else
      nxt_cnt = cnt;
  end

  // ALU
  always@(*) begin
    if(state == 1) begin
      if (shiftreg[2*WIDTH-2:WIDTH-1] >= divisor)
        alu_out = {1'b1, (shiftreg[2*WIDTH-2:WIDTH-1] - divisor)};
      else
        alu_out = {1'b0, shiftreg[2*WIDTH-2:WIDTH-1]};
    end
    else
      alu_out = 0;
  end

  // Shift Register
  always@(*) begin
    case(state)
      IDLE:
      begin
        if(start)
          nxt_shiftreg = {{WIDTH{1'b0}}, dividend};
        else
          nxt_shiftreg = shiftreg;
      end
      DIV:
      begin
        if(alu_out[WIDTH] == 1'b1)
          nxt_shiftreg = {alu_out[WIDTH-1:0], shiftreg[WIDTH-2:0], 1'b1};
        else
          nxt_shiftreg = {alu_out[WIDTH-1:0], shiftreg[WIDTH-2:0], 1'b0};
      end
      DONE:
        nxt_shiftreg = shiftreg;
      default:
        nxt_shiftreg = shiftreg;
    endcase
  end

  // Sequential
  always@(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      cnt <= 5'd0;
      shiftreg <= 0;
    end
    else begin
      state <= nxt_state;
      cnt <= nxt_cnt;
      shiftreg <= nxt_shiftreg;
    end
  end

  assign quotient  = shiftreg[WIDTH-1:0];
  assign remainder = shiftreg[2*WIDTH-1:WIDTH];
  assign done = (state == 2) ? 1 : 0;
endmodule
