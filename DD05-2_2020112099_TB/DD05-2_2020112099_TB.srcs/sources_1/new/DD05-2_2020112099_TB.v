`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 11:48:04
// Design Name: 
// Module Name: delay_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module delay_tb;
reg A,B,C;

wire O;

delay d1(A,B,C,O);

initial
begin
   #0 A=0;B=0;C=0;
   #10 A=1;B=1;C=1;
   #20 B=0;C=0;
   #10 B=1;
   #2 B=0;
   #2 C=1;
   #1 C=0;
   #15 $finish;
end
endmodule