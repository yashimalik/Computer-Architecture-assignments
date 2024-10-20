module Sign_ext_blk_15 (
    input [15:0]ip,
    output[31:0]out
);

genvar i;

generate
    for(i=16;i<32;i=i+1)
    begin
    assign  out[i]=ip[15];
    end
endgenerate
assign out[15:0]=ip[15:0];
    
endmodule
