module lzc_tb;

   reg [3:0]  D;
   wire       a;
   wire [1:0] q;

   lzc uut(D, a, q);

   initial begin

      D <= 'b0000;
      #10;
      D <= 'b0001;
      #10;
      D <= 'b0010;
      #10;
      D <= 'b0100;
      #10;
      D <= 'b1000;
      

   end

endmodule
