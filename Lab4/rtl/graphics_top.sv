`timescale 1ns / 1ps

module graphics_top(
    input  CLK100MHZ,
    input  [3:0] btn,
    input  [5:0] SW,
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS
    );

    logic [3:0] reds [63:0];
    logic [3:0] blues [63:0];
    logic [3:0] greens [63:0];

    logic GAME_CLOCK;

    divider #(.DIV(50_000_000)) game_clock_gen(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(GAME_CLOCK));

    logic [31:0] RAND;
    logic [5:0] RAND_POS;
    logic [3:0] RAND_COLOR;

    lcg rng(.clk(GAME_CLOCK), .o_rand(RAND));

    assign RAND_POS = RAND % (2 << 6);
    assign RAND_COLOR = (RAND >> 30) % 4;

    integer i;
    always_ff @(posedge GAME_CLOCK) begin
        for (i = 0; i < 64; i = i + 1) begin
            reds[i] = 4'h0;
            blues[i] = 4'h0;
            greens[i] = 4'h0;
        end
        case (RAND_COLOR)
            0: begin
                reds[RAND_POS] = 4'hf;
                blues[RAND_POS] = 4'h0;
                greens[RAND_POS] = 4'h0;
            end
            1: begin
                reds[RAND_POS] = 4'h0;
                blues[RAND_POS] = 4'h0;
                greens[RAND_POS] = 4'hf;
            end
            2: begin
                reds[RAND_POS] = 4'h0;
                blues[RAND_POS] = 4'hf;
                greens[RAND_POS] = 4'h0;
            end
            3: begin
                reds[RAND_POS] = 4'hf;
                blues[RAND_POS] = 4'hf;
                greens[RAND_POS] = 4'hf;
            end
        endcase
    end

    reg [3:0] o_r, o_g, o_b;
    reg o_hsync, o_vsync;
    wire hsync, vsync;
    wire reset;

    wire [1:0] RED = SW[1:0];
    wire [1:0] GRE = SW[3:2];
    wire [1:0] BLU = SW[5:4]; 

    assign VGA_R = RED == 0 ? o_r : RED == 1 ? o_g : o_b;
    assign VGA_G = GRE == 0 ? o_r : GRE == 1 ? o_g : o_b;
    assign VGA_B = BLU == 0 ? o_r : BLU == 1 ? o_g : o_b;
    assign VGA_HS = o_hsync;
    assign VGA_VS = o_vsync;

    assign reset = btn[0];

    wire CLK25MHZ;

    localparam COORD_WIDTH = 10;
    wire [COORD_WIDTH - 1:0] sx, sy;
    wire de;

    divider display_clk(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(CLK25MHZ));

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