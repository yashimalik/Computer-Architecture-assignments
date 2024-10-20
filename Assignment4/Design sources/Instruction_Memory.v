`timescale 1ns / 1ps

module Instruction_Memory(
    input [7:0] PC,
    input reset,
    output [7:0] Instruction_Code
    );
    
    reg [7:0] Mem [10:0];
    
assign Instruction_Code = Mem[PC];

always @(reset)
begin

if (reset == 0)
begin
/*
Mem[0] = 8'b01011010;	// Mov R5, R10
Mem[1] = 8'b01100101;	// Mov R6, R5
*/
// 8 bit instructions
Mem[0] = 8'b01011010;	// Mov R5, R10
Mem[1] = 8'b10100110;	// Mov R10, R6
Mem[2] = 8'b01100101;	// Mov R6, R5 

end

end
    
endmodule
