module counter
#(
    parameter BIT_WIDTH=4
)
(
    clk, rst, count
);

input logic clk, rst;
output logic [3:0] count;

always_ff @(posedge clk) begin
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