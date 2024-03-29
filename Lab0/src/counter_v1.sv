module counter
#(
    parameter BIT_WIDTH=4
)
(
    clk, rst, count
);

input logic clk, rst;
output logic [BIT_WIDTH-1:0] count;

always_ff @(posedge clk) begin
    if (rst)
        count <= 4'b0;
    else begin
        count <= count + 1'b1;
    end
end

endmodule