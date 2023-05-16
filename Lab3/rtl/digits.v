module digits(in_bin, out_dec10, out_dec1);
    input wire [5:0] in_bin; // 6 bit input
    output wire [3:0] out_dec10; // 4 bit output for 10s digit
    output wire [3:0] out_dec1; // 4 bit output for 1s digit

  	assign out_dec10 = (in_bin / 10);

  	assign out_dec1 = (in_bin % 10);
endmodule