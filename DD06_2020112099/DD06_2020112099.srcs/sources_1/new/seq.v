`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//project name: DD06_2020112099
//////////////////////////////////////////////////////////////////////////////////

module seq(CLK, nRST, X, Y);

    input CLK, nRST, X;
    output Y;
    
    reg A, B;
    reg Y;
    
    parameter s0 = 2'd0;
    parameter s1 = 2'd1;
    parameter s2 = 2'd2;
    parameter s3 = 2'd3;
    
    reg[1:0] state;
    reg[1:0] nstate;
    
    always@(state)
    begin
        A=0;
        B=0;
        
        case(state)
            s0: begin A=0;B=0; end
            s1: begin A=0;B=1; end
            s2: begin A=1;B=0; end
            s3: begin A=1;B=1; end
        endcase
    end   
    
    always@(state or X)
    begin
    
        case(state)
            s0: if(X)
                 begin nstate = s1; Y=0; end
                else
                  begin nstate = s0; Y=0; end
                  
            s1:  if(X)
                  begin nstate = s2; Y=0; end
                 else
                  begin nstate = s0; Y=0; end
                  
            s2: if(X)
                  begin nstate= s3; Y=0; end
                else
                   begin nstate = s0; Y=0;end
                   
             s3: if(X)
                    begin nstate = s3; Y=1;end
                 else
                    begin nstate = s0; Y=1; end
                    
         endcase
     end    

    always@(negedge nRST,posedge CLK)
    begin
    if(nRST==0)
        state<=s0;
    else 
        state<= nstate;
    end   
    
endmodule
