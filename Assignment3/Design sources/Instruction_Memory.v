`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 12:52:43
// Design Name: 
// Module Name: Instruction_Memory
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
module Instruction_Memory(
input [31:0] PC, input reset,
output [31:0] Instruction_Code);

reg [7:0] Mem [36:0]; //byte addressable memory 37 locations

//For normal memory read we use the following statement
assign Instruction_Code = {Mem [PC], Mem[PC+1], Mem [PC+2], Mem [PC+3]};
//reads instruction code specified by PC
//BigEndian
//handling reset condition 
always@(reset)
begin
if(reset ==0) //if reset is equal to logic O I Initialize the memory with 4 instructions 
begin
Mem [0] = 8'h00; Mem [1] = 8'h01; Mem[2] = 8'h10; Mem[3] = 8'h20;
// Fist 32-bit location with data 00011039 hexadecimal 
//BigEndian style
Mem [4] = 8'h00; Mem[5] = 8'h85; Mem[6] = 8'h30; Mem[7] = 8'h22;
//1 Second 32-bit location with data 853022 hexadecimal

Mem [8] = 8'h01; Mem[9] = 8'h09; Mem[10] = 8'h50; Mem[11] = 8'h24;
//1095024
Mem [12] = 8'h01; Mem[13] = 8'h28; Mem[14] = 8'h50; Mem[15] = 8'h25;
//1285025

Mem [16] = 8'h01; Mem[17] = 8'h66; Mem[18] = 8'h01; Mem[19] = 8'h80;
//1660180
Mem [20] = 8'h01; Mem[21] = 8'hA9; Mem[22] = 8'h02; Mem[23] = 8'h82;
//1A90282


Mem [24] = 8'hFD; Mem[25] = 8'hA9; Mem[26] = 8'h02; Mem[27] = 8'h82;
//FDA90282
end
end
endmodule
