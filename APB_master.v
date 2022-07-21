module APB_master(input Transfer,              //temp signals for master input
                  input Wr_Rd,                 //temp signals for master input
                  input [4:0] Address,         //temp signals for master input
                  input [31:0] write_data,     //temp signals for master input
                  output reg [31:0] read_data, //temp signals for master input
                  input PCLK,                  //clock
                  input PRESETn,               //active low async reset
                  input PREADY,                //input by slave
                  input [31:0] PRDATA,         //32 bit bus to read data
                  input PSLVERR,               //Error signal by slave
                  output reg [4:0] PADDR,      //32 bit address
                  output reg PSELx,            //select slave
                  output reg PENABLE,          //indicate 2nd or subsequent cycle
                  output reg PWRITE,           //high->write, low->read
                  output reg [31:0] PWDATA);   //32 bit bus to write data
    
    parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b10;
    reg [1:0] ps,ns;
    
    
    always @(posedge PCLK) begin
        if (!PRESETn)
            ps <= IDLE;
        else
            ps <= ns;
    end
    
    always @(ps,Transfer,PREADY) begin
        if (!PRESETn  || !Transfer)
            ns <= IDLE;
        else
        begin
            PWRITE = Wr_Rd;
            
            case (ps)
                
                IDLE:begin
                    PSELx   = 0;
                    PENABLE = 0;
                    ns <= SETUP;
                end
                
                SETUP:begin
                    PSELx   = 1;
                    PENABLE = 0;
                    PADDR   = Address;
                    
                    if (PWRITE)
                        PWDATA   <= write_data;
                    
                    if (!PSLVERR)
                        ns <= ACCESS;
                    else
                        ns <= IDLE;
                end
                
                ACCESS:begin
                    PSELx   = 1;
                    PENABLE = 1;
                    if (!PSLVERR)
                    begin
                        if (!PREADY) begin
                            if (PWRITE) begin
                                ns <= ACCESS;
                            end
                            else if (!PWRITE) begin
                                read_data = PRDATA;
                                ns <= ACCESS;
                            end
                        end
                        else if (PREADY)
                            ns <= SETUP;
                    end
                    else
                        ns <= IDLE;
                end
                        
                default: ns <= IDLE;
            endcase
        end
                    
    end
                
endmodule
