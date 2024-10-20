module Data_memory(
    input         clk,
    input         reset,
    input           data_read_MEM,
    input  [7:0] Data_Read_Adderess,
    input  [7:0] Data_Write_Adderess,
    input  [31:0] Data_Write_Data,
    input         Data_write,
    output reg [31:0] Data_Read_Data
);

reg [7:0]Data_Mem[255:0]; //ie. 40 regesters

//BIG Endian => LSB gets the highest address
always @(negedge clk) begin
    if(data_read_MEM)
    begin
          Data_Read_Data <= {Data_Mem[Data_Read_Adderess],Data_Mem[Data_Read_Adderess+1],Data_Mem[Data_Read_Adderess+2],
                        Data_Mem[Data_Read_Adderess+3]}; // 32 bits Instruction_Code at address pointed by PC assigned using Concetenation   
    end
    else
    Data_Read_Data <= 0;
end


// some instruction code must be present in the Mem so that we can get the out put so it must be initialized first
// initializing the register file with data
/*
always @(negedge reset) begin
if(reset==0)
begin
$readmemh("initDatamem.mif",Data_Mem);  
end   
end
*/
//initialization of data memory
always@( negedge reset)
 begin
     if(reset==0)
     begin
     Data_Mem[0] <= 8'b00000000; Data_Mem[1] <= 8'b00000000; Data_Mem[2] <= 8'hf1; Data_Mem[3] <= 8'hff; //first 32 bit location
     Data_Mem[4] <= 8'b00000001; Data_Mem[5] <= 8'b00000000; Data_Mem[6] <= 8'b00000000; Data_Mem[7] <= 8'b00000000; //second 32 bit location
     Data_Mem[8] <= 8'b00000001; Data_Mem[9] <= 8'b00001001; Data_Mem[10] <= 8'd96; Data_Mem[11] <= 8'b10100100; //third 32 bit location
     Data_Mem[12] <= 8'b00000000; Data_Mem[13] <= 8'b00000000; Data_Mem[14] <= 8'b00000000; Data_Mem[15] <= 8'b00000001; //fourth 32 bit location
     Data_Mem[16] <= 8'b00000001; Data_Mem[17] <= 8'b10101001; Data_Mem[18] <= 8'b00000010; Data_Mem[19] <= 8'b10000010; //fourth 32 bit location
     Data_Mem[20] <= 8'b00000001; Data_Mem[21] <= 8'b01100110; Data_Mem[22] <= 8'b00000001; Data_Mem[23] <= 8'b10000000; //fourth 32 bit location
     Data_Mem[24] <= 8'b00000001; Data_Mem[25] <= 8'b10101001; Data_Mem[26] <= 8'b00000010; Data_Mem[27] <= 8'b10000010; //fourth 32 bit location
     Data_Mem[28] <= 8'b00000001; Data_Mem[29] <= 8'b01100110; Data_Mem[30] <= 8'b00000001; Data_Mem[31] <= 8'b10000000; //fourth 32 bit location
     Data_Mem[32] <= 8'b00000001; Data_Mem[33] <= 8'b10101001; Data_Mem[34] <= 8'b00000010; Data_Mem[35] <= 8'b10000010; //fourth 32 bit location

     Data_Mem[36] = 8'b00000001; Data_Mem[37] = 8'b01100110; Data_Mem[38] = 8'b00000001; Data_Mem[39] = 8'b10000000; //fourth 32 bit location

     end
 end

//Write Logic (should be synchronous)
always @(posedge clk) begin     //writes on negative edge
    if(Data_write)
    begin
    Data_Mem[Data_Write_Adderess] <= Data_Write_Data[31:24];
    Data_Mem[Data_Write_Adderess+1] <= Data_Write_Data[23:16];
    Data_Mem[Data_Write_Adderess+2] <= Data_Write_Data[15:8];
    Data_Mem[Data_Write_Adderess+3] <= Data_Write_Data[7:0];
    end
end


endmodule
