module top(
    clk,
    rst,
    Led,
    debug
);

input logic clk, rst;
output logic Led;
output logic debug;

logic clk_1hz;

divider #(.MAX(50000000)) dut(clk, rst, clk_1hz);

assign Led = clk_1hz;
assign debug = clk_1hz;

endmodule