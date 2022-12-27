`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//project name: DD06_2020112099_TB
//////////////////////////////////////////////////////////////////////////////////

module tb;

reg CLK,nRST,X;
wire Y;

seq s(CLK,nRST,X,Y);

initial
begin
nRST = 0;
CLK = 0;
X=0;
end

initial
begin
   #20 nRST = 1; 
end

always
    #5 CLK = ~CLK;   
   
initial
   begin
   #40 X=1; //40ns
   #30 X=0; //70ns 
   #20 X=1; //90ns
   #10 X=0; //100ns
   #20 X=1; //120ns
   #40 X=0; //160ns
   #30 $finish; //190ns
   end

endmodule
