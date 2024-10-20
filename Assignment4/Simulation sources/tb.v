`timescale 1ns / 1ps
module tb();
    reg clk;
    reg reset;
    
processor inst(clk,reset);
    
    initial begin
    reset =0; #5; reset =1;
    end
    
    initial begin
    clk=0;
    repeat(15)
    #10 clk = ~clk; #10 $finish;
    end
   
endmodule
