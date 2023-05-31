module score
#(
    parameter DIV1 = 50_000_000,
    parameter DIV2 = 25_000_000
)
(
    i_clk,
    i_rst,
    i_en,
    SCORE
);

input wire i_clk, i_rst, i_en;
output wire [13:0] SCORE;

wire clk_selected;
wire score_carry; // is this necessary?

counter #(.MAX(10000)) score_counter(
        .i_clk(i_clk), 
        .i_en(i_en), 
        .i_rst(i_rst), 
        .o_count(SCORE), 
        .o_carry(score_carry)
        );

endmodule