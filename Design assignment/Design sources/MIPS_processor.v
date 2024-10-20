module MIPS_processor 
(
    input clk,
    input reset
);

// IF Unit
//wires_op_IF
wire PC_Src;///will come from control unit->Instruction Fetch unit present in decode stage directly
wire [31:0] PC_jump_ID; ///will IF -> IF/ID reg -> ID -> ID/Ex reg -> Ex -> Instruction Fetch unit

wire [3:0] PC_MSB_ID;
wire [3:0] PC_MSB_IF;
wire [3:0] PC_MSB_EX;

wire [31:0] Instruction_Code_IF ;
wire [31:0]PC_IF ;

wire stall_flush; // comes as  an output of the stalling unit



Instruction_Fetch Instruction_Fetch_inst (clk,reset,stall_flush,PC_jump_ID,PC_Src,Instruction_Code_IF,PC_IF);

assign PC_MSB_IF = PC_IF[31:28];


//**********************************************************

//IF/ID reg (Stores Instruction_code, PC(MSB-4 bits))


wire [31:0] Instruction_Code_ID ;
wire [4:0]Rd_ID;
wire [4:0]Rs_ID;
wire [4:0]Rt_ID;

wire [15:0]ip_Sign_ext_offset_ID_15;

// Flushing unit ip wire
wire flush; // we'll have to flush the IF/ID_reg to pass a Nop in system insteading of passing the instruction currently that will come in IF-ID_reg as PC has Stored PC+4 in the PC reg

IF_ID_reg_block IF_ID_reg_block_inst(clk,reset,stall_flush,flush,Instruction_Code_IF,PC_MSB_IF,PC_MSB_ID,Rd_ID,Rs_ID,Rt_ID,ip_Sign_ext_offset_ID_15,Instruction_Code_ID);

//lui
wire [31:0] final_write_value_for_lui_ID;
reg [31:0] final_write_value_for_lui_EX, final_write_value_for_lui_MEM, final_write_value_for_lui_WB ;
reg [5:0] lui_opcode_EX, lui_opcode_MEM, lui_opcode_WB;

