module exp_tb;

   wire [10:0] mag;
   wire [2:0] E;

   exp uut(mag, E);

   initial begin
    
      mag <= 'b10000000000;
      #10;
      mag <= 'b01000000000;
      #10;
      mag <= 'b00100000000;
      #10;
      mag <= '10001000000;
      #10;
      mag <= 'b00001000000;
      #10;
      mag <= 'b00000100000;
      #10;
      mag <= 'b00000010000;
      #10;
      mag <= 'b00000001000;
    
   end

endmodule
