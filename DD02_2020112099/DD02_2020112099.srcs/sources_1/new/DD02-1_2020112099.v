`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/05 11:28:15
// Design Name: 
// Module Name: D_latch
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


module D_latch(Q, Qbar, D, En);

output Q, Qbar;
input D, En;

wire a;
wire b;
wire c;

not (D, c);

nand(a, D, En);
nand(b, En, c);

nand(Q, a, Qbar);
nand(Qbar, Q, b);

endmodule


module Top;

wire q, qbar;
reg set, reset;

D_latch m1(.Q(q), .Qbar(qbar), .D(set), .En(reset));

initial
begin
    $monitor($time, " D=%b, En=%b, Q=%b, Qbar=%b\n", set, reset, q, qbar);
    set=0;
    reset=0;
    
    #5 set=1;
    #5 set=0;
    #2 reset=1;
    #3 set=1;
    #5 set=0;
    #5 set=1;
    #2 reset=0;
    #3 set=0;
end

endmodule
