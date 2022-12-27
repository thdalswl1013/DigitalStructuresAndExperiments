module MyComparatorBeh (A_lt_B, A_gt_B, A_eq_B, A, B, CLK, nRST);

output reg A_lt_B, A_gt_B, A_eq_B;
input [3:0] A;
input [3:0] B;

input CLK, nRST;

always @(posedge CLK or negedge nRST)

begin
    if(nRST == 0)
    begin
        A_lt_B = 0;
        A_gt_B = 0;
        A_eq_B = 0;
    end
    else
    
    begin
        if(A > B)       begin
            A_lt_B = 0;
            A_gt_B = 1;
            A_eq_B = 0; end
            
        else if(A == B) begin
            A_lt_B = 0;
            A_gt_B = 0;
            A_eq_B = 1; end
            
        else            begin
            A_lt_B = 1;
            A_gt_B = 0;
            A_eq_B = 0;
        end
    end
end

endmodule

module Top;

wire a_lt_b, a_gt_b, a_eq_b;
reg [3:0] a;
reg [3:0] b;
reg clk, nrst;

MyComparatorBeh m1 (.A_lt_B(a_lt_b), .A_gt_B(a_gt_b), .A_eq_B(a_eq_b), .A(a), .B(b), .CLK(clk), .nRST(nrst));

initial 
begin
    clk = 0;
    nrst = 0;
    #10 nrst = 1;
end

always
    #5 clk = ~clk;
    
initial
begin
    $monitor($time, " A = %h, B = %h, A_lt_B = %b, A_gt_B = %b, A_eq_B = %b\n", a, b, a_lt_b, a_gt_b, a_eq_b);
 
    a = 4'h0; b = 4'h1;
    #10 a = 4'hf; b = 4'h3;
    #10 a = 4'ha; b = 4'hb;
    #10 a = 4'h0; b = 4'h0;
    #10 a = 4'h7; b = 4'hd;
    #10 a = 4'h9; b = 4'h9;
    #10 $finish;
end
endmodule