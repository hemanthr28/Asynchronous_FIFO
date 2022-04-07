/*Top level wrapper for all the modules in the asynchronous FIFO*/

module async_fifo #(parameter DATASIZE = 8,
                    parameter ADDRSIZE = 8)
                    (input wclk, wrst, winc,
                     input rclk, rrst, rinc,
                     input [DATASIZE-1:0] wdata,
                     output [DATASIZE-1:0] rdata,
                     output wfull,
                     output rempty);
                     
wire [ADDRSIZE-1:0] waddr, raddr;
wire [ADDRSIZE:0] rd_wptr, wd_rptr, rptr, wptr;

fifomemory #(DATASIZE, ADDRSIZE) fifomem (.wdata(wdata), .winc(winc), .wfull(wfull), .waddr(waddr), .raddr(raddr), .wclk(wclk), .rdata(rdata));
wdomain #(ADDRSIZE) wdomain1 (.wclk(wclk), .winc(winc), .wfull(wfull), .waddr(waddr), .wrst(wrst), .wd_rptr(wd_rptr), .wptr(wptr));
rdomain #(ADDRSIZE) rdomain1 (.rclk(rclk), .rinc(rinc), .rempty(rempty), .raddr(raddr), .rrst(rrst), .rd_wptr(rd_wptr), .rptr(rptr));
sync_wptr #(ADDRSIZE) sync_wptr1 (.wptr(wptr), .rclk(rclk), .rrst(rrst), .rd_wptr(rd_wptr));
sync_rptr #(ADDRSIZE) sync_rptr1 (.rptr(rptr), .wclk(wclk), .wrst(wrst), .wd_rptr(wd_rptr));

endmodule                 