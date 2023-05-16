
module impl_top(
    clk,
    rst,
    ADJ,
    SEL,
    PAUSE,
    seg,
    dig_sel
);
    input clk, rst, ADJ, SEL, PAUSE;

    output [7:0] seg;
    output [3:0] dig_sel;

    wire [3:0] dig1, dig2, dig3, dig4;

    wire [5:0] MINUTES, SECONDS;
    
    wire res_sel;
    wire res_adj;
    
    debounce debouncer1(
        .clk(clk),
        .rst(rst),
        .btn(SEL),
        .result(res_sel)
    );
    
    debounce debouncer2(
        .clk(clk),
        .rst(rst),
        .btn(ADJ),
        .result(res_adj)
    );
    
    minsec_counter stopwatch(
        .i_clk(clk),
        .i_rst(rst),
        .i_en(~PAUSE),
        .ADJ(res_adj),
        .SEL(res_sel),
        .MINUTES(MINUTES),
        .SECONDS(SECONDS)
    );

    digits sec(SECONDS, dig2, dig1);
    digits min(MINUTES, dig4, dig3);
    
    fourdigitdriver #(.REFRESH_DIV(100_000))
    driver(
        .i_clk(clk), 
        .i_rst(rst), 
        .dig1(dig1), 
        .dig2(dig2), 
        .dig3(dig3), 
        .dig4(dig4), 
        .seg(seg), 
        .dig_sel(dig_sel),
        .ADJ(ADJ),
        .SEL(SEL)
        );

endmodule