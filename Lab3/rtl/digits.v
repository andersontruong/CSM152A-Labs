module digits(in_bin, out_dec10, out_dec1);
    input wire [5:0] in_bin; // 6 bit input
    output wire [3:0] out_dec10; // 4 bit output for 10s digit
    output wire [3:0] out_dec1; // 4 bit output for 1s digit

  	assign out_dec10 = (in_bin / 10);

  	assign out_dec1 = (in_bin % 10);
endmodule

// in_bin -> out_dec10 out_dec1
// 111111 -> 0101 1111
// 111110 -> 0101 1000
// 111101 -> 0101 0111
// 111100 -> 0101 0110
// 111011 -> 0101 0101
// 111010 -> 0101 0100
// 111001 -> 0101 0011
// 111000 -> 0101 0010
// 110111 -> 0101 0001
// 110110 -> 0101 0000
// 110101 -> 0100 1111