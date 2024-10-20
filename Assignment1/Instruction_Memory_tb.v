`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 12:08:15
// Design Name: 
// Module Name: Instruction_Memory_tb
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

module Instruction_Memory_tb( );
    reg [31:0] PC;
    reg reset;
    wire [31:0] Instruction_Code;
    
    Instruction_Memory inst1 (PC,reset,Instruction_Code);
    initial
    begin
    reset=0;
    PC=0;
    //read instruction 
    #20 PC=4;
    #20 PC=8;
    #20 PC=12;
    #20 reset =1;PC=4;
    #20 PC=8;
    #20 PC =12;
    #20 $finish;
    end
endmodule
