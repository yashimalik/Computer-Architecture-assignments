`timescale 1ns / 1ps

module Register_file(
	input [4:0] Read_Reg_Num_1,
	input [4:0] Read_Reg_Num_2,
	input [4:0] Write_Reg_Num,
	input [31:0] Write_Data,
	output [31:0] Read_Data_1,
	output [31:0] Read_Data_2,
	input RegWrite,
	input clk,
	input reset
	);
	
reg [31:0] RegMemory[31:0];

assign Read_Data_1 = RegMemory[Read_Reg_Num_1];
assign Read_Data_2 = RegMemory[Read_Reg_Num_2];

always @(reset)
begin 

	if (reset==0)
	begin
		RegMemory[0] <= 0; RegMemory[1] <= 1; RegMemory[2] <= 2; RegMemory[3] <= 3; RegMemory[4] <= 4; 
		RegMemory[5] <= 5; RegMemory[6] <= 6; RegMemory[7] <= 7; RegMemory[8] <= 8; RegMemory[9] <= 9; 
		RegMemory[10] <= 10; RegMemory[11] <= 11; RegMemory[12] <= 12; RegMemory[13] <= 13; RegMemory[14] <= 14; 
		RegMemory[15] <= 15; RegMemory[16] <= 16; RegMemory[17] <= 17; RegMemory[18] <= 18; RegMemory[19] <= 19; 
		RegMemory[20] <= 20; RegMemory[21] <= 21; RegMemory[22] <= 22; RegMemory[23] <= 23; RegMemory[24] <= 24; 
		RegMemory[25] <= 25; RegMemory[26] <= 26; RegMemory[27] <= 27; RegMemory[28] <= 28; RegMemory[29] <= 29; 
		RegMemory[30] <= 30; RegMemory[31] <= 31;
	end
end

always @(posedge clk)
begin

	if (RegWrite)
	begin 
		RegMemory[Write_Reg_Num] <= Write_Data;
	end
end

endmodule