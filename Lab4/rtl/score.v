module score_counter
#(
    parameter i_DIV = 50_000_000
)
(
    i_clk,
    i_rst,
    i_en,
    o_score
);

input wire i_clk, i_rst, i_en;
output wire [13:0] o_score;

wire clk_div;
wire score_carry;

divider #(.DIV(i_DIV)) div1(i_clk, i_rst, clk_div);

counter #(.MAX(10000)) score_counter(
        .i_clk(clk_div), 
        .i_en(i_en), 
        .i_rst(i_rst), 
        .o_count(o_score), 
        .o_carry(score_carry)
        );

endmodule