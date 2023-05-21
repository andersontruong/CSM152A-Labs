module fourdigitdriver_tb;

    reg clk, rst;
    reg [3:0] dig1, dig2, dig3, dig4;

    wire [7:0] seg;
    wire [3:0] dig_sel;

    fourdigitdriver #(.REFRESH_DIV(1)) uut(
        clk,
        rst,
        dig1,
        dig2,
        dig3,
        dig4,
        seg,
        dig_sel
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
        #0.5;
        rst <= 1'b0;
    end

endmodule