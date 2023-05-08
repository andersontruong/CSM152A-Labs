module counter
#(
    parameter N=6
)(
    clk,
    en,
    rst,
    count
);

    input wire clk, en, rst;
    output reg [N-1:0] count;

    always @(posedge clk) begin
        if (rst)
            count <= 1'b0;
        else begin
            if (en) begin
                count <= count + 1'b1;
            end
        end
    end

endmodule