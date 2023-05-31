`timescale 1ns / 1ps

module graphics_top(
    input  CLK100MHZ,
    input  [4:0] btn,
    input  [5:0] sw,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    output [7:0] seg,
    output [3:0] dig_sel
    );

    reg [3:0] reds [63:0];
    reg [3:0] blues [63:0];
    reg [3:0] greens [63:0];

    game game_inst(CLK100MHZ, reds, blues, greens);

    reg [3:0] o_r, o_g, o_b;
    reg o_hsync, o_vsync;
    wire hsync, vsync;
    wire reset;

    wire [1:0] RED = sw[1:0];
    wire [1:0] GRE = sw[3:2];
    wire [1:0] BLU = sw[5:4]; 

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

endmodule