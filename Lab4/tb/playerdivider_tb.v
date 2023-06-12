module playerdivider_tb;

    reg clk, rst;

    reg [26:0] div;

    wire o_clk;

    playerdivider uut(.i_clk(clk), .i_rst(rst), .i_DIV(div), .o_clk(o_clk));

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        clk <= 1'b1;
        rst <= 1'b1;
        div <= 2;
        #0.5;
        rst <= 1'b0;
        #10;
        div <= 4;
    end

endmodule