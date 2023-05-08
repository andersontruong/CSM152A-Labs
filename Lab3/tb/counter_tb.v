module counter_tb;

    reg clk, en, rst;

    wire [5:0] count;

    counter #(.N(6)) uut(clk, en, rst, count);

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