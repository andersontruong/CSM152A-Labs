module exp(mag, E);

   input wire [10:0] mag;
   output wire [2:0] E;

   wire [3:0]        upper_bits;
   wire [3:0]        lower_bits;

   wire [1:0]        a;
   wire [1:0]        z0;
   wire [1:0]        z1;

   assign upper_bits = mag[10:7];
   assign lower_bits = mag[7:4];

   lzc upper(upper_bits, a[0], z0);
   lzc lower(lower_bits, a[1], z1);

   assign E[1:0] = a[0] ? z1 : z0;
   assign E[2] = a[0];

endmodule; // exp

