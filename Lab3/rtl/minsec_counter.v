module minsec_counter
#(
    parameter BASE_CLK = 100_000_000,
    parameter FREQ1 = 1,
    parameter FREQ2 = 2
)
(
    i_clk,
    i_rst,
    ADJ,
    SEL,
    MINUTES,
    SECONDS
);

    input wire i_clk, i_rst, ADJ, SEL;
    output wire [5:0] MINUTES, SECONDS;

    wire clk_selected;
    wire second_carry;

    reg second_rst, minute_rst;
    wire second_en, minute_en;

    assign second_en = ~ADJ | (ADJ & ~SEL);
    assign minute_en = (~ADJ & second_carry) | (ADJ & SEL);

    divider_muxed #(.BASE_CLK(BASE_CLK), .FREQ1(FREQ1), .FREQ2(FREQ2)) 
        div(
            .i_clk(i_clk), 
            .i_rst(i_rst), 
            .i_sel(ADJ), 
            .o_clk(clk_selected)
        );

    counter #(.MAX(60))
    second_counter(
        .i_clk(clk_selected), 
        .i_en(second_en), 
        .i_rst(i_rst), 
        .o_count(SECONDS), 
        .o_carry(second_carry)
        );
        
    counter #(.MAX(60))
    minute_counter(
        .i_clk(clk_selected), 
        .i_en(minute_en), 
        .i_rst(i_rst), 
        .o_count(MINUTES), 
        .o_carry()
        );

endmodule;