module divider_tb;

    reg clk, rst;

    wire o_clk;

    divider #(.BASE_CLK(4), .TARGET_CLK(1)) uut(.i_clk(clk), .i_rst(rst), .o_clk(o_clk));

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        rst <= 1'b1;
        #0.5;
        rst <= 1'b0;
    end

endmodule