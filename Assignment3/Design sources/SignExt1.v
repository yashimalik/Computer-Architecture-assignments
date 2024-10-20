`timescale 1ns / 1ps
module SignExt1(
input [20:0] a, // 21-bit input
output [31:0] result // 32-bit output
    );

assign result = {{11{a[20]}},a};// MSB repeated 11 times
endmodule

