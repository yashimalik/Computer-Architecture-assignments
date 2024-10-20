`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 12:56:33
// Design Name: 
// Module Name: Instruction_Fetch
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
`include "Instruction_Memory.v"

module Instruction_Fetch(
    input clk,
    input reset,
    output [31:0] Instruction_Code

    );
    reg [31:0] PC;
    
    //Instantiate memory here
    Instruction_Memory inst(PC,reset,Instruction_Code);
    
    
    always@(posedge clk,negedge reset)
    //at posedge of the clk or when reset==0;
    begin
    //if reset =0 then initialse PC with 0
    if(reset==0)
    PC<=0;
    else
    begin
        PC<=PC+4;    
    end
    end
endmodule
