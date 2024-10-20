`timescale 1ns / 1ps
module MainControl(
input [31:0] instr,
input clk,
output reg RegWrite,
output reg ALUSrc,
output reg ALUtoReg
    );
always@(posedge clk && instr)
begin
    RegWrite=1;
    if(instr[31]==0 && instr[5]==0) //sll srl
    begin
         ALUSrc=0;
         ALUtoReg=1;
    end
    else if(instr[31]==0 && instr[5]==1) //add, sub, and, or
    begin
         ALUSrc=1;
         ALUtoReg=1;
    end
    else if(instr[31] == 1'b1) //Itype
    begin
         ALUtoReg = 0;
         ALUSrc=1'bX;
    end
end
endmodule
