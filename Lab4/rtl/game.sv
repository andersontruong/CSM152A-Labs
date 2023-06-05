module game(
    input CLK100MHZ,
    input reset,
    output reg [3:0] reds [4095:0],
    output reg [3:0] blues [4095:0],
    output reg [3:0] greens [4095:0]
);
    wire GAME_CLOCK;

    divider #(.DIV(12_500_000)) game_clock_gen(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(GAME_CLOCK));

    wire [31:0] RAND;
    wire [11:0] NEXT_POS, RAND_POS, VEC_POS;
    reg [1:0] RAND_COLOR;

    wire [11:0] CURR_POS;

    reg [5:0] CURR_X, CURR_Y;
    wire [5:0] VEC_X, VEC_Y, UNIT_X, UNIT_Y;
    wire SIGN_X, SIGN_Y;
    wire [5:0] NEXT_X, NEXT_Y;

    lcg rng(.clk(GAME_CLOCK), .o_rand(RAND));

    wire [31:0] DIR_RAND;

    lcg rng2(.clk(GAME_CLOCK), .o_rand(DIR_RAND));

    reg [3:0] RAND_DIR;

    wire [1:0] path_count;
    wire path_carry;
    counter #(.N(2)) path_counter(.i_clk(GAME_CLOCK), .i_en(1), .i_rst(reset), .o_count(path_count), .o_carry(path_carry));

    always @(posedge GAME_CLOCK) begin
        if (path_carry) begin
            RAND_DIR <= (DIR_RAND >> 28);
            RAND_COLOR <= (RAND >> 30);
        end
    end

    reg [5:0] RAND_X, RAND_Y;
    always @(posedge GAME_CLOCK) begin
        case (RAND_DIR)
            0: begin
                CURR_X <= CURR_X;
                CURR_Y <= CURR_Y + 2;
            end
            1: begin
                CURR_X <= CURR_X + 1;
                CURR_Y <= CURR_Y + 2;
            end
            2: begin
                CURR_X <= CURR_X + 2;
                CURR_Y <= CURR_Y + 2;
            end
            3: begin
                CURR_X <= CURR_X + 2;
                CURR_Y <= CURR_Y + 1;
            end
            4: begin
                CURR_X <= CURR_X + 2;
                CURR_Y <= CURR_Y;
            end
            5:  begin
                CURR_X <= CURR_X + 2;
                CURR_Y <= CURR_Y - 1;
            end
            6: begin
                CURR_X <= CURR_X + 2;
                CURR_Y <= CURR_Y - 2;
            end
            7: begin
                CURR_X <= CURR_X + 1;
                CURR_Y <= CURR_Y - 2;
            end
            8: begin
                CURR_X <= CURR_X;
                CURR_Y <= CURR_Y - 2;
            end
            9: begin
                CURR_X <= CURR_X - 1;
                CURR_Y <= CURR_Y - 2;
            end
            10: begin
                CURR_X <= CURR_X - 2;
                CURR_Y <= CURR_Y - 2;
            end
            11: begin
                CURR_X <= CURR_X - 2;
                CURR_Y <= CURR_Y - 1;
            end
            12: begin
                CURR_X <= CURR_X - 2;
                CURR_Y <= CURR_Y;
            end
            13: begin
                CURR_X <= CURR_X - 2;
                CURR_Y <= CURR_Y + 1;
            end
            14: begin
                CURR_X <= CURR_X - 2;
                CURR_Y <= CURR_Y + 2;
            end
            15: begin
                CURR_X <= CURR_X - 1;
                CURR_Y <= CURR_Y + 2;
            end
        endcase
    end

    assign CURR_POS = CURR_X + 64*CURR_Y;

    // Map color to positions
    integer i;
    always @(posedge GAME_CLOCK) begin
        for (i = 0; i < 4096; i = i + 1) begin
            reds[i] = 4'hb;
            blues[i] = 4'hb;
            greens[i] = 4'hb;
        end

        case (RAND_COLOR)
            0: begin
                reds[CURR_POS] <= 4'hf;
                blues[CURR_POS] <= 4'h0;
                greens[CURR_POS] <= 4'h0;
            end
            1: begin
                reds[CURR_POS] <= 4'h0;
                blues[CURR_POS] <= 4'h0;
                greens[CURR_POS] <= 4'hf;
            end
            2: begin
                reds[CURR_POS] <= 4'h0;
                blues[CURR_POS] <= 4'hf;
                greens[CURR_POS] <= 4'h0;
            end
            3: begin
                reds[CURR_POS] <= 4'hf;
                blues[CURR_POS] <= 4'hf;
                greens[CURR_POS] <= 4'hf;
            end
        endcase
    end

endmodule