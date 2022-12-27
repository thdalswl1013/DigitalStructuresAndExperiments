`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 11:05:18
// Design Name: 
// Module Name: DD03_2020112099
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


module BCDtoDecimal(output [9:0] DECOut, input [3:0] BCDIn);

//output [9:0] DECOut;
//input [3:0] BCDIn;

assign DECOut = (BCDIn == 4'b0000) ? 10'b0000000001 :
                (BCDIn == 4'b0001) ? 10'b0000000010 :
                (BCDIn == 4'b0010) ? 10'b0000000100 :
                (BCDIn == 4'b0011) ? 10'b0000001000 :
                (BCDIn == 4'b0100) ? 10'b0000010000 :
                (BCDIn == 4'b0101) ? 10'b0000100000 :
                (BCDIn == 4'b0110) ? 10'b0001000000 :
                (BCDIn == 4'b0111) ? 10'b0010000000 :
                (BCDIn == 4'b1000) ? 10'b0100000000 :
                (BCDIn == 4'b1001) ? 10'b1000000000 :
                                    -1;

endmodule


module Top;

reg [3:0] bcdin;
wire [9:0] decout;

BCDtoDecimal x(.DECOut(decout), .BCDIn(bcdin));

initial
begin

    $monitor($time, " BCDIn = %2d --> DECOut = %b\n", bcdin, decout);
    
    bcdin = 4'b0000;
    #10 bcdin = 4'b0001;
    #10 bcdin = 4'b0010;
    #10 bcdin = 4'b0011;
    #10 bcdin = 4'b0100;
    #10 bcdin = 4'b0101;
    #10 bcdin = 4'b0110;
    #10 bcdin = 4'b0111;
    #10 bcdin = 4'b1000;
    #10 bcdin = 4'b1001;
    #10 bcdin = 4'b1010;
    #10 bcdin = 4'b1011;
    #10 bcdin = 4'b1100;
    #10 bcdin = 4'b1101;
    #10 bcdin = 4'b1110;
    #10 bcdin = 4'b1111;
    #10 bcdin = 4'b0000;
    
end
endmodule