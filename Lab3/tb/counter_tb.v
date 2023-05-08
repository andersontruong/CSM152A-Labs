module counter_tb;

    reg clk, en, rst;

    wire [2:0] count;
    wire carry;

    counter #(.N(3)) uut(clk, en, rst, count, carry);

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