module top(
    clk,
    rst,
    Led
);

input wire clk, rst;
output wire Led;

wire clk_1hz;

divider dut(clk, rst, clk_1hz);

assign Led = clk_1hz;

endmodule