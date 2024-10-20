`timescale 1ns/1ps
module TB_Mips_Datapath();
reg clk;
reg reset;

MIPS_processor MIPS_processor_inst(clk,reset);


initial begin
    reset=1;
    #8 reset=0;
    #1 reset=1;

#8;

//defining clock

forever 
begin
    clk <= 1'b1; 
    #5; 

    clk <= 1'b0;
    #5; 
end

end

    
endmodule


