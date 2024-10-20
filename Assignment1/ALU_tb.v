`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 12:41:47
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb(
    );
    reg [31:0] a; 
    reg [31:0] b;
    reg [3:0] cntrl_line;
    wire [31:0] result;
    wire zeroflag;
    ALU uut (a,b,cntrl_line, result, zeroflag);
    initial #200 $finish; 
    initial
    begin
     
        a=12; b=10; cntrl_line= 4'b0000;
        #20 a=12; b=10; cntrl_line= 4'b0001;
        #20 a=23; b=42; cntrl_line= 4'b0010;
        #20 a=23; b=42; cntrl_line= 4'b0100;
        #20 a=23; b=42; cntrl_line= 4'b1000;
        #20 a=42; b=23; cntrl_line= 4'b1000;
        #20 a=23; b=23; cntrl_line= 4'b0100;
        #20 a=42; b=47; cntrl_line= 4'b0100;
        
    end

endmodule
