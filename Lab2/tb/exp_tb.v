module exp_tb;

   reg [10:0] mag;
   wire [2:0] E;

   exp uut(mag, E);

   initial begin
    
      mag <= 'b10000000000; //1 leading zeros
      #10;
      mag <= 'b01000000000; //2 leading zero
      #10;
      mag <= 'b00100000000; //3 leading zeros
      #10;
      mag <= 'b00010000000; //etc.
      #10;
      mag <= 'b00001000000;
      #10;
      mag <= 'b00000100000;
      #10;
      mag <= 'b00000010000;
      #10;
      mag <= 'b00000001000;
      #10;
      mag <= 'b00000000000;
      
    
   end

endmodule
