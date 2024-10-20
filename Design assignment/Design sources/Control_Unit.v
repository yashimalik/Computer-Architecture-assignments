module Control_Unit (
    input [31:26] Instruction_Code_ID,
    
        //WB sel line
    output reg      reg_write_ID, //1
    //EX sel lines
    output  reg     Write_regnum_Src_sel_line_ID, //1
    output  reg     ALU_Src_sel_line_ID,//1
    output  reg  [3:0]ALU_ctrl_ID,     //4
    //MEM sel lines
    output  reg     data_write_ID,   //1
    //WB sel line
    output  reg      write_Data_Src_mux_ID, //1
    output  reg      PC_Src,
    output  reg flush,
    output  reg Set_Less_than_inst_ID,
    output  reg    data_read_ID);

always @(*) begin
    case (Instruction_Code_ID[31:26])
 //ori
 6'd14:begin  
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1;   //write in reg file when STL_WB is 1
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 1;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0010; 
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0;
   end 
    //lui
 6'd15:begin  
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1;   //write in reg file when STL_WB is 1
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 1;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0010; 
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0;
   end 
   //MUL
6'd26:begin
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1; //write in reg file
   Write_regnum_Src_sel_line_ID <= 1;   //write at Rd
   ALU_Src_sel_line_ID <= 0;
   ALU_ctrl_ID <= 4'b0011;
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
end
//Store    
6'd43:begin
   flush <= 0;
   PC_Src <=  0;    
   reg_write_ID <= 0;   //don't write in reg file
   Write_regnum_Src_sel_line_ID <= 1'bx;
   ALU_Src_sel_line_ID <= 1;   //ADDING with signextended immediate
   ALU_ctrl_ID <= 4'b0001;
   data_write_ID <= 1;
   write_Data_Src_mux_ID <= 1'bx; 
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
end

//Load   
6'd35:begin
   flush <= 0;    
   PC_Src <=  0; 
   reg_write_ID <= 1;   //write in reg file
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 1;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0001;  //ADDING with signextended immediate
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 1; // load from data mem 
   Set_Less_than_inst_ID <= 0;
   data_read_ID<=1;  
end

//jr  
6'd2:begin
   flush <= 1; 
   PC_Src <=  1;         // because we have to jump
   reg_write_ID <= 0;   //write in reg file
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 0;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0000;  //ADDING with signextended immediate
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0; // load from data mem 
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
 end
//nor 
6'd7:begin
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1; //write in reg file
   Write_regnum_Src_sel_line_ID <= 1;   //write at Rd
   ALU_Src_sel_line_ID <= 0;
   ALU_ctrl_ID <= 4'b0000;
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
end

//ADDition
6'd12:begin
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1; //write in reg file
   Write_regnum_Src_sel_line_ID <= 1;   //write at Rd
   ALU_Src_sel_line_ID <= 0;
   ALU_ctrl_ID <= 4'b0001;
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
end




//STLI    
6'd10:begin  
   flush <= 0;    
   PC_Src <=  0;    
   reg_write_ID <= 1;   //write in reg file when STL_WB is 1
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 1;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0010; 
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0;
   Set_Less_than_inst_ID <= 1; 
   data_read_ID<=0;  
end



default:begin
      flush <= 0; 
   PC_Src <=  0;         // because we have to jump
   reg_write_ID <= 0;   //write in reg file
   Write_regnum_Src_sel_line_ID <= 0;   //write at Rt
   ALU_Src_sel_line_ID <= 0;   //Comparing with signextended immediate
   ALU_ctrl_ID <= 4'b0000;  //ADDING with signextended immediate
   data_write_ID <= 0;
   write_Data_Src_mux_ID <= 0; // load from data mem 
   Set_Less_than_inst_ID <= 0; 
   data_read_ID<=0; 
end


endcase

end


    
endmodule
