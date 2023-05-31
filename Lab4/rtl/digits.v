module digits(in_bin, out_dec1000, out_dec100, out_dec10, out_dec1);
    input wire [13:0] in_bin; // 14 bit input
    output wire [3:0] out_dec1000; // 4 bit output for 1000s digit
    output wire [3:0] out_dec100; // 4 bit output for 100s digit
    output wire [3:0] out_dec10; // 4 bit output for 10s digit
    output wire [3:0] out_dec1; // 4 bit output for 1s digit

  	assign out_dec1 = (in_bin % 10);
    assign out_dec10 = (in_bin / 10) % 10;
    assign out_dec100 = (in_bin / 100) % 10;
    assign out_dec1000 = (in_bin / 1000) % 10;
endmodule