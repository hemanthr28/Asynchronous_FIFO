/*This module generated all read domain signals*/

module rdomain #(parameter ADDRSIZE = 4)
                (input rclk,
                 input rrst,
                 input rinc,
                 input [ADDRSIZE:0] rd_wptr,
                 output [ADDRSIZE-1:0] raddr ,
                 output reg [ADDRSIZE:0] rptr ,
                 output reg rempty);
                 
reg [ADDRSIZE:0] rbin_addr;
wire [ADDRSIZE:0] rgraynext, rbinnext;

//update the binary and gray address with the next values
always @(posedge rclk or negedge rrst) begin
    if(!rrst) {rbin_addr, rptr} <= 0;
    else {rbin_addr, rptr} = {rbinnext, rgraynext};
end 

assign raddr = rbin_addr[ADDRSIZE-1:0];
assign rbinnext = rbin_addr + rinc;
assign rgraynext = (rbin_addr >> 1) ^ rbin_addr;
assign rempty_val = (rgraynext == rd_wptr);

//assert empty signal
always @(posedge rclk or negedge rrst) begin 
    if (!rrst) rempty <= 0;
    else rempty <= rempty_val;
end
        
endmodule                 
                 