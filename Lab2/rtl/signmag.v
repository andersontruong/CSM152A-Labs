module sigma(D, S, M);

   input wire [11:0]  D;
   output wire        S;
   output wire [10:0] M;

   wire [10:0]        mag;
   wire               upper;
   wire [10:0]        lower;

   assign upper = D[11];

   assign lower = D[10:0];

   assign S = upper;

   assign mag = upper ? ~lower + 1 : lower;

   assign M = mag - (upper & !mag);

endmodule; // sigma
