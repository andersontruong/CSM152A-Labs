module counter
#(
    parameter N=27
)
(
    i_clk,
    i_en,
    i_rst,
    o_count,
    o_carry,
    max
);
    localparam integer shifted = 1 << (N - 1);
    input wire i_clk, i_en, i_rst;
    output reg [N-1:0] o_count;
    output wire o_carry;
    input wire [N-1:0] max;

    wire [N-1:0] MAX_OVERFLOW;

    assign MAX_OVERFLOW = max != 0 ? max : shifted;

    assign o_carry = o_count == MAX_OVERFLOW - 1;

    always @(posedge i_clk, posedge i_rst) begin
        if (i_rst)
            o_count <= 0;
        else begin
            if (i_en) begin
                if (o_count == MAX_OVERFLOW - 1) begin
                    o_count <= 0;
                end
                else begin
                    o_count <= o_count + 1'b1;
                end
            end
        end
    end

endmodule