`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 13:03:44
// Design Name: 
// Module Name: MIPS_tb
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

module MIPS_tb(

    );
reg clk; 
reg reset; 


 MIPS uut(clk,reset);
 initial #200 $finish; 
 always #5 clk = ~clk;
 
    initial
    begin
    clk=0;
    reset=0;
    #20 reset=1;   
    end
     
endmodule

