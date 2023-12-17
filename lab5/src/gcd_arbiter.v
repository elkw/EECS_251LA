module gcd_arbiter #(parameter W = 32) (
  input clk,
  input reset,

  // this will be connected to the input FIFO
  input operands_val,
  input [W-1:0] operands_bits_A,
  input [W-1:0] operands_bits_B,
  output operands_rdy,

  output request0_val,
  output [W-1:0] request0_operands_bits_A,
  output [W-1:0] request0_operands_bits_B,
  input request0_rdy,

  output request1_val,
  output [W-1:0] request1_operands_bits_A,
  output [W-1:0] request1_operands_bits_B,
  input request1_rdy,

  // This will be connected to the output FIFO
  output result_val,
  output [W-1:0] result_bits_data,
  input result_rdy,

  input response0_val,
  input [W-1:0] response0_result_bits_data,
  output response0_rdy,

  input response1_val,
  input [W-1:0] response1_result_bits_data,
  output response1_rdy
);

// Keep track of which GCD unit you will enqueue to next
reg request = 0;
// Keep track of which GCD unit you will dequeue from next
reg response = 0;
// Define our "fire" wires
wire operands_fire, request0_fire, request1_fire, result_fire, response0_fire, response1_fire;

// Wires and assignments go here
// Hint: Most of your code will be assignments
assign operands_fire = operands_val & operands_rdy;
assign request0_fire = request0_val & request0_rdy;
assign request1_fire = request1_val & request1_rdy;
assign result_fire = result_val & result_rdy;
assign response0_fire = response0_val & response0_rdy;
assign response1_fire = response1_val & response1_rdy;

assign operands_rdy = request0_rdy | request1_rdy;
assign request0_val = (!request) ? operands_val : 0;
assign request1_val = ( request) ? operands_val : 0;

assign result_val = (response0_val & (!response)) | (response1_val & response);
assign response0_rdy = (!response) ? result_rdy : 0;
assign response1_rdy = ( response) ? result_rdy : 0;

assign request0_operands_bits_A = (operands_fire & request0_fire) ? operands_bits_A : 0;
assign request0_operands_bits_B = (operands_fire & request0_fire) ? operands_bits_B : 0;
assign request1_operands_bits_A = (operands_fire & request1_fire) ? operands_bits_A : 0;
assign request1_operands_bits_B = (operands_fire & request1_fire) ? operands_bits_B : 0;
assign result_bits_data = (result_fire & response0_fire) ? response0_result_bits_data 
                        : (result_fire & response1_fire) ? response1_result_bits_data : 0;
// Sequential logic goes here
// Be sure to implement reset! Look at fifo.v for an example
always@(posedge clk or posedge reset)begin
    if(reset)begin
        request <= 0;
    end
    else if(operands_fire)begin
        if(request0_fire)begin
            request <= 1;
        end
        else if(request1_fire)begin
            request <= 0;
        end
    end
end
always@(posedge clk or posedge reset)begin
    if(reset)begin
        response <= 0;
    end
    else if(result_fire)begin
        if(response0_fire)begin
            response <= 1;
        end
        else if(response1_fire)begin
            response <= 0;
        end
    end
end
endmodule