module Datapath_1(
	input [4:0] Read_Reg_Num_1,
	input [4:0] Read_Reg_Num_2,
	input [4:0] Write_Reg_Num,
	input RegWrite,
	input clk,
	input reset,
	input [3:0] Ctrl,
	output zeroflag
	);
	
wire [31:0] A;
wire [31:0] B;
wire [31:0] AluResult;

Register_file RegFile(Read_Reg_Num_1, Read_Reg_Num_2, Write_Reg_Num, AluResult, A, B, RegWrite, clk, reset);
ALU ALU_1(A, B,Ctrl, AluResult, zeroflag);

endmodule