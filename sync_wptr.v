/*This module is a 2 flop synchronizer for write pointer using rclk*/

module sync_wptr#(parameter ADDRSIZE = 4)
                 (input [ADDRSIZE:0] wptr ,
                  input rclk, 
                  input rrst,
                  output reg [ADDRSIZE:0] rd_wptr);
reg [ADDRSIZE:0] rd_wptr1;

//Address moves from one set of registers to another                
always @(posedge rclk or negedge rrst) begin
    if(!rrst) {rd_wptr,rd_wptr1} <= 0;
    else {rd_wptr,rd_wptr1} <= {rd_wptr1, wptr};
end
                  
endmodule                  