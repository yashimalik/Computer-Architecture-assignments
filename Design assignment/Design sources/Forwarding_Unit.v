module Forwarding_Unit (
    input [4:0]Rs_EX,
    input [4:0]Rt_EX,
    input [4:0]Reg_write_num_MEM,
    input [4:0]Reg_write_num_WB,
    input      reg_write_MEM,
    input      reg_write_WB,
    output reg [1:0]Forward_Rs,  
    output reg [1:0]Forward_Rt
);
//Execution and Mem Hazard for Rs
always @(*)
begin
    if((reg_write_MEM==1)&(Reg_write_num_MEM!=0)&(Reg_write_num_MEM==Rs_EX))    //Froward from EX-Mem_reg
    Forward_Rs <= 2'b01;
    else
    begin
        if((reg_write_WB==1)&(Reg_write_num_WB!=0)&(Reg_write_num_WB==Rs_EX))  //Froward from Mem-WB_reg
        Forward_Rs <= 2'b10;
        else
        Forward_Rs <= 2'b00; // No forwading needed
    end 

end
//Execution and Mem Hazard for Rt
always @(*)
begin
    if((reg_write_MEM==1)&(Reg_write_num_MEM!=0)&(Reg_write_num_MEM==Rt_EX))    //Froward from EX-Mem_reg
    Forward_Rt <= 2'b01;
    else
    begin
        if((reg_write_WB==1)&(Reg_write_num_WB!=0)&(Reg_write_num_WB==Rt_EX))  //Froward from Mem-WB_reg
        Forward_Rt <= 2'b10;
        else
        Forward_Rt <= 2'b00; // No forwading needed
    end 
end
endmodule
