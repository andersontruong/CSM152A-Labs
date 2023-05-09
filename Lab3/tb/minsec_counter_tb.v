module minsec_counter_tb;

    reg clk, rst, ADJ, SEL;
    wire [5:0] MINUTES, SECONDS;

    minsec_counter #(.BASE_CLK(4), .FREQ1(1), .FREQ2(2))
    uut(
        .i_clk(clk),
        .i_rst(rst),
        .ADJ(ADJ),
        .SEL(SEL),
        .MINUTES(MINUTES),
        .SECONDS(SECONDS)
    );

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        rst <= 1'b1;
        ADJ <= 1'b0;
        SEL <= 1'b0;
        #0.5;
        rst <= 1'b0;
        #10;
        ADJ <= 1'b1;
        SEL <= 1'b1;
        #50;
        SEL <= 1'b0;
        #50;
        ADJ <= 1'b0;
    end

endmodule