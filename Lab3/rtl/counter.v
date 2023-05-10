module counter
#(
    parameter N=6,
    parameter MAX=0
)
(
    i_clk,
    i_en,
    i_rst,
    o_count,
    o_carry
);
    localparam integer MAX_OVERFLOW = MAX ? MAX : 1<<(N);
    input wire i_clk, i_en, i_rst;
    output reg [N-1:0] o_count;
    output wire o_carry;

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