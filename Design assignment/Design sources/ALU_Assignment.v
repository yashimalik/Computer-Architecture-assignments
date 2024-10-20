module ALU_Assignment
(
    input  [31:0]A,
    input  [31:0]B,
    input  [3:0]ALU_ctrl,
    output reg STL,
    output reg [31:0]ALU_result
);
always @(*)
begin
case(ALU_ctrl)
4'b0000: ALU_result <= ~(A|B);   //bitwise nor operation 
4'b0001: ALU_result <= A+B;
4'b0010: ALU_result <= A; 
4'b0011: ALU_result <= A*B;
default: ALU_result <= 0;   
endcase
end

always @(*)
begin
    STL <= (A<B)?1:0;
end


endmodule