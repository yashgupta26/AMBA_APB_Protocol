`include "APB_master.v"
`include "APB_slave.v"

module APB_top(input PCLK,
               input PRESETn,
               input Transfer,
               input Wr_Rd,
               input [4:0] Address,
               input [31:0] write_data,
               output [31:0] read_data);
    
    wire [4:0] PADDR;
    wire [31:0] PWDATA,PRDATA;
    wire PSELx,PENABLE,PWRITE,PREADY,PSLVERR;
    
    APB_master Design_master(Transfer,Wr_Rd,Address,write_data,read_data,PCLK,PRESETn,PREADY,PRDATA,PSLVERR,PADDR,PSELx,PENABLE,PWRITE,PWDATA);
    APB_slave Design_slave(PCLK,PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA,PREADY,PRDATA,PSLVERR);
    
endmodule
