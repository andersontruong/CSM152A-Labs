`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2023 04:48:03 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top;

logic clk, rst, CLK_1HZ;

top dut(clk, rst, CLK_1HZ);

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

