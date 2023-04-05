module counter
#(
    parameter BIT_WIDTH=4
)
(
    clk, rst, count
);

input clk, rst;
output reg [BIT_WIDTH-1:0] count;

always @(posedge clk) begin
    if (rst)
        count <= 4'b0;
    else begin
        count[0] <= ~count[0];
        count[1] <= count[0] ^ count[1];
        count[2] <= (count[0] & count[1]) ^ count[2];
        count[3] <= (count[0] & count[1] & count[2]) ^ count[3];
    end
end

endmodule