assign final_write_value_for_lui_ID={Instruction_Code_ID [15:0], 16'b0};
always @(posedge clk) begin
final_write_value_for_lui_EX<=final_write_value_for_lui_ID;
final_write_value_for_lui_MEM<=final_write_value_for_lui_EX;
final_write_value_for_lui_WB<=final_write_value_for_lui_MEM;
lui_opcode_EX<=Instruction_Code_ID [31:26];
lui_opcode_MEM<=lui_opcode_EX;
lui_opcode_WB<=lui_opcode_MEM;
end
//**********************************************************

// ID Unit

//Select-lines All##################################################

//sel_lines_IF.............................................................
//PC_Src not going further but comes from control unit

//sel_lines_ID............................................................
//reg_write.
wire reg_write_ID;          //Comes directly form CU
wire reg_write_EX;
wire reg_write_MEM;
wire reg_write_WB;          //USED

//sel_lines_EX..............................................................
//Write_regnum_Src_sel_line
wire Write_regnum_Src_sel_line_ID;  //Comes directly form CU
wire Write_regnum_Src_sel_line_EX;    //USED

//ALU_Src_sel_line_EX
wire ALU_Src_sel_line_ID;   //Comes directly form CU
wire ALU_Src_sel_line_EX;   //USED

//ALU_ctrl_EX
wire [3:0]ALU_ctrl_ID;  //Comes directly form CU
wire [3:0]ALU_ctrl_EX;  //USED


//sel_lines_MEM................................................................
//data_write_MEM
wire data_write_ID; //Comes directly form CU
wire data_write_EX;
wire data_write_MEM;    //USED

//sel_lines_WB................................................................
wire write_Data_Src_mux_ID; //Comes directly form CU
wire write_Data_Src_mux_EX;
wire write_Data_Src_mux_MEM;
wire write_Data_Src_mux_WB;  //USED

//############################################################################
//Wires ip/op ID
wire [25:0]ip_Sign_ext_offset_ID_25; 
wire [27:0]op_Sign_ext_offset_ID_25; 
//Wires op ID
wire [31:0]Write_Data_WB;

wire [31:0]op_Sign_ext_offset_ID_15;
wire [31:0]Read_Data_1_ID;
wire [31:0]Read_Data_2_ID;

assign ip_Sign_ext_offset_ID_25 ={Rs_ID,Rt_ID,ip_Sign_ext_offset_ID_15[15:0]};
//  sign extention blk 15->31
Sign_ext_blk_15 Sign_ext_blk_15 (ip_Sign_ext_offset_ID_15,op_Sign_ext_offset_ID_15);
// Register file instantiation
wire[4:0] Reg_write_num_WB;
wire [31:0]Final_Write_Data; //Coming form Set_less_than_Writing_mitigation_mux.
Register_file_block Register_file_inst(clk,reset,Rs_ID,Rt_ID,Reg_write_num_WB,
                                        Final_Write_Data,reg_write_WB,Read_Data_1_ID,Read_Data_2_ID);
 //jr
wire [31:0] PC_jump_ID_Im, PC_jump_ID_reg;
wire PC_jump_ID_select;
assign PC_jump_ID_select=(Instruction_Code_ID[31:26]==6'b000010)?1:0;
assign PC_jump_ID_reg=Read_Data_1_ID;

//...instantiating Sign_ext_blk_25
Sign_ext_blk_25 Sign_ext_blk_25_inst (ip_Sign_ext_offset_ID_25,op_Sign_ext_offset_ID_25);
assign PC_jump_ID_Im ={PC_MSB_ID,op_Sign_ext_offset_ID_25};// appending to get PC if Jump present
//for choosing what to write if set less than instruction is there in WB
mux2_1 #(32) PC_jump_mux(PC_jump_ID_Im, PC_jump_ID_reg, PC_jump_ID_select, PC_jump_ID);
 wire Set_Less_than_inst_ID;
 wire Set_Less_than_inst_EX;
 wire Set_Less_than_inst_MEM;
 wire Set_Less_than_inst_WB;

wire  data_read_ID;
wire  data_read_EX;
wire  data_read_MEM;

// Control_Unit instantiation
Control_Unit Control_Unit_inst(Instruction_Code_ID[31:26],reg_write_ID,Write_regnum_Src_sel_line_ID,
                                ALU_Src_sel_line_ID,ALU_ctrl_ID,data_write_ID,write_Data_Src_mux_ID,PC_Src,flush,Set_Less_than_inst_ID,data_read_ID);

//**********************************************************

//ID/EX reg (Stores Read_Data_1,Read_Data_2,op_Sign_ext_offset_ID,Rs_ID,Rt_ID,Rd_ID)
wire  [31:0]Read_Data_1_EX;
wire  [31:0]Read_Data_2_EX;
wire  [31:0]op_Sign_ext_offset_EX_15;
wire  [4:0]Rs_EX;  
wire  [4:0]Rt_EX; 
wire  [4:0]Rd_EX;


wire  [5:0]Opcode_ex; // used for checking the Stalling condition as if it were Load inst 
//present in the ID-EX_reg and there is a data dependency then we need to Stall the Pipeline for 
// One Cycle and also flush the IF-ID_reg of the pipeline to pass a nop  

//Stalling_Unit .........................................instantiation
Stalling_Unit Stalling_Unit_inst(Opcode_ex,Rt_EX,Rs_ID,Rt_ID,stall_flush);

ID_EX_reg_block ID_EX_reg_block (clk,reset,stall_flush,Instruction_Code_ID[31:26],data_read_ID,Set_Less_than_inst_ID,reg_write_ID,Write_regnum_Src_sel_line_ID,ALU_Src_sel_line_ID,
ALU_ctrl_ID,data_write_ID,write_Data_Src_mux_ID,
Read_Data_1_ID,Read_Data_2_ID,op_Sign_ext_offset_ID_15,Rs_ID,Rt_ID,Rd_ID,PC_MSB_ID,Opcode_ex,data_read_EX,Set_Less_than_inst_EX,
reg_write_EX,Write_regnum_Src_sel_line_EX,ALU_Src_sel_line_EX,ALU_ctrl_EX,data_write_EX,write_Data_Src_mux_EX,
Read_Data_1_EX,Read_Data_2_EX,op_Sign_ext_offset_EX_15,Rs_EX,Rt_EX,Rd_EX,PC_MSB_EX);

//**********************************************************

//EX unit

//wires_Ip_EX
wire [31:0]ALU_inp_1 ;       // comes from output of Forward_Rs_data_Mux
wire [31:0]ALU_inp_2 ;       // coes from output of ALU_Src_mux   

//wires_Op_EX
wire [31:0]ALU_result;
wire STL_EX;
wire [4:0]Reg_write_num_EX;

//assign ALU_inp_1=Read_Data_1_EX; not needed now

//wires_op from forwarding_unit
wire [1:0]Forward_Rs;
wire [1:0]Forward_Rt;
wire [31:0]forward_from_mem;
wire [31:0]ALU_result_MEM;

wire [31:0]ALU_Src_mux_Input_1; // comes from output of Forward_Rt_data_Mux
//....instantiating Forward_Rs_data_Mux for ALU_inp_1
mux3_1 #(32) Forward_Rs_data_Mux (Read_Data_1_EX,forward_from_mem,Final_Write_Data,Forward_Rs,ALU_inp_1);

//....instantiating Forward_Rt_data_Mux for ALU_inp_2
mux3_1 #(32) Forward_Rt_data_Mux (Read_Data_2_EX,forward_from_mem,Final_Write_Data,Forward_Rt,ALU_Src_mux_Input_1);

//...inastantiating ALU_Src_mux
mux2_1 #(32) ALU_Src_mux (ALU_Src_mux_Input_1,op_Sign_ext_offset_EX_15,ALU_Src_sel_line_EX,ALU_inp_2);
//ALU_Src_sel_line_EX=0 for R type, ALU_Src_sel_line_EX=1 for load-store same for ALU_ctrl

//...Instantiating Write_regnum_Src_mux
mux2_1 #(5) Write_regnum_Src_mux (Rt_EX,Rd_EX,Write_regnum_Src_sel_line_EX,Reg_write_num_EX);

//...Instantiating ALU_Assignment
ALU_Assignment ALU_Assignment(ALU_inp_1,ALU_inp_2,ALU_ctrl_EX,STL_EX,ALU_result);

//**********************************************************

//EX-MEM_reg

wire [31:0]Datamem_Read_Data_MEM ;
wire [7:0]Adderess_Datamem;
wire [31:0]Write_Data_Datamem;
wire [4:0]Reg_write_num_MEM;
wire       STL_MEM;



EX_MEM_reg_block EX_MEM_reg_block_inst (clk,reset,data_read_EX,Set_Less_than_inst_EX,ALU_result,Read_Data_2_EX,Reg_write_num_EX,STL_EX,reg_write_EX,
data_write_EX,write_Data_Src_mux_EX,data_read_MEM,Set_Less_than_inst_MEM,ALU_result_MEM,Write_Data_Datamem,Reg_write_num_MEM,STL_MEM,reg_write_MEM,data_write_MEM,
write_Data_Src_mux_MEM);
//**********************************************************

//Forwarding Unit



Forwarding_Unit Forwarding_Unit_inst (Rs_EX,Rt_EX,Reg_write_num_MEM,Reg_write_num_WB,
                                      reg_write_MEM,reg_write_WB,Forward_Rs,Forward_Rt);


//MEM unit
//Wires_Ip_MEM
assign Adderess_Datamem= ALU_result_MEM [7:0] ;



mux2_1 #(32) forward_from_mem_inst (ALU_result_MEM,Datamem_Read_Data_MEM,data_read_MEM,forward_from_mem);

Data_memory Data_memory_inst (clk,reset,data_read_MEM,Adderess_Datamem,Adderess_Datamem,Write_Data_Datamem,data_write_MEM,Datamem_Read_Data_MEM);


//Wires_Op_MEM
wire[31:0] Write_regfile_Source_1;
wire[31:0] Write_regfile_Source_2;


//**********************************************************
 
//MEM_WB_reg
wire      STL_WB;

MEM_WB_reg_block MEM_WB_reg_block_inst(clk,reset,Set_Less_than_inst_MEM,reg_write_MEM,write_Data_Src_mux_MEM,ALU_result_MEM,Datamem_Read_Data_MEM,Reg_write_num_MEM,STL_MEM,Set_Less_than_inst_WB,
                                        Write_regfile_Source_1,Write_regfile_Source_2,Reg_write_num_WB,STL_WB,reg_write_WB,write_Data_Src_mux_WB);

//**********************************************************
 
//WB unit
//Wires_Ip_WB
//Wires_Op_WB

mux2_1 #(32) Write_Data_Src_mux (Write_regfile_Source_1,Write_regfile_Source_2,write_Data_Src_mux_WB,Write_Data_WB);


//Set less than mitigation code
// As if Set_Less_Than_inst_Wb=0 it should write Write_Data_WB regaerdless of the value of STL_WB
wire [31:0] Final_Write_Data_dummy;
mux4_1 #(32) Set_less_than_Writing_mitigation_mux (Write_Data_WB,Write_Data_WB,32'd0,32'd1,{Set_Less_than_inst_WB,STL_WB},Final_Write_Data_dummy);

assign Final_Write_Data=(lui_opcode_WB==6'b001111)?final_write_value_for_lui_WB:Final_Write_Data_dummy;
endmodule


module mux2_1 #(parameter n=4)
(input [n-1:0]a, [n-1:0]b,
input  s0,
output [n-1:0]out);

assign out=s0? b: a;
endmodule


module mux3_1 #(parameter n=4)

(input  [n-1:0]a, b, c, 
input  [1:0]s,
output [n-1:0]out);

wire [n-1:0]a_out,b_out,c_out;
Gate_and_2s #(n) and3_1  (a,~s[0],~s[1],a_out);
Gate_and_2s #(n) and3_2  (b,s[0],~s[1],b_out);
Gate_and_2s #(n) and3_3  (c,~s[0],s[1],c_out);

assign out[n-1:0] =  a_out | b_out | c_out; 

endmodule

module mux4_1 #(parameter n=4)

(input  [n-1:0]a, b, c, d,
input  [1:0]s,
output [n-1:0]out);

assign out = s[1]? (s[0]?d:c) : (s[0]?b:a);

endmodule

module Gate_and_2s #(parameter n=4)
(
    input [n-1:0]a,
    input s0,s1,
    output [n-1:0]a_out
);

wire sel;
 
 assign sel=s1&s0;

genvar i;
generate
    for(i=0;i<n;i=i+1)
    begin
     assign   a_out[i]=a[i]&sel;
    end
endgenerate

endmodule
