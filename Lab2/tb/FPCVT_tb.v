module FPCVT_tb;

   reg [11:0]  D;

   wire        S;
   wire [3:0]  F;
   wire [2:0]  E;

   FPCVT uut(D, S, F, E);

   initial begin
      // Tmin Overflow test
      D <= 'b0100000000000;
      #10;
      // Tmin+1 Same behavior as overflow
      D <= 'b0100000000001;
      #10;
      // Smallest negative
      D <= 'b0111111111111;
      #10;
      // Zero
      D <= 'b1000000000000;
      #10;
      // Smallest positive
      D <= 'b1000000000001;
      #10;
      // Tmax
      D <= 'b1011111111111;
      #10;
   end

endmodule; // tb
