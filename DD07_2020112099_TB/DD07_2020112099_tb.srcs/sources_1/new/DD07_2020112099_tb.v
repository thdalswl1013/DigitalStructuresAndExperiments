`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/16 14:06:10
// Design Name: 
// Module Name: stimulus
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
module stimulus;

wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD, CLOCK, CLEAR;
reg [2:0] y2rdelay, r2gdelay;

func f1(.hwy(MAIN_SIG), .cntry(CNTRY_SIG), .X(CAR_ON_CNTRY_RD), .clock(CLOCK), .clear(CLEAR), .y2rdelay(y2rdelay), .r2gdelay(r2gdelay));

initial
begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

initial
begin
    CLEAR = 1;
    #50 CLEAR = 0;
end

initial
begin
   y2rdelay = 4;
   r2gdelay = 3;
end

initial
begin
    CAR_ON_CNTRY_RD = 0;
    #200 CAR_ON_CNTRY_RD = 1;
    #100 CAR_ON_CNTRY_RD = 0;
    #200 CAR_ON_CNTRY_RD = 1;
    #100 CAR_ON_CNTRY_RD = 0;
    #200 CAR_ON_CNTRY_RD = 1;
    #100 CAR_ON_CNTRY_RD = 0;
    #100 $stop;
end
endmodule