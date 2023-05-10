module divider_muxed
#(
    parameter DIV1 = 50_000_000,
    parameter DIV2 = 25_000_000
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

    divider #(.DIV(DIV1)) div1(i_clk, i_rst, clk1);
    divider #(.DIV(DIV2)) div2(i_clk, i_rst, clk2);

endmodule