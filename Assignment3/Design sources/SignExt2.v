`timescale 1ns / 1ps
module SignExt2(
input [4:0] a, // 5-bit input
output [31:0] result // 32-bit output
    );

assign result = {{27{a[4]}},a};
endmodule
