module ID_EX_reg_block
(
    input       clk,
    input       reset,
    input       stall_flush,
    input   [5:0]Instruction_Code_ID_Opcode,//6        
    input       data_read_ID,//1
    input  Set_Less_than_inst_ID, //1
    //WB sel line
    input       reg_write_ID, //1
    //EX sel lines
    input       Write_regnum_Src_sel_line_ID, //1
    input       ALU_Src_sel_line_ID,//1
    input  [3:0]ALU_ctrl_ID,     //4
    //MEM sel lines
    input       data_write_ID,   //1
    //WB sel line
    input        write_Data_Src_mux_ID, //1

    input  [31:0]Read_Data_1_ID,  // 32
    input  [31:0]Read_Data_2_ID,  // 32 
    input  [31:0]op_Sign_ext_offset_ID,  // 32
    input  [4:0]Rs_ID, // 5
    input  [4:0]Rt_ID, // 5
    input  [4:0]Rd_ID, // 5 
    input  [3:0]PC_jump_ID,  // 4
    
    output [5:0]Opcode_ex,
    output      data_read_EX,
    output       Set_Less_than_inst_EX ,
    //WB sel line    
    output      reg_write_EX,
    //EX sel lines
    output       Write_regnum_Src_sel_line_EX, 
    output       ALU_Src_sel_line_EX,
    output  [3:0]ALU_ctrl_EX,     
    //MEM sel lines
    output       data_write_EX,
    //WB sel line
    output        write_Data_Src_mux_EX,

    output  [31:0]Read_Data_1_EX,
    output  [31:0]Read_Data_2_EX,
    output  [31:0]op_Sign_ext_offset_EX,
    output  [4:0]Rs_EX,  
    output  [4:0]Rt_EX, 
    output  [4:0]Rd_EX,
    output  [3:0]PC_jump_EX);


reg [131:0]ID_EX_reg;

always @(negedge reset)
begin
    ID_EX_reg <= 0;
    end

always @(posedge clk) begin
    if((reset==0))
    ID_EX_reg <= 0;
    else    
    ID_EX_reg <={Instruction_Code_ID_Opcode,data_read_ID,Set_Less_than_inst_ID,reg_write_ID,Write_regnum_Src_sel_line_ID,ALU_Src_sel_line_ID,
    ALU_ctrl_ID,data_write_ID,write_Data_Src_mux_ID,
    Read_Data_1_ID,Read_Data_2_ID,op_Sign_ext_offset_ID,Rs_ID,Rt_ID,Rd_ID,PC_jump_ID};

    if((stall_flush))
    ID_EX_reg <= 0;
    else    
    ID_EX_reg <={Instruction_Code_ID_Opcode,data_read_ID,Set_Less_than_inst_ID,reg_write_ID,Write_regnum_Src_sel_line_ID,ALU_Src_sel_line_ID,
    ALU_ctrl_ID,data_write_ID,write_Data_Src_mux_ID,
    Read_Data_1_ID,Read_Data_2_ID,op_Sign_ext_offset_ID,Rs_ID,Rt_ID,Rd_ID,PC_jump_ID};

end
assign Opcode_ex = ID_EX_reg[131:126];
assign data_read_EX= ID_EX_reg[125];
assign Set_Less_than_inst_EX = ID_EX_reg[124];
    //WB sel line    
assign reg_write_EX=ID_EX_reg[123];
    //EX sel lines
assign Write_regnum_Src_sel_line_EX=ID_EX_reg[122]; 
assign ALU_Src_sel_line_EX=ID_EX_reg[121];
assign ALU_ctrl_EX=ID_EX_reg[120:117];     
    //MEM sel lines
assign data_write_EX=ID_EX_reg[116]; 
    //WB sel line
assign write_Data_Src_mux_EX=ID_EX_reg[115]; 
assign Read_Data_1_EX = ID_EX_reg[114:83];
assign Read_Data_2_EX = ID_EX_reg[82:51];    
assign op_Sign_ext_offset_EX = ID_EX_reg[50:19];
assign Rs_EX = ID_EX_reg[18:14];
assign Rt_EX = ID_EX_reg[13:9];
assign Rd_EX = ID_EX_reg[8:4];
assign PC_jump_EX = ID_EX_reg[3:0];

endmodule