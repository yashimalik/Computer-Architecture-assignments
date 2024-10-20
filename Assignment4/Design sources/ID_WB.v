`timescale 1ns / 1ps

module ID_WB(
	input clk,
	input [7:0] Data,
	input [3:0] DestReg,
	output reg [7:0] DataOut,
	output reg [3:0] DestRegOut
	);
	
always @(posedge clk)
begin

DataOut <= Data;
DestRegOut <= DestReg;

end

endmodule
