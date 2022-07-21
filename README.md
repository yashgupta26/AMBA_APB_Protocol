# AMBA_APB_Protocol

This repositary contains Verilog code for AMBA 3 APB Protocol.  

The Advanced Peripheral Bus (APB) is part of the Advanced Microcontroller Bus Architecture (AMBA) protocol family. It defines a low-cost interface that is optimized for minimal power consumption and reduced interface complexity.The APB protocol is not pipelined, use it to connect to low-bandwidth peripherals that do not require the high performance of the AXI protocol.

The APB protocol relates a signal transition to the rising edge of the clock, to simplify the integration of APB peripherals into any design flow. Every transfer takes at least two cycles.

You can use it to access the programmable control registers of peripheral devices.

### State Diagram

![FSM](https://github.com/yashgupta26/AMBA_APB_Protocol/blob/master/State%20Diagram.jpg)

### RTL Schematic

![Schematic](https://github.com/yashgupta26/AMBA_APB_Protocol/blob/master/RTL_Schematic.jpg)

### Waveform

![Wave](https://github.com/yashgupta26/AMBA_APB_Protocol/blob/master/waveform.jpg)


### To Execute the code

Use any EDA/Simulation tool to run the codes or visit https://www.edaplayground.com/x/dMmT to run this code.

If you have iverilog installed locally, run the below commands <br>  
i.) To compile -> iverilog -o APB APB_top.v APB_tb.v <br>
ii.) To view the simulation result -> vvp APB <br>
iii.) To view waveform -> gtkwave "APB_wave.vcd"  <br>



For more info, visit arm website https://developer.arm.com/documentation/ihi0024/c/Introduction/About-the-APB-protocol

