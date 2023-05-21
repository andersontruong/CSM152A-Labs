module divider_muxed_tb;

    reg clk, rst, sel;

    wire o_clk;

    divider_muxed #(.DIV1(1), .DIV2(2)) uut(.i_clk(clk), .i_rst(rst), .i_sel(sel), .o_clk(o_clk));

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        rst <= 1'b1;
        sel <= 1'b0;
        #0.5;
        rst <= 1'b0;
        #20;
        sel <= 1'b1;
    end

endmodule