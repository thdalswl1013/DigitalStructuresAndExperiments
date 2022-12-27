`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/23 12:15:18
// Design Name: 
// Module Name: simulate
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

module simulate;
reg CLK, nRST, X_IN;
wire Y_OUT;

func in(CLK, nRST, X_IN, Y_OUT);


initial
begin
nRST = 0;
CLK = 0;
X_IN = 0;

#40 X_IN = 1;
#100 X_IN = 0;
#50 X_IN = 1;
#10 X_IN = 0; 
#100 $finish;

end

always
#5 CLK = ~CLK;

initial
#20 nRST = 1;

endmodule
