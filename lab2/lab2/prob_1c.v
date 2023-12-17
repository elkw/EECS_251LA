module prob_1c (
  input A, clk,
  output reg X, Y
);
  assign Y = X & A;
  always @(posedge clk) begin
    X <= A;
  end
endmodule