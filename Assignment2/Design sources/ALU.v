
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2024 01:18:54
// Design Name: 
// Module Name: ALU
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
`timescale 1ns / 1ps
module ALU(
input [31:0] A,[31:0] B,[3:0] Ctrl,
output reg [31:0] AluResult,
output reg zeroflag);

always@(A,B,Ctrl)

begin
//zeroflag=AluResult==0 ? 1:0;
    case(Ctrl)
    4'b0000 : AluResult=A&B;
    4'b0001 : AluResult=A|B;
    4'b0010 : AluResult=A+B;
    4'b0100 : AluResult=A-B;                
    4'b1000 : if(A<B)
              AluResult=1;
              else
              AluResult=0;
    default : zeroflag = 0;
    endcase
  
    if(AluResult==0)
    zeroflag = 1;
    else zeroflag = 0;
end



endmodule