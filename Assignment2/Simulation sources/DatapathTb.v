`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2024 01:21:23
// Design Name: 
// Module Name: DatapathTb
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
module DatapathTb;
reg [4:0] Read_Reg_Num_1;
reg [4:0] Read_Reg_Num_2;
reg [4:0] Write_Reg_Num;
reg RegWrite;
reg clk;
reg reset;
reg [3:0] Ctrl;
wire zeroflag;
Datapath_1 DUT(
	Read_Reg_Num_1,
	Read_Reg_Num_2,
	Write_Reg_Num,
	RegWrite,
	clk,
	reset,
	Ctrl,
	zeroflag);

initial clk = 0;
always #5 clk = ~clk;

initial 
begin

reset = 0;
RegWrite = 0;
#5;

reset = 1;
RegWrite = 1;

#15 Ctrl = 4'b0000; Read_Reg_Num_1 = 1; Read_Reg_Num_2 = 2; Write_Reg_Num = 3;

#15 Ctrl = 4'b0001; Read_Reg_Num_1 = 4; Read_Reg_Num_2 = 5; Write_Reg_Num = 6;

#15 Ctrl = 4'b0010; Read_Reg_Num_1 = 7; Read_Reg_Num_2 = 8; Write_Reg_Num = 9;

#15 Ctrl = 4'b0100; Read_Reg_Num_1 = 10; Read_Reg_Num_2 = 11; Write_Reg_Num = 12;

#15 Ctrl = 4'b1000; Read_Reg_Num_1 = 13; Read_Reg_Num_2 = 14; Write_Reg_Num = 15;

end

endmodule