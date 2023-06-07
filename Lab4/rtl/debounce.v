module debounce
#(
    parameter N=22
)
(
    clk,
    rst,
    btn,
    result
);

    input wire clk, btn, rst;

    output reg result;

    reg ff1, ff2;
    wire sclr, carry;

    always @(posedge clk) begin
        if (rst) begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
            result <= 1'b0;
        end
        else begin
            ff1 <= btn;
            ff2 <= ff1;
            if (carry)
                result <= ff2;
        end
    end

    assign sclr = ff1 ^ ff2;

    counter #(.N(N)) count_module(.i_clk(clk), .i_en(~carry), .i_rst(sclr), .o_count(), .o_carry(carry), .max(0));

endmodule