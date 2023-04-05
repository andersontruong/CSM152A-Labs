`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2023 03:39:09 PM
// Design Name: 
// Module Name: tb0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb0;

logic clk, rst;
logic [3:0] count;

counter_4bit dut(clk, rst, count);

always begin
    clk <= ~clk;
    #0.5;
end

integer i;

initial begin
    clk <= 0;
    rst <= 1;
    #1;
    rst <= 0;
    for (i = 0; i < 16; i = i + 1) begin
        $display("time: %02d; counter: %02d", $stime, count);
        #1;
    end
end

endmodule
