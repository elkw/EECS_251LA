full_check: assert property ( 
    @(posedge clk) disable iff(reset)
    ($past(full) === 1'b1) |-> (wptr == $past(wptr))
);
empty_check: assert property ( 
    @(posedge clk) disable iff(reset)
    ($past(wptr) === $past(rptr) && deq_fire && full !== 1'b1) |-> (rptr == $past(rptr))
);
rptr_rst: assert property ( 
    @(posedge clk)
    (reset === 1'b1) |-> (rptr == 3'b0)
);
wptr_rst: assert property ( 
    @(posedge clk)
    (reset === 1'b1) |-> (wptr == 3'b0)
);
full_rst: assert property ( 
    @(posedge clk)
    (reset === 1'b1) |-> (full == 3'b0)
);