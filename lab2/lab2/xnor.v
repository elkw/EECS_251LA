module xnor (
  input [1:0] A, B, 
  output reg Y
);
  assign Y = ~(A[1]^B[1]) & ~(A[0]^B[0]);
endmodule