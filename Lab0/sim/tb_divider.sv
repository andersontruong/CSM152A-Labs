`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2023 06:31:03 PM
// Design Name: 
// Module Name: tb_divider
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


module tb_divider;

logic clk, rst, CLK_1_10th;

divider #(.MAX(10)) dut(clk, rst, CLK_1_10th);

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
    #2;
    for (i = 0; i < 200; i = i + 1) begin
        //$display("time: %02d; counter: %02d", $stime, count);
        #1;
    end
end

endmodule

