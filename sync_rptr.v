/*This module is a 2 flop synchronizer for read pointer using wclk*/

module sync_rptr #(parameter ADDRSIZE = 4)
                  (input [ADDRSIZE:0]rptr,
                   input wclk,
                   input wrst,
                   output reg [ADDRSIZE:0] wd_rptr);
reg [ADDRSIZE:0] wd_rptr1;

//Address moves from one set of registers to another
always @(posedge wclk or negedge wrst) begin
    if (!wrst) {wd_rptr, wd_rptr1} <= 0;
    else {wd_rptr, wd_rptr1} <= {wd_rptr1, rptr};
end                   
                   
endmodule                   