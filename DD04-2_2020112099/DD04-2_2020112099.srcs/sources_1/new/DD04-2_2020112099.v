module BCDtoDecimalBeh (DECOut, BCDIn, CLK, nRST);

output reg [9:0] DECOut;
input [3:0] BCDIn;
input CLK, nRST;

always @(posedge CLK or negedge nRST)

begin
    if(nRST == 0)
        DECOut = 10'b0000000000;
    else
    begin
        case(BCDIn)
        
            4'b0000 : DECOut = 10'b0000000001;
            4'b0001 : DECOut = 10'b0000000010;
            4'b0010 : DECOut = 10'b0000000100;
            4'b0011 : DECOut = 10'b0000001000;
            4'b0100 : DECOut = 10'b0000010000;
            4'b0101 : DECOut = 10'b0000100000;
            4'b0110 : DECOut = 10'b0001000000;
            4'b0111 : DECOut = 10'b0010000000;
            4'b1000 : DECOut = 10'b0100000000;
            4'b1001 : DECOut = 10'b1000000000;
            default : DECOut = 10'b0000000000;
            
        endcase
    end
end
endmodule

module Top;

wire [9:0] decout;
reg [3:0] bcdin;
reg clk, nrst;

BCDtoDecimalBeh m1 (.DECOut(decout), .BCDIn(bcdin), .CLK(clk), .nRST(nrst));

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
    
    #10 $finish;
end
endmodule