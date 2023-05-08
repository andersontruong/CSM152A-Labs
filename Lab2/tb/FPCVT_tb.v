module FPCVT_tb;

   reg [11:0]  D;
   wire        S;
   wire [3:0]  F;
   wire [2:0]  E;

   FPCVT uut(D, S, F, E);

   initial begin
      D <= 'b100000000000;
      #10;
      D <= 'b100000000001;
      #10;
      D <= 'b111111111111;
      #10;
      D <= 'b000000000000;
      #10;
      D <= 'b000000000001;
      #10;
      D <= 'b011111111111;
      #10;
   end

endmodule