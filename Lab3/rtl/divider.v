module divider
#(
    parameter BASE_CLK = 100_000_000,
    parameter TARGET_CLK = 1
)
(
    i_clk,
    i_rst,
    o_clk
);
    localparam integer DIV = $ceil(BASE_CLK / (2 * TARGET_CLK));
    localparam integer BIT_WIDTH = $ceil($clog2(DIV)) + 1;

    input wire i_clk, i_rst;
    output reg o_clk;

    wire clk_en;

    counter #(.N(BIT_WIDTH), .MAX(DIV)) div_counter(.i_clk(i_clk), .i_en(1'b1), .i_rst(i_rst), .o_count(), .o_carry(clk_en));

    always @(posedge i_clk) begin
        if (i_rst)
            o_clk <= 1'b1;
        else if (clk_en)
            o_clk <= ~o_clk;
    end

endmodule