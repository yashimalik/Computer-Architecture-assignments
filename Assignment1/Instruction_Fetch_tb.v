`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 12:11:17
// Design Name: 
// Module Name: Instruction_Fetch_tb
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
module Instruction_Fetch_tb(

    );
    
    reg clk,reset;
    wire [31:0] Instruction_Code;
    Instruction_Fetch uut (clk, reset, Instruction_Code);

    // Clock generation
    always #5 clk = ~clk;

    // Initial block to initialize reset and generate continuous clock
    initial begin
        
        clk = 0;
        reset = 0; // Set initial reset to 1
        #10; // Wait for 10 time units
        reset = 1; // Deassert reset to start normal operation

        // Simulate for 100 clock cycles
        #100 $finish; // Finish the simulation after 100 clock cycles
    end
    
    
endmodule
