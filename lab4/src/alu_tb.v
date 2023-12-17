`timescale 1 ns /  100 ps
`define NUM_DATA 100 //changable
`define NUM_OP    12 //changable

module alu_tb;

  reg clk = 0;
  always #(`CLOCK_PERIOD/2) clk = ~clk;

  reg [31:0] a, b;
  reg [3:0]  alu_op;
  wire [31:0] out;

  reg [31:0] out_ans;
 
  parameter num_data = `NUM_DATA;
  parameter num_op   = `NUM_OP;
  integer i = 0;
  integer j = 0;
  integer err_alu = 0;
  integer err_total = 0;

  alu dut (
    .a(a),
    .b(b),
    .alu_op(alu_op),
    .out(out)
  );

  // TODO: Add more tests
  initial begin
    $vcdpluson;
    a = 0;
    b = 0;
    alu_op = 0;

    @(posedge clk)

    for (j=0; j< num_op  ; j=j+1)
    begin
        @(posedge clk);
        err_alu = 0;
        if(j === 11)
            alu_op = 15;
        else
            alu_op = j;
        $display("Test function %d of alu ...", j);
        for (i=1; i<= num_data; i=i+1)
        begin
            @(posedge clk);
            a = $random()%32'hFFFF_FFFF  ;  // changable
            b = $random()%32'hFFFF_FFFF  ;  // changable
            case(j)
                0: out_ans = a+b;
                1: out_ans = a-b;
                2: out_ans = a&b;
                3: out_ans = a|b;
                4: out_ans = a^b;
                5: out_ans = ($signed(b)>$signed(a)) ? 1:0;
                6: out_ans = (b>a) ? 1:0;
                7: out_ans = (a << b[4:0]);
                8: out_ans = ($signed(a) >>> b[4:0]);
                9: out_ans = (a >> b[4:0]);
                10:out_ans = b;
                11:out_ans = 0;
            endcase

            @(posedge clk);
            if(j === 2 | j === 3 | j === 4 | j === 7 | j === 8 | j === 9)
            $display("\t    a = %b, b = %b, out = %b", a, b, out);
            else
            $display("\t    a = %d, b = %d, out = %d", a, b, out);
            if ((out !== out_ans))
            begin
                $display("Error at pattern number %3d", i);
                $display("\texpected answer: out = %d", out_ans);
                $display("\t    your answer: out = %d", out);
                err_alu = err_alu + 1;
            end
        end
        if(err_alu !== 0)
        begin
            $display("-   Wrong!! You failed the simulation of operation %d with %d error(s) -", j, err_alu);
            err_total = err_total + err_alu;
        end
    end
    if ((err_total === 0))
    begin
        $display("-------------------------------------------");
        $display("-   Success!! You passed all simulation   -");
        $display("-            ALU task correct             -");
        $display("-------------------------------------------\n");
    end
    else
    begin
        $display("-------------------------------------------");
        $display("- Wrong!! Please check your design again  -");
        $display("-------------------------------------------\n");
    end

    $vcdplusoff;
    $finish;
end

//--------------------------------------------------------------------
// Timeout
//--------------------------------------------------------------------
// If something goes wrong, kill the simulation...
reg [  63:0] cycle_count = 0;
always @(posedge clk) begin
cycle_count = cycle_count + 1;
if (cycle_count >= 100000) begin
    $display("TIMEOUT");
    $finish;
end
end
endmodule
