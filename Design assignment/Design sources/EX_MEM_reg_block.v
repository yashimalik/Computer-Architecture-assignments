module EX_MEM_reg_block
 (
    input clk,
    input reset,
    input data_read_EX,//1
    input Set_Less_than_inst_EX,//1
   input [31:0]ALU_result,  //32
   input [31:0]Read_Data_2_EX,//32
   input [4:0]Reg_write_num_EX,//5
   input       STL_EX,//1
   //WB sel lines
   input        reg_write_EX,//1
   //Mem sel lines
   input        data_write_EX,//1
    //WB  sel  lines
    input       write_Data_Src_mux_EX,//1
    output      data_read_MEM,
    output      Set_Less_than_inst_MEM,
   output [31:0]Adderess_Datamem,
   output [31:0]Write_Data_Datamem,
   output [4:0]Reg_write_num_MEM,
   output       STL_MEM, 

    //WB sel lines
   output        reg_write_MEM,
   //Mem sel lines
   output        data_write_MEM,
    //WB  sel  lines
    output       write_Data_Src_mux_MEM  );

reg [74:0] EX_MEM_reg;

always @(posedge clk or negedge reset) begin
    if(reset==0)
    EX_MEM_reg <= 0;
    else    
    EX_MEM_reg <={data_read_EX,Set_Less_than_inst_EX,reg_write_EX,data_write_EX,write_Data_Src_mux_EX,
    STL_EX,Reg_write_num_EX,Read_Data_2_EX,ALU_result};
end
assign data_read_MEM= EX_MEM_reg[74]; 
assign Set_Less_than_inst_MEM= EX_MEM_reg[73];
assign reg_write_MEM = EX_MEM_reg[72];
assign data_write_MEM = EX_MEM_reg[71];
assign write_Data_Src_mux_MEM = EX_MEM_reg[70];

assign STL_MEM = EX_MEM_reg[69];
assign Reg_write_num_MEM = EX_MEM_reg[68:64];
assign Write_Data_Datamem = EX_MEM_reg[63:32];
assign Adderess_Datamem = EX_MEM_reg[31:0];

endmodule
