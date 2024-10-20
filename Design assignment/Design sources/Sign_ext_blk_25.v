module Sign_ext_blk_25 (
    input [25:0]ip,
    output[27:0]out
);

genvar i;

generate
    for(i=26;i<28;i=i+1)
    begin
    assign  out[i]=ip[25];
    end
endgenerate
assign out[25:0]=ip[25:0];
    
endmodule