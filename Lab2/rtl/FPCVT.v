module FPCVT(D, S, F, E);

   input wire [11:0]  D; // 12-bit two's complement input 
   // output wire [11:0] TWOS;

   output wire        S; // Sign
   output wire [3:0]  F; // Significand
   output wire [2:0]  E; // Exponent

   wire [10:0]        mag_temp;
   wire [2:0]         exp_temp;

   sigma twos_to_sigma(D, S, mag_temp);

   // assign TWOS = ~D + 1;

   exp extract_exp(mag_temp, exp_temp);

   rounder round(mag_temp, exp_temp, F, E);

endmodule
