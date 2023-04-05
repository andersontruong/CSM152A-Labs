module divider
#(
    parameter MAX
)
(
    i_clk,
    i_rst,
    o_clk
);

    input  logic i_clk, i_rst;
    output logic o_clk;

    logic [$clog2(MAX)-1:0] count;

    always_ff @(posedge(i_clk), posedge(i_rst)) begin
        if (i_rst) begin
            count <= 0;
            o_clk <= 0;
        end
        else if (count == MAX) begin
            count <= 0;
            o_clk <= ~o_clk;
        end
        else
            count <= count + 1;
    end

endmodule