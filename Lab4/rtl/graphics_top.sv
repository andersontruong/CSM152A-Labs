`timescale 1ns / 1ps

module graphics_top(
    input  CLK100MHZ,
    input  [4:0] btn,
    input  [5:0] sw, // Used to be input [5:0] sw
    input vauxp6,
    input vauxn6,
    input vauxp7,
    input vauxn7,
    input vp_in,
    input vn_in,
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

    logic reset;
    assign reset = btn[0];

    /* BEGIN DISPLAY */
    localparam integer CANVAS_SIZE = 32;
    localparam integer PIXELS = CANVAS_SIZE*CANVAS_SIZE;

    reg [3:0] reds [PIXELS - 1:0];
    reg [3:0] blues [PIXELS - 1:0];
    reg [3:0] greens [PIXELS - 1:0];

    // Generates canvas
    game #(.PIXELS(PIXELS)) game_inst(CLK100MHZ, reset, reds, blues, greens);

    logic [3:0] o_r, o_g, o_b;
    logic o_hsync, o_vsync;
    logic hsync, vsync;

    assign vgaRed = o_r;
    assign vgaGreen = o_g;
    assign vgaBlue = o_b;
    assign Hsync = o_hsync;
    assign Vsync = o_vsync;

    logic CLK25MHZ;

    localparam COORD_WIDTH = 10;
    logic [COORD_WIDTH - 1:0] sx, sy;
    logic de;

    divider display_clk(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(CLK25MHZ));

    // Generate (sx, sy, hsync, vsync, de) from a clock
    display_480p display_instance(
        .clk_pix(CLK25MHZ),
        .rst_pix(reset),
        .o_sx(sx),
        .o_sy(sy),
        .hsync,
        .vsync,
        .de
    );

    logic [3:0] r, g, b;

    // Map pixel array to physical screen blocks
    localparam integer SCREEN_START_X = 192;
    localparam integer SCREEN_SIZE = 256;
    localparam integer SCREEN_START_Y = 112;
    localparam integer PIXELS_PER_BLOCK = SCREEN_SIZE / CANVAS_SIZE;
    localparam integer PIXELS_PER_BLOCK_SHIFT = $clog2(PIXELS_PER_BLOCK);
    localparam integer ROW_SHIFT = $clog2(CANVAS_SIZE);

    always @(*) begin
        if (sx >= SCREEN_START_X && sx < SCREEN_START_X + SCREEN_SIZE && sy >= SCREEN_START_Y && sy < SCREEN_START_Y + SCREEN_SIZE) begin
            r <= reds[((sx - SCREEN_START_X) >> PIXELS_PER_BLOCK_SHIFT) + (((sy - SCREEN_START_Y) >> PIXELS_PER_BLOCK_SHIFT) << ROW_SHIFT)];
            g <= greens[((sx - SCREEN_START_X) >> PIXELS_PER_BLOCK_SHIFT) + (((sy - SCREEN_START_Y) >> PIXELS_PER_BLOCK_SHIFT) << ROW_SHIFT)];
            b <= blues[((sx - SCREEN_START_X) >> PIXELS_PER_BLOCK_SHIFT) + (((sy - SCREEN_START_Y) >> PIXELS_PER_BLOCK_SHIFT) << ROW_SHIFT)];
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
    /* END DISPLAY */

    logic enable;
    logic ready;
    logic [6:0] addr;
    wire [15:0] data;

    xadc_wiz_0 XADC (
    .di_in(0),              // input wire [15 : 0] di_in
    .daddr_in(addr),        // input wire [6 : 0] daddr_in
    .den_in(enable),            // input wire den_in
    .dwe_in(0),            // input wire dwe_in
    .drdy_out(ready),        // output wire drdy_out
    .do_out(data),            // output wire [15 : 0] do_out
    .dclk_in(CLK100MHZ),          // input wire dclk_in
    .vp_in(vp_in),              // input wire vp_in
    .vn_in(vn_in),              // input wire vn_in
    .vauxp6(vauxp6),            // input wire vauxp6
    .vauxn6(vauxn6),            // input wire vauxn6
    .vauxp7(vauxp7),            // input wire vauxp7
    .vauxn7(vauxn7),            // input wire vauxn7
    .channel_out(),  // output wire [4 : 0] channel_out
    .eoc_out(enable),          // output wire eoc_out
    .alarm_out(),      // output wire alarm_out
    .eos_out(),          // output wire eos_out
    .busy_out()        // output wire busy_out
    );

    logic [9:0] score;
    logic [3:0] dig1, dig2, dig3, dig4;

    // assign score = data[15:2];

    logic [3:0] upper;

    assign upper = data[15:12];

    // 0: none, 1: right, 2: left
    logic [1:0] X_DIR, Y_DIR;

    // assign addr = 8'h16;

    always @(posedge CLK100MHZ) begin
        if (reset) begin
            addr <= 8'h16;
        end
        else if (ready) begin
            if (addr == 8'h16) begin
                addr <= 8'h17;
                if (upper >= 14)
                    X_DIR <= 2;
                else if (upper >= 1)
                    X_DIR <= 1;
                else
                    X_DIR <= 0;
            end
            else if (addr == 8'h17) begin
                addr <= 8'h16;
                if (upper >= 14)
                    Y_DIR <= 0;
                else if (upper >= 1)
                    Y_DIR <= 1;
                else
                    Y_DIR <= 2;
            end
        end
    end

    assign dig1 = X_DIR;
    assign dig4 = Y_DIR;

    // score_counter score_ctr(
    //     .i_clk(CLK100MHZ),
    //     .i_rst(reset),
    //     .i_en(1),
    //     .o_score(score)
    // );

    // digits digs(score, dig4, dig3, dig2, dig1);

    assign dig2 = 4'b0;
    assign dig3 = 4'b0;

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

endmodule