module lzc(D, a, q);

   input wire [3:0]  D;
   output wire       a;
   output wire [1:0] q;
   

   assign a = ~|D;

   assign q[0] = ~(D[2] | D[3]);

   assign q[1] = ((~D[1])|D[2]) & ~D[3];

endmodule; // lzc
