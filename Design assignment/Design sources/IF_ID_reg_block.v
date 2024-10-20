module IF_ID_reg_block
(
    input       clk,
    input       reset,
    input       stall_flush,
    input       flush,
    input  [31:0]Instruction_Code,
    input  [3:0]PC_IF,
    output [3:0] PC_jump_ID,
    output [4:0]Rd_ID,
    output [4:0]Rs_ID,
    output [4:0]Rt_ID,
    output [15:0]ip_Sign_ext_offset_ID_15,
    output  [31:0]Instruction_Code_ID
    
);


reg [35:0]IF_ID_reg;

always @(posedge clk or negedge reset) begin
    if (!stall_flush) begin
    if((reset==0)|(flush==1))
    IF_ID_reg <= 0;
    else
    begin
    IF_ID_reg <= {Instruction_Code,PC_IF}; //MSB 32=Instruction Code
         
    end
    end
    else
    begin
        if(reset==0)
        IF_ID_reg <= 0;
    end

   end    


assign  Instruction_Code_ID=IF_ID_reg[35:4];
assign Rs_ID = IF_ID_reg[29:25];    //5bits
assign Rt_ID = IF_ID_reg[24:20];    //5bits
assign Rd_ID = IF_ID_reg[19:15];    //5bits
assign PC_jump_ID = IF_ID_reg[3:0];//4bits
assign ip_Sign_ext_offset_ID_15 = IF_ID_reg[19:4];
endmodule