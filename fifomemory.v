/*Fifo Memory module*/

module fifomemory #(parameter DATASIZE = 8, //Length of the data 
                    parameter ADDRSIZE = 4) //length of the address
                 (input [DATASIZE-1:0] wdata, //Inputs and outputs
                  input winc, 
                  input wfull,
                  input [ADDRSIZE-1:0] waddr, 
                  input [ADDRSIZE-1:0] raddr, 
                  input wclk, 
                  output [DATASIZE-1:0] rdata);

localparam DEPTH = 1 << ADDRSIZE; //In this case 2^4 = 16 memory locations are created
reg [DATASIZE-1:0] memory [DEPTH-1:0]; 

assign rdata = memory[raddr]; //read the data

always @(posedge wclk) begin //write on posedge of the clock
    if (winc && ! wfull) memory[waddr] <= wdata; //write increment full have effect only when wfull is not asserted
end                 
endmodule
