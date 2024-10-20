`timescale 1ns / 1ps
module RegFile(
	input reset,
	input [3:0] Read_Reg_Num,
	input [3:0] Write_Reg_Num,
	input [7:0] Write_Data,
	output [7:0] Read_Data
	);	
reg [7:0] RegMemory[15:0];

assign Read_Data = RegMemory[Read_Reg_Num];

always @(reset)
begin

	if (reset == 0)
	begin
		RegMemory[0] <= 0; RegMemory[1] <= 1; RegMemory[2] <= 2; RegMemory[3] <= 3; 
		RegMemory[4] <= 4; RegMemory[5] <= 5; RegMemory[6] <= 6; RegMemory[7] <= 7; 
		RegMemory[8] <= 8; RegMemory[9] <= 9; RegMemory[10] <= 10; RegMemory[11] <= 11; 
		RegMemory[12] <= 12; RegMemory[13] <= 13; RegMemory[14] <= 14; RegMemory[15] <= 15; 
	
	end
end
always @(*)
begin 

RegMemory[Write_Reg_Num] <= Write_Data;

end
endmodule