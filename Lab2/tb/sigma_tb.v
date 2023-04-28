module sigma_tb;

   reg [11:0]  D;
   wire        S;
   wire [10:0] M;

   sigma uut(D, S, M);

   initial begin
      // Tmin Overflow test
      D <= 'b100000000000;
      #10;
      // Tmin+1 Same behavior as overflow
      D <= 'b100000000001;
      #10;
      // Smallest negative
      D <= 'b111111111111;
      #10;
      // Zero
      D <= 'b000000000000;
      #10;
      // Smallest positive
      D <= 'b000000000001;
      #10;
      // Tmax
      D <= 'b011111111111;
      #10;
   end

endmodule; // tb
