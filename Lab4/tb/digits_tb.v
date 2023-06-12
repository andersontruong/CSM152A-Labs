module digits_tb;
  reg [9:0] bin;
  wire [3:0] out_dec1000, out_dec100, out_dec10, out_dec1;
  
  digits uut(bin, out_dec1000, out_dec100, out_dec10, out_dec1);

  integer i;
  
  initial begin
	for (i = 0; i < 10000; i = i + 1) begin
		bin <= i;
		#10;
//		$display("10s: %b", out_dec10);
//		$display("1s: %b",out_dec1);
	end
	$finish();
  end
endmodule