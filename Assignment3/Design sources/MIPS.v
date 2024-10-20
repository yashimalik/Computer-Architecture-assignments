`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 12:51:32
// Design Name: 
// Module Name: MIPS
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

`include "Instruction_Memory.v"
`include "ALU.v"
`include "Instruction_Fetch.v"
`include "MainControl.v"
`include "MUX.v"
`include "Register_File.v"
`include "SignExt1.v"
`include "SignExt2.v"


module MIPS(
input clk, 
input reset
    );
    
 wire [31:0] instruction;
 wire [31:0] writedataMux;
 wire [31:0] read1out;
 wire [31:0] read2out;
 wire regwritectrl;
 wire ALUsrcctrl;
 wire ALUtoRegctrl;
 wire [31:0]signext1out;
 wire [31:0]signext2out;
 wire [31:0]muxout1;
 wire [31:0]ALUresult;
 wire zeroflag;
 
 Instruction_Fetch IF(clk,reset,instruction);
 Register_File RF( instruction[20:16], instruction[15:11] ,instruction[25:21],writedataMux, read1out, read2out, regwritectrl, clk, reset);
 MainControl MC(instruction, clk, regwritectrl, ALUsrcctrl, ALUtoRegctrl);
 SignExt1 SE1(instruction[20:0], signext1out);
 SignExt2 SE2(instruction[10:6], signext2out);
 MUX mux1(read2out, signext2out, ALUsrcctrl, muxout1);
 ALU Alu(read1out, muxout1, instruction[5:0], instruction[10:6], ALUresult, zeroflag);
 MUX mux2(ALUresult, signext1out, ALUtoRegctrl, writedataMux);
 
 

    
    
endmodule

