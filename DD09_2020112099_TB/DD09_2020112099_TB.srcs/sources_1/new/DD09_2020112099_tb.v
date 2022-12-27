`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 20:19:28
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
reg clock;
reg [1:0] coin;
reg reset;
wire newspaper;

vend vendY (coin, clock, reset, newspaper);

initial
begin
    $display("\t\tTime Reset Newspaper\n");
    $monitor("%d %d %d", $time, reset, newspaper);
end

initial
begin
    clock = 0;
    coin = 0;
    reset = 1;
    #50 reset = 0;
    @(negedge clock);
    #80 coin = 1; #40 coin = 0;
    #80 coin = 1; #40 coin = 0;
    #80 coin = 1; #40 coin = 0;
    #180 coin = 1; #40 coin = 0;
    #80 coin = 2; #40 coin = 0;
    #180 coin = 2; #40 coin = 0;
    #80 coin = 2; #40 coin = 0;
    #180 coin = 2; #40 coin = 0;
    #80 coin = 1; #40 coin = 0;
    #80 $finish;
end 

always
begin
    #20 clock = ~clock;
end
endmodule 
