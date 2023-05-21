module fourdigitdriver_tb;

    reg clk, rst, ADJ, SEL;
    reg [3:0] dig1, dig2, dig3, dig4;

    wire [7:0] seg;
    wire [3:0] dig_sel;

    fourdigitdriver #(.REFRESH_DIV(1), .BLINK_DIV(8)) uut(
        clk,
        rst,
        dig1,
        dig2,
        dig3,
        dig4,
        seg,
        dig_sel,
        SEL,
        ADJ
    );

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        rst <= 1'b1;
        dig1 <= 1;
        dig2 <= 2;
        dig3 <= 3;
        dig4 <= 4;
        ADJ <= 1'b0;
        SEL <= 1'b0;
        #0.5;
        rst <= 1'b0;
        #1.5;
        #6;
        ADJ <= 1'b1;
        #16;
        SEL <= 1'b1;
    end

endmodule