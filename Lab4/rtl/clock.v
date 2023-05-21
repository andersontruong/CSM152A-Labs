`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 08:43:10 PM
// Design Name: 
// Module Name: clock_top
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


module clock(
    input CLK100MHZ,
    output [2:0] ja
    );

    logic CLK25MHZ, reset, locked, CLK50MHZ;

    clk_pixel clk_pixel_instance(
    // Clock out ports
    .CLK50MHZ,     // output CLK50MHZ
    .CLK25MHZ,     // output CLK25MHZ
    // Status and control signals
    .reset, // input reset
    .locked,       // output locked
   // Clock in ports
    .CLK100MHZ);      // input CLK100MHZ

    assign ja[2] = reset;
    assign ja[1] = locked;

    assign ja[0] = locked ? CLK25MHZ : 0;

endmodule