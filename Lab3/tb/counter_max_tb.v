module counter_tb;

    parameter BITWIDTH = 2;
    parameter MAX = 2;

    reg clk, en, rst;

    wire [BITWIDTH - 1:0] count1, count2;
    wire carry1, carry2;

    counter #(.N(BITWIDTH)) uut1(clk, en, rst, count1, carry1);
    counter #(.N(BITWIDTH), .MAX(MAX)) uut2(clk, en, rst, count2, carry2);

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 0;
        rst <= 1;
        en <= 1;
        #1;
        rst <= 0;
        #20;
        en <= 0;
    end

endmodule