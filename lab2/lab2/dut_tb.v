`timescale 1 ns /  1 ps

module dut_tb();

reg A, B, clk;
wire X, Z;

integer i=0;

initial clk = 1;
always #(`CLOCK_PERIOD/2) clk <= ~clk;

dut m0 ( .A(A), .B(B), .clk(clk), .X(X), .Z(Z) );
initial begin

$vcdpluson;
  A <= 1'b0;
  B <= 1'b0;
  repeat(9) #(`CLOCK_PERIOD/4);
  B <= 1'b1;  
  repeat(2) #(`CLOCK_PERIOD/4);
  A <= 1'b1;
  repeat(2) #(`CLOCK_PERIOD/4);
  A <= 1'b0;
  repeat(5) #(`CLOCK_PERIOD/4); 
  B <= 1'b0;
  repeat(6) #(`CLOCK_PERIOD/4); 
$vcdplusoff;
$finish;

end

reg [2:0] index_counter;
initial index_counter = 0;
wire Out_X;
wire [5:0] Out_X_array;
wire Out_Z;
wire [5:0] Out_Z_array;
assign Out_X_array[0] = 1'bx;
assign Out_X_array[1] = 0;
assign Out_X_array[2] = 0;
assign Out_X_array[3] = 1;
assign Out_X_array[4] = 1;
assign Out_X_array[5] = 0;
assign Out_X = Out_X_array[index_counter];
assign Out_Z_array[0] = 1'bx;
assign Out_Z_array[1] = 1'bx;
assign Out_Z_array[2] = 0;
assign Out_Z_array[3] = 1;
assign Out_Z_array[4] = 1;
assign Out_Z_array[5] = 1;
assign Out_Z = Out_Z_array[index_counter];
always @(negedge clk) begin
        $display($time, ": X should be %d, got %d", Out_X, X);
        $display($time, ": Z should be %d, got %d", Out_Z, Z);
        index_counter <= index_counter + 1;
end

endmodule
