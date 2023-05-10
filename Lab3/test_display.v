module impl_top(
    clk,
    rst,
    ADJ,
    SEL,
    seg,
    dig_sel
);
    assign seg = 8'b10111111;
    assign dig_sel = 4'b1111;

endmodule