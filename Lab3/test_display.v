module impl_top(
    clk,
    rst,
    ADJ,
    SEL,
    seg,
    dig_sel
);
    input wire clk, rst, ADJ, SEL;
    output wire [7:0] seg;
    output wire [3:0] dig_sel;

    assign seg = 8'b01000000;
    assign dig_sel = 4'b0000;

endmodule