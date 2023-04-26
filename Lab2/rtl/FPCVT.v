module FPCVT(D, S, E, F);

   input wire [11:0]  D;

   output wire        S;
   output wire [2:0]  E;
   output wire [3:0]  F;

   wire [10:0]        mag;

   sigma twos_to_sigma(D, S, mag);
   

endmodule
