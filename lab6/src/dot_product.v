// Implement a vector dot product of a and b
// using a single-port SRAM of 5-bit address width, 16-bit data width

module dot_product #(
  localparam ADDR_WIDTH = 5,
  localparam WIDTH = 32
) (
  input clk,
  input rst,

  input [ADDR_WIDTH:0] len,

  // input vector a
  input [WIDTH-1:0] a_data,
  input a_valid,
  output reg a_ready,

  // input vector b
  input [WIDTH-1:0] b_data,
  input b_valid,
  output reg b_ready,

  // dot product result c
  output [WIDTH-1:0] c_data,
  output reg c_valid,
  input c_ready
);

// Feel free to change these.
localparam STATE_READ = 2'd0;
localparam STATE_CALC_LOAD_A = 2'd1;
localparam STATE_CALC_LOAD_B = 2'd2;
localparam STATE_CALC_DONE = 2'd3;

wire a_fire, b_fire, c_fire;
assign a_fire = a_valid && a_ready;
assign b_fire = b_valid && b_ready;
assign c_fire = c_valid && c_ready;

reg we;
wire [3:0] wmask = 4'b1111;
reg [ADDR_WIDTH:0] addr;
reg [WIDTH-1:0] din;
wire [WIDTH-1:0] dout;

reg [WIDTH-1:0] a_temp_r, a_temp_w;
reg [WIDTH-1:0] b_temp_r, b_temp_w;
reg [2*WIDTH-1:0] dot_temp_r, dot_temp_w;

reg [1:0] state, state_nxt;
reg [ADDR_WIDTH-1:0] cnt_a, cnt_b, cnt;

sram22_64x32m4w8 sram (
  .clk(clk),
  .we(we),
  .wmask(wmask),
  .addr(addr),
  .din(din),
  .dout(dout)
);

// TODO: fill in the rest of this module.
always@(*)begin
  we = 0;
  addr = 0;
  din = 0;
  a_temp_w = a_temp_r;
  b_temp_w = b_temp_r;
  dot_temp_w = dot_temp_r;
  state_nxt = state;
  c_valid = 0;
  case(state)
    STATE_READ:
    begin
      we = 1;

      if(a_fire)begin
        din = a_data;
        addr = cnt_a;
      end
      else if(b_fire)begin
        din = b_data;
        addr = 32 + cnt_b;
      end
      else begin
        din = 0;
        addr = 0;
      end

      if(cnt_a+cnt_b == (len<<1))begin
        we = 0;
        addr = cnt;
        state_nxt = STATE_CALC_LOAD_A;
      end
      else 
        state_nxt = state;
    end
    STATE_CALC_LOAD_A:
    begin
      we = 0;
      addr = cnt + 32;
      a_temp_w = dout;
      if(cnt != 0)
        dot_temp_w = dot_temp_r + b_temp_r * a_temp_r;
      else
        dot_temp_w = 0;

      if(cnt == len)
        state_nxt = STATE_CALC_DONE;
      else 
        state_nxt = STATE_CALC_LOAD_B;
    end
    STATE_CALC_LOAD_B:
    begin
      addr = cnt;
      b_temp_w = dout;
      // if(cnt == len)
      //   state_nxt = STATE_CALC_DONE;
      // else 
        state_nxt = STATE_CALC_LOAD_A;
    end
    STATE_CALC_DONE:
    begin
      c_valid = 1;
      if(c_fire)
        state_nxt = STATE_READ;
      else 
        state_nxt = state;
    end
    default:
      state_nxt = state;
  endcase
end

always@(posedge clk or posedge rst)begin
  if(rst)begin
    state <= STATE_READ;
    a_temp_r <= 0;
    b_temp_r <= 0;
    dot_temp_r <= 0;
  end
  else begin
    state <= state_nxt;
    a_temp_r <= a_temp_w;
    b_temp_r <= b_temp_w;
    dot_temp_r <= dot_temp_w;
  end
end

always@(posedge clk or posedge rst)begin
  if(rst)begin
    cnt_a <= 0;
    cnt_b <= 0;
    cnt <= 0;
  end
  else if (state == STATE_READ && a_fire) begin
    cnt_a <= cnt_a + 1;
    cnt_b <= cnt_b;
    cnt <= cnt;
  end
  else if (state == STATE_READ && b_fire) begin
    cnt_b <= cnt_b + 1;
    cnt_a <= cnt_a;
    cnt <= cnt;
  end
  else if (state == STATE_CALC_LOAD_A) begin
    cnt <= cnt + 1;
    cnt_a <= cnt_a;
    cnt_b <= cnt_b;
  end
  else if (state == STATE_CALC_DONE) begin
    cnt_a <= 0;
    cnt_b <= 0;
    cnt <= 0;
  end
  else begin
    cnt <= cnt;
    cnt_a <= cnt_a;
    cnt_b <= cnt_b;
  end
end

assign a_ready = 1;
assign b_ready = 1;
assign c_data = dot_temp_r;

endmodule
