module divider_muxed
#(
    parameter BASE_CLK = 100_000_000,
    parameter FREQ1 = 1,
    parameter FREQ2 = 2
)
(
    i_clk,
    i_rst,
    i_sel,
    o_clk
);

    input wire i_clk, i_rst, i_sel;
    output wire o_clk;

    wire clk1, clk2;

    assign o_clk = i_sel ? clk2 : clk1;

    divider #(.BASE_CLK(BASE_CLK), .TARGET_CLK(FREQ1)) div1(i_clk, i_rst, clk1);
    divider #(.BASE_CLK(BASE_CLK), .TARGET_CLK(FREQ2)) div2(i_clk, i_rst, clk2);

endmodule