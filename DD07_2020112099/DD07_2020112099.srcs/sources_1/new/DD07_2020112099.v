`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/16 11:23:21
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

module func(hwy, cntry, X, clock, clear, y2rdelay, r2gdelay);

output [1:0] hwy, cntry; //highway, country
reg[1:0] hwy, cntry;

input X, clock, clear;
input [2:0] y2rdelay, r2gdelay; //yellow to red, red to green

parameter RED = 2'd0, YELLOW = 2'd1, GREEN = 2'd2;

parameter s0 = 3'd0, // green , red
           s1 = 3'd1, // yellow , red
           s2 = 3'd2, // red, red
           s3 = 3'd3, // red, green
           s4 = 3'd4; // red, yellow

reg [2:0] state;
reg [2:0] next_state;
reg [2:0] y2rcounter, r2gcounter;

initial
begin
    y2rcounter = 0;
    r2gcounter = 0;
end

always @ (posedge clock)
    if (clear)
        state <= s0;
    else
        state <= next_state;
      

always @ (state)
begin
    hwy = GREEN;
    cntry = RED;
    case(state)
        s0: ;
        s1: hwy = YELLOW;
        s2: hwy = RED;
        s3: begin
                hwy = RED;
                cntry = GREEN;
            end
        4: begin
                hwy = RED;
                cntry = YELLOW;
            end
    endcase
 end
 

 always @(state or X)
 begin
    case(state)
        s0: if(X)
                next_state = s1;
            else
                next_state = s0;
        s1: begin
                for(y2rcounter = 0; y2rcounter < y2rdelay; )
                    #10 y2rcounter = y2rcounter + 1;
                y2rcounter = 0;
                next_state = s2;
            end
        s2: begin
                for(r2gcounter = 0; r2gcounter < r2gdelay; )
                    #10 r2gcounter = r2gcounter + 1;
                r2gcounter = 0;
                next_state = s3;
            end
        s3: if(X)
                next_state = s3;
            else
                next_state = s4;
        s4: begin 
                for(y2rcounter = 0; y2rcounter < y2rdelay; )
                    #10 y2rcounter = y2rcounter + 1;
                y2rcounter = 0; 
                next_state = s0;
            end
        default: next_state = s0;
    endcase
end
endmodule
