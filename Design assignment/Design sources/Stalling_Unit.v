module Stalling_Unit
(
    input [5:0] Opcode_ex,
    input [4:0]Rt_EX,
    input [4:0]Rs_ID,
    input [4:0]Rt_ID,
    output reg stall_flush
);

always @(*) begin
    if((Opcode_ex==6'd35)&(Rt_EX==Rs_ID)) // if it is Load inst it will obviously write the data so no need to check that 
    begin
        stall_flush <= 1'b1;
    end
    else
    stall_flush <= 1'b0;

    if((Opcode_ex==6'd35)&((Rt_EX==Rt_ID))) // if it is Load inst it will obviously write the data so no need to check that 
    begin
        stall_flush <= 1'b1;
    end
    else
    stall_flush <= 1'b0;
end




endmodule