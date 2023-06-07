module playerdivider
(
    i_clk,
    i_rst,
    i_DIV,
    o_clk
);
    input wire i_clk, i_rst;
    input wire [26:0] i_DIV;
    output reg o_clk;

    wire clk_en;

    counter div_counter(.i_clk(i_clk), .i_en(1'b1), .i_rst(i_rst), .o_count(), .o_carry(clk_en), .max(i_DIV));

    always @(posedge i_clk) begin
        if (i_rst)
            o_clk <= 1'b1;
        else if (clk_en)
            o_clk <= ~o_clk;
    end

endmodule