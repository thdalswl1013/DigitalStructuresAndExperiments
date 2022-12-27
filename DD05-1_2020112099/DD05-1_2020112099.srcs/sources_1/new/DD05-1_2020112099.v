`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 11:06:41
// Design Name: 
// Module Name: BCDt0SevenSeg
// Project Name: DD05-1_2020112099
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

module Top;
    
reg[3:0] in;
wire a,b,c,d,e,f,g;

BCDtoSevenSeg btss(in,a,b,c,d,e,f,g);

  initial 
    begin
      $monitor($time,"BCDIn = %d --> a=%b,b=%b,c=%b,d=%b,e=%b,f=%b,g=%b",in,a,b,c,d,e,f,g);
      
      #0 in = 0;
      #10 in = 1;
      #10 in = 2;
      #10 in = 3;
      #10 in = 4;
      #10 in = 5;
      #10 in = 6;
      #10 in = 7;
      #10 in = 8;
      #10 in = 9;
      #10 in = 10;
      #10 in = 11;
      #10 in = 12;
      #10 in = 13;
      #10 in = 14;
      #10 in = 15;
      #10 in = 0;
      $finish ;
    end
endmodule

module BCDtoSevenSeg(BCDIn,a,b,c,d,e,f,g);

input[3:0] BCDIn;
output a,b,c,d,e,f,g;

reg a,b,c,d,e,f,g;

always@(*)
begin 

case(BCDIn)
    4'd0: begin a=1;b=1;c=1;d=1;e=1;f=1;g=0;end
    4'd1: begin a=0;b=1;c=1;d=0;e=0;f=0;g=0;end
    4'd2: begin a=1;b=1;c=0;d=1;e=1;f=0;g=0;end
    4'd3: begin a=1;b=1;c=1;d=1;e=0;f=0;g=1;end
    4'd4: begin a=0;b=1;c=1;d=0;e=0;f=1;g=1;end
    4'd5: begin a=1;b=0;c=1;d=1;e=0;f=1;g=1;end
    4'd6: begin a=1;b=0;c=1;d=1;e=1;f=1;g=1;end
    4'd7: begin a=1;b=1;c=1;d=0;e=0;f=0;g=0;end
    4'd8: begin a=1;b=1;c=1;d=1;e=1;f=1;g=1;end
    4'd9: begin a=1;b=1;c=1;d=1;e=0;f=1;g=1;end
    default: begin a=1;b=1;c=1;d=1;e=1;f=1;g=0;end
    
endcase
end

endmodule