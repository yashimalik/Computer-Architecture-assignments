module Instruction_memory(
    input  [9:0] PC,
    input         reset,
    output [31:0] Instruction_Code
);

    reg [7:0]Inst_Mem[1023:0]; //ie. 36 reg of bit-width of 8 bits so a total of 9 Instruction codes of 32 bits each can be written

    //BIG Endian => LSB gets the highest address
    assign Instruction_Code = {Inst_Mem[PC],Inst_Mem[PC+1],Inst_Mem[PC+2],Inst_Mem[PC+3]}; // 32 bits Instruction_Code at address pointed by PC assigned using Concetenation 


    //some instruction code must be present in the Mem so that we can get the out put so it must be initialized first
    // initializing the register file with data
  /*  always @(negedge reset) begin
        if(reset==0)
        begin
            $readmemb("initData.mif",Inst_Mem);
        end
    end
*/
    
always @(negedge reset) begin
if(reset==0)
begin
Inst_Mem[0]<=8'b10001101;
Inst_Mem[1]<=8'b01100001;
Inst_Mem[2]<=8'b00000000;
Inst_Mem[3]<=8'b00001100;
Inst_Mem[4]<=8'b00111101;
Inst_Mem[5]<=8'b00000010;
Inst_Mem[6]<=8'b00000000;
Inst_Mem[7]<=8'b00001000;
Inst_Mem[8]<=8'b01101000;
Inst_Mem[9]<=8'b00101000;
Inst_Mem[10]<=8'b00010000;
Inst_Mem[11]<=8'b00000000;
Inst_Mem[12]<=8'b00001001;
Inst_Mem[13]<=8'b10000000;
Inst_Mem[14]<=8'b00000000;
Inst_Mem[15]<=8'b00001000;
Inst_Mem[16]<=8'b01101000;
Inst_Mem[17]<=8'b11000110;
Inst_Mem[18]<=8'b00110000;
Inst_Mem[19]<=8'b00000000;
Inst_Mem[20]<=8'b10101100;
Inst_Mem[21]<=8'b10100100;
Inst_Mem[22]<=8'b00000000;
Inst_Mem[23]<=8'b00000100;
Inst_Mem[24]<=8'b00000000;
Inst_Mem[25]<=8'b00000000;
Inst_Mem[26]<=8'b00000000;
Inst_Mem[27]<=8'b00000000;
Inst_Mem[28]<=8'b00000000;
Inst_Mem[29]<=8'b00000000;
Inst_Mem[30]<=8'b00000000;
Inst_Mem[31]<=8'b00000000;
Inst_Mem[32]<=8'b00000000;
Inst_Mem[33]<=8'b00000000;
Inst_Mem[34]<=8'b00000000;
Inst_Mem[35]<=8'b00000000;
end   
end


endmodule