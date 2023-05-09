module stopwatch_nodisplay
#(
    parameter BASE_CLK = 100_000_000,
    parameter FREQ1 = 1,
    parameter FREQ2 = 2,
)
(
    i_clk,
    i_rst,
    ADJ,
    SEL,
    MINUTES,
    SECONDS
);

    localparam DIV_FREQ1 = $floor(BASE_CLK / (2 * FREQ1));
    localparam DIV_FREQ2 = $floor(BASE_CLK / (2 * FREQ2));

    input wire i_clk, i_rst, ADJ, SEL;
    output wire [5:0] MINUTES, SECONDS;

    minsec_counter #(.DIV_FREQ1(DIV_FREQ1), .DIV_FREQ2(DIV_FREQ2))
    uut(
        .i_clk(clk),
        .i_rst(rst),
        .ADJ(ADJ),
        .SEL(SEL),
        .MINUTES(MINUTES),
        .SECONDS(SECONDS)
    );

endmodule