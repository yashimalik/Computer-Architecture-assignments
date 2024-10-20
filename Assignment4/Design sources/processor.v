module processor(
	input clk,
	input reset
	);	
wire [7:0] InstrCode;
wire [3:0] SourceReg;
wire [3:0] DestReg;
wire [3:0] Read_Reg_Num;
wire [3:0] Write_Reg_Num;
wire [7:0] Write_Data;
wire [7:0] Data;
wire [7:0] DataOut;
wire [3:0] DestRegOut;

assign Read_Reg_Num = SourceReg;
assign Write_Reg_Num = DestRegOut;
assign Write_Data = DataOut;

Instruction_Fetch InstrFetch(clk, reset, InstrCode);
IF_ID Reg1(clk, InstrCode, SourceReg, DestReg);
RegFile RegFile(reset, Read_Reg_Num, Write_Reg_Num, Write_Data, Data);
ID_WB Reg2(clk, Data, DestReg, DataOut, DestRegOut);

endmodule

