`timescale 1ns / 1ps

module Instruction_Fetch(
    input clk,
    input reset,
    output [7:0] Instruction_Code
    );
    
reg [7:0] PC;
 
Instruction_Memory InstrMem(PC, reset, Instruction_Code);

always @(posedge clk, negedge reset)

begin

if (reset == 0)
PC <= 0;

else
PC <= PC+1;
end
endmodule
