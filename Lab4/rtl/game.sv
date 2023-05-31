module game(
    input CLK100MHZ,
    output reg [3:0] reds [63:0],
    output reg [3:0] blues [63:0],
    output reg [3:0] greens [63:0]
);
    wire GAME_CLOCK;

    divider #(.DIV(50_000_000)) game_clock_gen(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(GAME_CLOCK));

    wire [31:0] RAND;
    wire [5:0] NEXT_POS, RAND_POS, VEC_POS;
    wire [3:0] RAND_COLOR;

    reg [5:0] CURR_POS;

    wire [2:0] CURR_X, CURR_Y, RAND_X, RAND_Y, VEC_X, VEC_Y;
    wire SIGN_X, SIGN_Y;
    reg [2:0] NEXT_X, NEXT_Y;

    lcg rng(.clk(GAME_CLOCK), .o_rand(RAND));

    assign RAND_POS = RAND % (2 << 6);
    assign RAND_COLOR = (RAND >> 30) % 4;

    assign CURR_X = CURR_POS % 8;
    assign CURR_Y = CURR_POS >> 3;

    assign RAND_X = RAND_POS % 8;
    assign RAND_Y = RAND_POS >> 3;

    // 1 if positive, 0 if negative
    assign SIGN_X = RAND_X > CURR_X;
    assign SIGN_Y = RAND_Y > CURR_Y;

    assign VEC_X = SIGN_X ? RAND_X - CURR_X : CURR_X - RAND_X;
    assign VEC_Y = SIGN_Y ? RAND_Y - CURR_Y : CURR_Y - RAND_Y;
    assign VEC_POS = VEC_X + 8 * VEC_Y;

    always @(*) begin
        if (RAND_X < RAND_Y) begin
            NEXT_X <= 1;
            NEXT_Y <= RAND_Y / RAND_X;
        end
        else begin
            NEXT_X <= RAND_X / RAND_Y;
            NEXT_Y <= 1;
        end
    end

    assign NEXT_POS = NEXT_X + 8*NEXT_Y;

    // Move to next position
    always @(posedge GAME_CLOCK) begin
        CURR_POS <= NEXT_POS;
    end

    always @(posedge GAME_CLOCK) begin
        reds[VEC_POS] <= 4'h0;
        blues[VEC_POS] <= 4'hf;
        greens[VEC_POS] <= 4'hf;
    end

    // Map color to positions
    integer i;
    always @(posedge GAME_CLOCK) begin
        for (i = 0; i < 64; i = i + 1) begin
            reds[i] = 4'h0;
            blues[i] = 4'h0;
            greens[i] = 4'h0;
        end
        case (RAND_COLOR)
            0: begin
                reds[CURR_POS] = 4'hf;
                blues[CURR_POS] = 4'h0;
                greens[CURR_POS] = 4'h0;
            end
            1: begin
                reds[CURR_POS] = 4'h0;
                blues[CURR_POS] = 4'h0;
                greens[CURR_POS] = 4'hf;
            end
            2: begin
                reds[CURR_POS] = 4'h0;
                blues[CURR_POS] = 4'hf;
                greens[CURR_POS] = 4'h0;
            end
            3: begin
                reds[CURR_POS] = 4'hf;
                blues[CURR_POS] = 4'hf;
                greens[CURR_POS] = 4'hf;
            end
        endcase
    end

endmodule