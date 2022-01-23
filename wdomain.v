/*This module generated all the write domain signals*/

module wdomain #(parameter ADDRSIZE = 4) //length of the address
               (input wclk,
                input winc, 
                input wrst,
                input [ADDRSIZE:0] wd_rptr , //read pointer ssynced with write clock
                output [ADDRSIZE-1:0] waddr ,
                output reg [ADDRSIZE:0] wptr ,
                output reg wfull);
                
reg [ADDRSIZE:0] wbin_addr;
wire [ADDRSIZE:0] wgraynext, wbinnext;

//update the binary and gray address with the next values
always @(posedge wclk or negedge wrst) begin
    if (!wrst) {wbin_addr, wptr} <= 0;     
    else {wbin_addr, wptr} <= {wbinnext, wgraynext};
end

assign waddr = wbin_addr[ADDRSIZE-1:0]; //waddr will be n-1 bits
assign wbinnext = wbin_addr + (winc + ~wfull); //Increment the binary address counter only when wfull is reset
assign wgraynext = (wbinnext >> 1) ^ wbinnext; //Increment the gray address
assign wfull_val = (wgraynext == {~wd_rptr[ADDRSIZE:ADDRSIZE-1], wd_rptr[ADDRSIZE-2:0]}); //check for full condtion

//assert full signal
always @(posedge wclk or negedge wrst) begin
    if (!wrst) wfull <= 1'b0;
    else wfull <= wfull_val;
end

endmodule