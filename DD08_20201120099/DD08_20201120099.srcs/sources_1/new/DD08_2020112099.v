`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/23 12:09:35
// Design Name: 
// Module Name: func
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

module func(CLK, nRST, X_IN, Y_OUT);
input CLK,nRST,X_IN;
output Y_OUT;

parameter s0 = 2'd0;
parameter s1 = 2'd1;
parameter s2 = 2'd2;

reg[1:0] state;
reg[1:0] next_state;

reg[1:0] count;

assign Y_OUT =  (state == s1);

initial
begin
state = s0;
count = 0;
end

always @(posedge CLK)
if(nRST == 0)
   count <= 0;
else
    begin
        if(state == s1 && count < 3)
            count <= count+1;
        else if(state == s2 && count < 2)
            count <= count+1;
        else count <= 0;
    end
 
always @(*)
begin
    case(state)
        s0:if(X_IN == 1)
            next_state = s1;
           else
            next_state = s0;
        s1:if(count == 2)
            begin
                count = 0;
                next_state = s2;
            end
        s2: if(count == 1)
            begin
                count = 0;
                next_state = s0; 
            end
    endcase     
end

always @(posedge CLK)
if(nRST == 0)
    state <= s0;
else 
    state <= next_state;
endmodule
