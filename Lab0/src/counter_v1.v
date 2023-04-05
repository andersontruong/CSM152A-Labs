module counter
#(
    parameter BIT_WIDTH=4
)
(
    clk, rst, count
);

input wire clk, rst;
output reg [BIT_WIDTH-1:0] count;

always @(posedge clk) begin
    if (rst)
        count <= 4'b0;
    else begin
        count <= count + 1'b1;
    end
end

endmodule