module MEM_WB_reg_block
 (
    input         clk,
    input         reset,
    input         Set_Less_than_inst_MEM,
    //WB sel lines
    input         reg_write_MEM,
    input         write_Data_Src_mux_MEM,

    input [31:0]  ALU_result_MEM,//32
    input [31:0]  Datamem_Read_Data_MEM, //32
    input [4:0]  Reg_write_num_MEM,//5
    input         STL_MEM,//1
    output        Set_Less_than_inst_WB,
    output [31:0] Write_regfile_Source_1,
    output [31:0] Write_regfile_Source_2,
    output [4:0] Reg_write_num_WB,
    output       STL_WB,
        //WB sel lines
    output         reg_write_WB,
    output         write_Data_Src_mux_WB );

reg [72:0]MEM_WB_reg;
always @(posedge clk or negedge reset) begin
    if(reset==0)
    MEM_WB_reg <= 0;
    else    
    MEM_WB_reg <={Set_Less_than_inst_MEM,reg_write_MEM,write_Data_Src_mux_MEM,STL_MEM,
    Reg_write_num_MEM,Datamem_Read_Data_MEM,ALU_result_MEM};
end 
assign Set_Less_than_inst_WB = MEM_WB_reg[72];
assign reg_write_WB = MEM_WB_reg[71];
assign write_Data_Src_mux_WB = MEM_WB_reg[70];
assign STL_WB = MEM_WB_reg[69];
assign Reg_write_num_WB = MEM_WB_reg[68:64];
assign Write_regfile_Source_2 = MEM_WB_reg[63:32];  // used in load
assign Write_regfile_Source_1 = MEM_WB_reg[31:0];   // used in R type/stl


endmodule