`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 12:55:35
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
input [31:0] A,[31:0] B,[5:0] Ctrl,[4:0]Shamt,
output reg [31:0] AluResult,
output reg zeroflag);

always@(A,B,Ctrl,Shamt)

begin
//zeroflag=AluResult==0 ? 1:0;
    case(Ctrl)
    6'b100000 : AluResult=A+B;
    6'b100010 : AluResult=A-B;
    6'b100100 : AluResult=A&B; 
    6'b100101 : AluResult=A|B;              
    6'b000000 : AluResult=A<<B;
    6'b000010 : AluResult=A>>B;
    default : zeroflag = 0;
    endcase
  
    if(AluResult==0)
    zeroflag = 1;
    else zeroflag = 0;
end
endmodule
