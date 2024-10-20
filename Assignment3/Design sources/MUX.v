
`timescale 1ns / 1ps
module MUX(
input [31:0] inp0,
input [31:0] inp1,
input select,
output [31:0] out
    );
assign out=select?inp0:inp1;
endmodule
