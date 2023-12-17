//=========================================================================
// FIFO Template
//-------------------------------------------------------------------------
//
//`include "EECS151.v"

module fifo #(parameter WIDTH = 8, parameter LOGDEPTH = 3) (
    input clk,
    input reset,

    input enq_val,
    input [WIDTH-1:0] enq_data,
    output enq_rdy,

    output deq_val,
    output [WIDTH-1:0] deq_data,
    input deq_rdy
);

localparam DEPTH = (1 << LOGDEPTH);
// the buffer itself. Take note of the 2D syntax.
reg [WIDTH-1:0] buffer [DEPTH-1:0];
// read pointer, write pointer
reg [LOGDEPTH-1:0] rptr = 0;
reg [LOGDEPTH-1:0] wptr = 0;
// is the buffer full? This is needed for when rptr == wptr
reg full = 0;
// Define any additional regs or wires you need (if any) here
integer i;
// use "fire" to indicate when a valid transaction has been made
wire enq_fire;
wire deq_fire;

assign enq_fire = enq_val & enq_rdy;
assign deq_fire = deq_val & deq_rdy;
assign enq_rdy = !full;
assign deq_val = ((wptr != rptr)|| full);
assign deq_data = buffer[rptr];

// Your code here (don't forget the reset!)
always@(posedge clk or posedge reset)begin
    if(reset)begin
        for(i = 0; i<DEPTH; i++)begin
            buffer[i] <= 0;
        end
        rptr <= 0;
        wptr <= 0;
        full <= 0;
    end
    else begin
        if(enq_fire)begin
            buffer[wptr] <= enq_data;
            wptr <= wptr + 1;
            if(wptr + 1 == rptr || ((wptr==7)&&(rptr==0)))
                full <= 1;
        end
        if(deq_fire)begin
            rptr <= rptr + 1;
            full <= 0;
        end
    end
end
endmodule