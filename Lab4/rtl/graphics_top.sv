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

    always @(*) begin
        reds[0]   <= 4'h2;
        blues[0]  <= 4'h2;
        greens[0] <= 4'h0;
        reds[1]   <= 4'h2;
        blues[1]  <= 4'h1;
        greens[1] <= 4'h0;
        reds[2]   <= 4'h2;
        blues[2]  <= 4'h1;
        greens[2] <= 4'h0;
        reds[3]   <= 4'h2;
        blues[3]  <= 4'h1;
        greens[3] <= 4'h0;
        reds[4]   <= 4'h2;
        blues[4]  <= 4'h1;
        greens[4] <= 4'h0;
        reds[5]   <= 4'h2;
        blues[5]  <= 4'h1;
        greens[5] <= 4'h0;
        reds[6]   <= 4'h2;
        blues[6]  <= 4'h1;
        greens[6] <= 4'h0;
        reds[7]   <= 4'h2;
        blues[7]  <= 4'h1;
        greens[7] <= 4'h0;
        reds[8]   <= 4'h2;
        blues[8]  <= 4'h1;
        greens[8] <= 4'h0;
        reds[9]   <= 4'h2;
        blues[9]  <= 4'h1;
        greens[9] <= 4'h0;
        reds[10]   <= 4'h2;
        blues[10]  <= 4'h1;
        greens[10] <= 4'h0;
        reds[11]   <= 4'h3;
        blues[11]  <= 4'h2;
        greens[11] <= 4'h1;
        reds[12]   <= 4'h4;
        blues[12]  <= 4'h2;
        greens[12] <= 4'h1;
        reds[13]   <= 4'h3;
        blues[13]  <= 4'h2;
        greens[13] <= 4'h1;
        reds[14]   <= 4'h2;
        blues[14]  <= 4'h1;
        greens[14] <= 4'h0;
        reds[15]   <= 4'h2;
        blues[15]  <= 4'h1;
        greens[15] <= 4'h0;
        reds[16]   <= 4'h2;
        blues[16]  <= 4'h1;
        greens[16] <= 4'h0;
        reds[17]   <= 4'hb;
        blues[17]  <= 4'h8;
        greens[17] <= 4'h6;
        reds[18]   <= 4'hb;
        blues[18]  <= 4'h8;
        greens[18] <= 4'h7;
        reds[19]   <= 4'hc;
        blues[19]  <= 4'h9;
        greens[19] <= 4'h8;
        reds[20]   <= 4'hb;
        blues[20]  <= 4'h8;
        greens[20] <= 4'h7;
        reds[21]   <= 4'hb;
        blues[21]  <= 4'h8;
        greens[21] <= 4'h7;
        reds[22]   <= 4'ha;
        blues[22]  <= 4'h7;
        greens[22] <= 4'h5;
        reds[23]   <= 4'h3;
        blues[23]  <= 4'h2;
        greens[23] <= 4'h1;
        reds[24]   <= 4'ha;
        blues[24]  <= 4'h7;
        greens[24] <= 4'h6;
        reds[25]   <= 4'hb;
        blues[25]  <= 4'h8;
        greens[25] <= 4'h6;
        reds[26]   <= 4'ha;
        blues[26]  <= 4'h7;
        greens[26] <= 4'h6;
        reds[27]   <= 4'hb;
        blues[27]  <= 4'h8;
        greens[27] <= 4'h7;
        reds[28]   <= 4'hc;
        blues[28]  <= 4'h9;
        greens[28] <= 4'h8;
        reds[29]   <= 4'hb;
        blues[29]  <= 4'h8;
        greens[29] <= 4'h7;
        reds[30]   <= 4'h9;
        blues[30]  <= 4'h6;
        greens[30] <= 4'h4;
        reds[31]   <= 4'h9;
        blues[31]  <= 4'h6;
        greens[31] <= 4'h4;
        reds[32]   <= 4'hb;
        blues[32]  <= 4'h8;
        greens[32] <= 4'h6;
        reds[33]   <= 4'hf;
        blues[33]  <= 4'hf;
        greens[33] <= 4'hf;
        reds[34]   <= 4'h5;
        blues[34]  <= 4'h3;
        greens[34] <= 4'h8;
        reds[35]   <= 4'hb;
        blues[35]  <= 4'h7;
        greens[35] <= 4'h6;
        reds[36]   <= 4'hb;
        blues[36]  <= 4'h8;
        greens[36] <= 4'h7;
        reds[37]   <= 4'h5;
        blues[37]  <= 4'h3;
        greens[37] <= 4'h8;
        reds[38]   <= 4'hf;
        blues[38]  <= 4'hf;
        greens[38] <= 4'hf;
        reds[39]   <= 4'ha;
        blues[39]  <= 4'h7;
        greens[39] <= 4'h6;
        reds[40]   <= 4'h9;
        blues[40]  <= 4'h6;
        greens[40] <= 4'h4;
        reds[41]   <= 4'hb;
        blues[41]  <= 4'h7;
        greens[41] <= 4'h6;
        reds[42]   <= 4'hb;
        blues[42]  <= 4'h8;
        greens[42] <= 4'h7;
        reds[43]   <= 4'h6;
        blues[43]  <= 4'h4;
        greens[43] <= 4'h3;
        reds[44]   <= 4'h6;
        blues[44]  <= 4'h4;
        greens[44] <= 4'h3;
        reds[45]   <= 4'hb;
        blues[45]  <= 4'h8;
        greens[45] <= 4'h6;
        reds[46]   <= 4'ha;
        blues[46]  <= 4'h6;
        greens[46] <= 4'h4;
        reds[47]   <= 4'h8;
        blues[47]  <= 4'h5;
        greens[47] <= 4'h3;
        reds[48]   <= 4'h9;
        blues[48]  <= 4'h5;
        greens[48] <= 4'h4;
        reds[49]   <= 4'h9;
        blues[49]  <= 4'h5;
        greens[49] <= 4'h4;
        reds[50]   <= 4'h4;
        blues[50]  <= 4'h2;
        greens[50] <= 4'h0;
        reds[51]   <= 4'h8;
        blues[51]  <= 4'h4;
        greens[51] <= 4'h3;
        reds[52]   <= 4'h8;
        blues[52]  <= 4'h4;
        greens[52] <= 4'h3;
        reds[53]   <= 4'h4;
        blues[53]  <= 4'h2;
        greens[53] <= 4'h0;
        reds[54]   <= 4'h8;
        blues[54]  <= 4'h5;
        greens[54] <= 4'h3;
        reds[55]   <= 4'h8;
        blues[55]  <= 4'h5;
        greens[55] <= 4'h3;
        reds[56]   <= 4'h6;
        blues[56]  <= 4'h4;
        greens[56] <= 4'h2;
        reds[57]   <= 4'h6;
        blues[57]  <= 4'h4;
        greens[57] <= 4'h2;
        reds[58]   <= 4'h4;
        blues[58]  <= 4'h2;
        greens[58] <= 4'h0;
        reds[59]   <= 4'h4;
        blues[59]  <= 4'h1;
        greens[59] <= 4'h0;
        reds[60]   <= 4'h4;
        blues[60]  <= 4'h2;
        greens[60] <= 4'h0;
        reds[61]   <= 4'h4;
        blues[61]  <= 4'h2;
        greens[61] <= 4'h0;
        reds[62]   <= 4'h8;
        blues[62]  <= 4'h5;
        greens[62] <= 4'h3;
        reds[63]   <= 4'h7;
        blues[63]  <= 4'h4;
        greens[63] <= 4'h3;
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