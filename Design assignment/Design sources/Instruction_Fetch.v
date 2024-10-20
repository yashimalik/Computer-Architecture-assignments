module Instruction_Fetch
(
    input            clk,
    input            reset,
    input           stall_flush,
    input   [31:0] PC_jump,
    input            PC_Src,
    output  [31:0]Instruction_Code,
    output  reg [31:0]PC_IF
);

reg  [31:0] PC;
Instruction_memory Instruction_memory_inst (PC[9:0],reset,Instruction_Code);
always @(posedge clk or negedge reset)
begin
    if(!stall_flush)
    begin
    if(reset==0)
    PC <= 0;
    else
    begin
    if(PC_Src==1)
    PC<=PC_jump;
    else
     PC <= PC+4;   
    end 
    end

    else
    if(reset==0)
    PC <= 0;
end

always @(*) begin
PC_IF <= PC;
end


endmodule
