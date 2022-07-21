module APB_tb;
    reg PCLK, PRESETn, Transfer, Wr_Rd; 
    reg [4:0] Address; 
    reg [31:0] write_data; 
    wire [31:0] read_data; 
    APB_top DUT (PCLK,PRESETn,Transfer,Wr_Rd,Address,write_data,read_data);
    
    initial begin
        PCLK = 0;
        forever begin
            #5 PCLK = ~PCLK;
        end
    end
    
    
    initial begin
        PRESETn  = 1;
        Transfer = 1;
        
        //Write Operation 1
        Address = 5'b10010;
        #10
        Wr_Rd      = 1;
        write_data = 32'hDEADBEEF;
        #10
        
        //Write Operation 2
        Address    = 5'b10101;
        Wr_Rd      = 1;
        write_data = 32'hDABBCAFE;
        #30
        write_data = 32'hx;
        #10
        Transfer     = 0;
        #15 Transfer = 1;

        //Read Operation 1
        Wr_Rd   = 0;
        Address = 5'b10010;
        
        //Read Operation 2
        #30
        Address = 5'b10101;
        
        #20 Transfer = 0;
        #20 $finish;
        
    end
    
    
    initial begin
        $dumpfile("APB_wave.vcd");
        $dumpvars;
    end
    
endmodule
