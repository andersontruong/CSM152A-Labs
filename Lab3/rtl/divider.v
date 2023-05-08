module divider
#(parameter FREQ=50_000_000)
(
    i_clk,
    i_rst,
    o_clk
);

    input wire i_clk, i_rst;
    output reg o_clk;

    reg [6:0] count;

    always @(posedge(i_clk), posedge(i_rst)) begin
        if (i_rst) begin
            count <= 0;
            o_clk <= 0;
        end
        else if (count == FREQ) begin
            count <= 0;
            o_clk <= ~o_clk;
        end
        else
            count <= count + 1;
    end

endmodule