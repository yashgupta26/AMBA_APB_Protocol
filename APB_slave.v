module APB_slave(input PCLK,               //clock
                 input PRESETn,            //active low reset
                 input [4:0] PADDR,        //32 bit address
                 input PSELx,              //select slave
                 input PENABLE,            //indicate 2nd or subsequent cycle
                 input PWRITE,             //high->write, low->read
                 input [31:0]PWDATA,       //32 bit Data Bus
                 output reg PREADY,        //ready status by slave
                 output reg [31:0] PRDATA, //32 bit Data Bus
                 output reg PSLVERR = 0);  //Error occurred
    
    reg [31:0] mem [0:31]; //32 bit wide and 32 locations
    
    reg [31:0] temp_data;
    
    always @(*) begin
        if (!PRESETn)
        begin
            PREADY  = 0;
            PSLVERR = 0;
        end
        else
        begin
            if (PSELx && !PENABLE && !PWRITE) begin  //setup stage READ
                PREADY = 0;
            end
            else if (PSELx && PENABLE && !PWRITE) begin  //access stage READ
                PREADY = 1;
                PRDATA = mem[PADDR];
            end
            else if (PSELx && !PENABLE && PWRITE) begin  //setup stage write
                PREADY = 0;
            end
            else if (PSELx && PENABLE && PWRITE) begin  //access stage write
                PREADY     = 1;
                mem[PADDR] = PWDATA;
            end
            else
                PREADY = 0;
        end
    end
    
    
endmodule
