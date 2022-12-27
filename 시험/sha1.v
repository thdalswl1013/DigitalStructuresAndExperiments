`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module sha1(DONE, SHA1OUT, CLK, nRST, START, SHA1IN );

input CLK, nRST;
input START;//sha-1 start signal                      ->
input [511:0] SHA1IN;//512bit input message

output DONE;//sha-1 complete signal                  -> newspaper(open)
output [159:0] SHA1OUT;//160bit sha-1 output  

//a,b,c,d,e
wire [31:0] next_state;
reg [31:0] pre_state;

//state
parameter a=32'h67452301;
parameter b=32'hEFCDAB89;
parameter c=32'h98BADCFE;
parameter d=32'h10325476;
parameter e=32'hC3D2E1F0;

assign{SHA1OUT, next_state}=decode(START,a,b,c,d,e);

//////////////////////////////////////////////////////////////////////decode(=main)
function decode;
input [6:0] t;
input [31:0] a,b,c,d,e;

reg [31:0] temp;
reg [31:0] prestate;

begin
    for(t=0;t<80;t=t+1)
        begin
            temp= e + F(t,b,c,d) + circular_leftshift(a,5) + w(t) + k(t);
            case(prestate)
            e:
                e=d;
            d:
                d=c;
            c:
                c=circular_leftshift(b,30);
            b:
                b=a;
            a:
                a=temp;
            endcase
        end
    end 
endfunction



//////////////////////////////////////////////circular_leftshift(<<<)
function [31:0] cirular_leftshift;
input [31:0] temp;
input [4:0] num;

begin
    cirular_leftshift= (temp<<num) | (temp>>(32-num));
end
endfunction
//////////////////////////////////////////////K(t)
function [31:0] k;
input [6:0] t;
begin
	if (t >= 0 && t < 20)
        k=32'h5A827999;
	else if (t >= 20 && t < 40)
        k=32'h6ED9EBA1;
	else if (t >= 40 && t < 60)
        k=32'h8F1BBCDC;
	else if (t >= 60 && t < 80)
        k=32'hCA62C1D6;
end
endfunction       
//////////////////////////////////////////////F(t)
function [31:0] F;
input[6:0] t;//
input [31:0] b,c,d;

begin
	if (t >= 0 && t < 20)
		F = (b & c) | ((~b) & d);
	else if (t >= 20 && t < 40)
		F = (b ^ c ^ d);
	else if (t >= 40 && t < 60)
		F = ((b & c) | (b & d) | (c & d));
	else if (t >= 60 && t < 80)
		F = (b ^ c ^ d);
end
endfunction       

/////////////////////////////////////////////////////////
endmodule
