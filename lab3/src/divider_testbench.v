`timescale 1 ns /  100 ps
`define NUM_DATA 10 //changable

module divider_testbench;

  localparam integer WIDTH = 32; //changable

  reg clk = 0;
  always #(`CLOCK_PERIOD/2) clk = ~clk;
  reg rst;

  reg start;
  reg [WIDTH-1:0] dividend, divisor;
  wire [WIDTH-1:0] quotient, remainder;
  reg  [WIDTH-1:0] quotient_ans, remainder_ans;
  wire done;

  parameter num_data = `NUM_DATA;
  integer i;
  integer err_div = 0;

  divider #(.WIDTH(WIDTH)) div_dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .done(done),
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  always @(posedge clk) begin
    if(done)
    $display("At time %d: start %d, done %d, dividend %d, divisor %d, quotient %d, remainder %d",
      $time, start, done, dividend, divisor, quotient, remainder);
  end

  // TODO: Add more tests
  initial begin
    #0;
    start = 0;
    dividend = 0;
    divisor = 1;

    rst = 0;
    @(posedge clk)
    rst = 1;
    @(posedge clk)
    rst = 0;

    // @(posedge clk);
    // start = 1;
    // dividend = 15;
    // divisor = 15;

    // @(posedge clk); start = 0; // 'start' is HIGH for one cycle
    // @(posedge clk);
    
    // // wait until 'done' is asserted
    // while (done == 0) begin
    //   @(posedge clk);
    // end

    // Division
    $display("Test function of division...");
    for (i=1; i<=`NUM_DATA; i=i+1)
    begin
        @(posedge clk);
        start = 1;
        dividend = $random()%32'hFFFF_FFFF  ;  // changable
        divisor  = $random()%32'h7FFF_FFFF +1; // changable
        quotient_ans  = dividend/divisor;
        remainder_ans = dividend%divisor;

        @(posedge clk);
        start = 0;

        while (done == 0) begin
          @(posedge clk);
        end

        if (done)
        begin
            if ((quotient !== quotient_ans) || (remainder !== remainder_ans))
            begin
                $display("Error at pattern number %3d", i);
                $display("\texpected answer: Q = %d, R = %d", quotient_ans, remainder_ans);
                $display("\t    your answer: Q = %d, R = %d", quotient    , remainder    );
                err_div = err_div + 1;
            end
        end
        else
        begin
            $display("Does not detect ready at pattern number %3d", i);
            err_div = err_div + 1;
        end
    end

    if ((err_div == 0))
    begin
        $display("-------------------------------------------");
        $display("-   Success!! You passed the simulation   -");
        $display("-         Division task correct           -");
        $display("-------------------------------------------\n");
    end
    else
    begin
        $display("-------------------------------------------");
        $display("- Wrong!! Please check your design again  -");
        $display("-------------------------------------------\n");
    end

    $finish();
  end

endmodule
