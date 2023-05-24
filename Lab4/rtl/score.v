module score
#(
    parameter DIV1 = 50_000_000,
    parameter DIV2 = 25_000_000
)
(
    i_clk,
    i_rst,
    i_en,
    ADJ,
    SEL,
    MINUTES,
    SECONDS
);

// TO DO: UPDATE IMPLEMENTATION FROM LAB 3 TO SCORE COUNTER

counter #(.MAX(10000)) score_counter(
        .i_clk(clk_selected), 
        .i_en(second_en), 
        .i_rst(i_rst), 
        .o_count(SECONDS), 
        .o_carry(second_carry)
        );

endmodule