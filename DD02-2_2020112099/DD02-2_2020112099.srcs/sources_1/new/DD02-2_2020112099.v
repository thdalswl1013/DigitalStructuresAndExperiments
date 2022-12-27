`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/05 20:08:09
// Design Name: 
// Module Name: MyComparatorGate
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

module comparator(x,y1,y2,a,b);

output x,y1,y2;
input a,b;
wire n_a,n_b;

not (n_a,a);
not (n_b,b);
and(y1,n_a,b);
and(y2,n_b,a);
nor(x,y1,y2);

endmodule


module MyComparatorGate(A_lt_B,A_gt_B,A_eq_B,A,B);

output A_lt_B,A_gt_B,A_eq_B;
input [3:0] A,B;

wire x0,x1,x2,x3;
wire y0_1,y0_2,y1_1,y1_2,y2_1,y2_2,y3_1,y3_2;
wire [6:0] a;

comparator cmp0(x0,y0_1,y0_2,A[0],B[0]);
comparator cmp1(x1,y1_1,y1_2,A[1],B[1]);
comparator cmp2(x2,y2_1,y2_2,A[2],B[2]);
comparator cmp3(x3,y3_1,y3_2,A[3],B[3]);

and a0(a[0],x3,y2_1);
and a1(a[1],x3,y2_2);
and a2(a[2],x3,x2,y1_1);
and a3(a[3],x3,x2,y1_2);
and a4(a[4],x3,x2,x1,y0_1);
and a5(a[5],x3,x2,x1,y0_2);
and a6(A_eq_B,x3,x2,x1,x0);

or (A_lt_B,y3_1,a[0],a[2],a[4]);
or (A_gt_B,y3_2,a[1],a[3],a[5]);

endmodule


module main;

reg [3:0] a,b;
wire a_lt_b,a_gt_b,a_eq_b;

MyComparatorGate MCP(.A(a),.B(b),.A_lt_B(a_lt_b),.A_gt_B(a_gt_b),.A_eq_B(a_eq_b));

initial
begin
   $monitor($time," A = %h, B = %h, A_lt_B = %b, A_gt_B = %b, A_eq_B = %b",a, b, a_lt_b, a_gt_b, a_eq_b);
end


initial
begin
   a = 4'h0;  b=4'h1;
   
   #10 a=4'hf; b = 4'h3;
   #10 a = 4'ha; b = 4'hb;  
   #10 a = 4'h0; b = 4'h0;
   #10 a = 4'h7; b = 4'hd;
   #10 a = 4'h9; b = 4'h9;
   
end
endmodule
