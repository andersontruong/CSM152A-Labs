// 4 bit leading zero counter
module lzc(i_chunk, o_all_zeros, o_zero_count);

   input wire [3:0]  i_chunk;
   output wire       o_all_zeros;
   output wire [1:0] o_zero_count;
   

   assign o_all_zeros = ~|i_chunk;

   assign o_zero_count[0] = ((~i_chunk[1])|i_chunk[2]) & ~i_chunk[3];
   assign o_zero_count[1] = ~(i_chunk[2] | i_chunk[3]);

endmodule
