`timescale 1ns / 1ps

module graphics_top(
    input  CLK100MHZ,
    input  [4:0] btn,
    input  [2:0] sw, // Used to be input [5:0] sw
    input MISO, // Master In Slave Out, Pin 3, Port JA
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    output [7:0] seg, // Cathodes for Seven Segment Display (old)
    output [3:0] dig_sel // Anodes for Seven Segment Display (old)
    // output SS, // Slave Select, Pin 1, Port JA
    // output MOSI, // Master Out Slave In, Pin 2, Port JA
    // output SCLK, // Serial Clock, Pin 4, Port JA
    // output [2:0] LED // LEDs 2, 1, and 0
    );

    reg [3:0] reds [63:0];
    reg [3:0] blues [63:0];
    reg [3:0] greens [63:0];

    game game_inst(CLK100MHZ, reds, blues, greens);

    reg [3:0] o_r, o_g, o_b;
    reg o_hsync, o_vsync;
    wire hsync, vsync;
    wire reset;

    /* Start of PmodJSTK declarations */
    // wire SS; // Active Low
    // wire MOSI; // Data transfer from master to slave
    // wire SCLK; // Serial clock that controls communication
    // reg [2:0] LED; // Status of PmodJSTK buttons displayed on LEDs

    // // Holds data to be sent to PmodJSTK
    // wire [7:0] sndData;

    // // Signal to send/receive data to/from PmodJSTK
    // wire sndRec;

    // // Data read from PmodJSTK
    // wire [39:0] jstkData;

    // // Signal carrying output data that user selected
    // wire [9:0] posData;

    /* End of PmodJSTK declarations */

    assign vgaRed = o_r;
    assign vgaGreen = o_g;
    assign vgaBlue = o_b;
    assign Hsync = o_hsync;
    assign Vsync = o_vsync;

    assign reset = btn[0];

    wire CLK25MHZ;

    localparam COORD_WIDTH = 10;
    wire [COORD_WIDTH - 1:0] sx, sy;
    wire de;

    divider display_clk(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(CLK25MHZ));

    // Commented this out so I can debug PmodJSTK using seven seg display
    /*
    wire [13:0] score;
    wire [3:0] dig1, dig2, dig3, dig4;

    score_counter score_ctr(
        .i_clk(CLK100MHZ),
        .i_rst(reset),
        .i_en(1),
        .o_score(score)
    );

    digits digs(score, dig4, dig3, dig2, dig1);

    fourdigitdriver digdriver(
        .i_clk(CLK100MHZ),
        .i_rst(reset),
        .dig1(dig1),
        .dig2(dig2),
        .dig3(dig3),
        .dig4(dig4),
        .seg(seg),
        .dig_sel(dig_sel)
    );
    */

    display_480p display_instance(
        .clk_pix(CLK25MHZ),
        .rst_pix(reset),
        .o_sx(sx),
        .o_sy(sy),
        .hsync,
        .vsync,
        .de
    );

    reg [3:0] r, g, b;

    always @(*) begin
        if (sx >= 192 && sx < 448 && sy >= 112 && sy < 368) begin
            r <= reds[((sx - 192) >> 5) + (((sy - 112) >> 5) << 3)];
            g <= greens[((sx - 192) >> 5) + (((sy - 112) >> 5) << 3)];
            b <= blues[((sx - 192) >> 5) + (((sy - 112) >> 5) << 3)];
        end
        else begin
            r <= 4'h0;
            g <= 4'h0;
            b <= 4'h0;
        end
    end

    always @(posedge CLK25MHZ) begin
        o_hsync <= hsync;
        o_vsync <= vsync;
        if (de) begin
            o_r <= r;
            o_g <= g;
            o_b <= b;
        end
        else begin
            o_r <= 4'h0;
            o_g <= 4'h0;
            o_b <= 4'h0;
        end
    end

    // /* Start of PmodJSTK Implementation */
    // PmodJSTK PmodJSTK_Int(
    //     .CLK(CLK100MHZ),
    //     .RST(reset),
    //     .sndRec(sndRec),
    //     .DIN(sndData),
    //     .MISO(MISO),
    //     .SS(SS),
    //     .SCLK(SCLK),
    //     .MOSI(MOSI),
    //     .DOUT(jstkData)
    // );

    // // Seven Segment Display Controller Logic
    // wire [3:0] dig1, dig2, dig3, dig4;

    // // Tries to split a 10 bit quantity (posdata) into 4, 4 bit quantities (dig1-4)
    // digits digs(posData, dig4, dig3, dig2, dig1);

    // fourdigitdriver digdriver(
    //     .i_clk(CLK100MHZ),
    //     .i_rst(reset),
    //     .dig1(dig1),
    //     .dig2(dig2),
    //     .dig3(dig3),
    //     .dig4(dig4),
    //     .seg(seg),
    //     .dig_sel(dig_sel)
    // );


    // // 5 Hz Clock Signal to send/receive data to/from PmodJSTK
    // divider #(.DIV(20_000_000)) genSndRec(
    //     .CLK(CLK100MHZ),
    //     .RST(reset),
    //     .CLKOUT(sndRec)
    // );

    // // Use state of switch 0 to select output of X position or Y position data to SSD
    // assign posData = (sw[0] == 1'b1) ? {jstkData[9:8], jstkData[23:16]} : {jstkData[25:24], jstkData[39:32]};

    // // Data to be sent to PmodJSTK, lower two bits will turn on leds on PmodJSTK
    // assign sndData = {8'b100000, {sw[1], sw[2]}};

    // // Assign PmodJSTK button status to LED[2:0]
    // always @(sndRec or reset or jstkData) begin
    //         if(reset == 1'b1) begin
    //                 LED <= 3'b000;
    //         end
    //         else begin
    //                 LED <= {jstkData[1], {jstkData[2], jstkData[0]}};
    //         end
    // end

endmodule