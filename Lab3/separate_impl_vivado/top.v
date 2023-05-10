module impl_top(
    clk,
    rst,
    ADJ,
    SEL,
    seg,
    dig_sel
);
    input clk, rst, ADJ, SEL;

    output [7:0] seg;
    output [3:0] dig_sel;

    wire [3:0] dig1, dig2, dig3, dig4;

    wire [5:0] MINUTES, SECONDS;

    minsec_counter stopwatch(
        .i_clk(clk),
        .i_rst(rst),
        .ADJ(ADJ),
        .SEL(SEL),
        .MINUTES(MINUTES),
        .SECONDS(SECONDS)
    );

    digits sec(SECONDS, dig2, dig1);
    digits min(MINUTES, dig4, dig3);

    fourdigitdriver #(.REFRESH_DIV(1_000_000))
    driver(
        .i_clk(clk), 
        .i_rst(rst), 
        .dig1(dig1), 
        .dig2(dig2), 
        .dig3(dig3), 
        .dig4(dig4), 
        .seg(seg), 
        .dig_sel(dig_sel)
        );

endmodule