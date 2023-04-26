module lze_tb;

   wire [1:0] a;
   wire       q;

   lze uut(a, q);

   initial begin
      
      // blank
      a <= 'b00;
      #10;
      // blank
      a <= 'b01;
      #10;
      // fires
      a <= 'b10;
      #10;
      // fires
      a <= 'b11;

    end
endmodule
