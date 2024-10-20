module Register_file_block
(
    input        clk,
    input        reset,
    input  [4:0] Read_reg_number_1,
    input  [4:0] Read_reg_number_2,
    input  [4:0] Write_reg_number,
    input  [31:0]Write_Data,
    input        reg_write,
    output [31:0]Read_Data_1,
    output [31:0]Read_Data_2

);
// defining the Entire Register file of 32 registers of 32 bits each
reg [31:0]Register_file[31:0];  

// initializing the register file with data
/*
always @(negedge reset) begin
 if(reset==0)
begin
$readmemh("init_Register_file.mif",Register_file);  
end   
end
*/
always @(negedge reset) begin
if(reset==0)
begin
Register_file[0]<='h00;
Register_file[1]<='h02;
Register_file[2]<='h00;
Register_file[3]<='h00;
Register_file[4]<='h0a;
Register_file[5]<='h00;
Register_file[6]<='h02;
Register_file[7]<='h00;
Register_file[8]<='h02;
Register_file[9]<='h00;
Register_file[10]<='h00;
Register_file[11]<='h00;
Register_file[12]<='h14;
Register_file[13]<='h00;
Register_file[14]<='h00;
Register_file[15]<='h00;
Register_file[16]<='h00;
Register_file[17]<='h00;
Register_file[18]<='h00;
Register_file[19]<='h00;
Register_file[20]<='h00;
Register_file[21]<='h00;
Register_file[22]<='h00;
Register_file[23]<='h00;
Register_file[24]<='h00;
Register_file[25]<='h00;
Register_file[26]<='h00;
Register_file[27]<='h00;
Register_file[28]<='h00;
Register_file[29]<='h00;
Register_file[30]<='h00;
Register_file[31]<='h00;
end
end
//Read Logic (can be done asynchronously) 
assign Read_Data_1 = Register_file[Read_reg_number_1];
assign Read_Data_2 = Register_file[Read_reg_number_2];

//Write Logic (should be synchronous)
always @(negedge clk) begin     //writes on negative edge
    if(reg_write)
    begin
        if(Write_reg_number==0)
        Register_file[Write_reg_number]=0;
        else
        Register_file[Write_reg_number]=Write_Data;
    end
    
end

endmodule 
