module exp(i_mag, o_exp_temp);

   input wire [10:0] i_mag;
   output wire [2:0] o_exp_temp;

   wire [3:0]        upper_bits;
   wire [3:0]        lower_bits;

   wire [1:0]        a;
   wire [1:0]        z0;
   wire [1:0]        z1;

   wire [2:0] leading_zeros;

   assign upper_bits = i_mag[10:7];
   assign lower_bits[3:1] = i_mag[6:4];
   assign lower_bits[0] = 'b1;

   lzc upper(upper_bits, a[0], z0);
   lzc lower(lower_bits, a[1], z1);

   // Leading zero encoder
   assign leading_zeros[1:0] = a[0] ? z1 : z0;
   assign leading_zeros[2] = a[0];

   assign o_exp_temp = 7 - leading_zeros;


endmodule; // exp

