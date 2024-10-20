`timescale 1ns / 1ps

module IF_ID(
	input clk,
	input [7:0] InstrCode,
	output reg [3:0] SourceReg,
	output reg [3:0] DestReg
	);

always @(posedge clk)
begin

SourceReg <= InstrCode[3:0];
DestReg <= InstrCode[7:4];

end

endmodule
