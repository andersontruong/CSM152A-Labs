module digits_tb;
  reg [5:0] bin;
  wire [3:0] out_dec10;
  wire [3:0] out_dec1;
  
  digits uut(bin, out_dec10, out_dec1);
  
  initial begin
    bin <= 'b000000; // 0
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000001; // 1
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000010; // 2
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000011; // 3
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000100; // 4
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000101; // 5
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000110; // 6
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b000111; // 7
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001000; // 8
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001001; // 9
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001010; // 10
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001011; // 11
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001100; // 12
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001101; // 13
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001110; // 14
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b001111; // 15
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010000; // 16
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010001; // 17
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010010; // 18
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010011; // 19
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010100; // 20
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010101; // 21
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010110; // 22
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b010111; // 23
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011000; // 24
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011001; // 25
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011010; // 26
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011011; // 27
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011100; // 28
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011101; // 29
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011110; // 30
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b011111; // 31
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100000; // 32
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100001; // 33
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100010; // 34
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100011; // 35
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100100; // 36
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100101; // 37
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100110; // 38
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b100111; // 39
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101000; // 40
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101001; // 41
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101010; // 42
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101011; // 43
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101100; // 44
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101101; // 45
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101110; // 46
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b101111; // 47
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110000; // 48
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110001; // 49
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110010; // 50
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110011; // 51
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110100; // 52
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110101; // 53
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110110; // 54
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b110111; // 55
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b111000; // 56
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b111001; // 57
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b111010; // 58
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);
	bin <= 'b111011; // 59
	#10;
	$display("10s: %b", out_dec10);
	$display("1s: %b",out_dec1);

  end
endmodule