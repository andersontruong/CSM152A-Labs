module sigma(i_twos, o_sign, o_mag_temp);

   input wire [11:0]  i_twos;
   output wire        o_sign;
   output wire [10:0] o_mag_temp;

   wire [10:0]        mag;
   wire               upper;
   wire [10:0]        lower;

   assign upper = i_twos[11];

   assign lower = i_twos[10:0];

   assign o_sign = upper;

   assign mag = upper ? ~lower + 1 : lower;

   assign o_mag_temp = mag - (upper & !mag);

endmodule
