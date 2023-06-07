module game
#(
    parameter integer PIXELS = 64
)
(
    input CLK100MHZ,
    input reset,
    output reg [3:0] reds [PIXELS - 1:0],
    output reg [3:0] blues [PIXELS - 1:0],
    output reg [3:0] greens [PIXELS - 1:0]
);
    localparam integer POS_SIZE = $clog2(PIXELS);
    localparam integer CANVAS_SIZE = $sqrt(PIXELS);
    localparam integer VEC_SIZE = $clog2(CANVAS_SIZE);

    // Game clock
    logic GAME_CLOCK;
    divider #(.DIV(12_500_000)) game_clock_gen(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(GAME_CLOCK));

    // Array positions and position vectors
    logic [POS_SIZE - 1:0] CURR_POS, NEXT_POS, RAND_POS, VEC_POS;
    logic [VEC_SIZE - 1:0] CURR_X, CURR_Y;

    // Random quantities
    logic [31:0] RAND_FOR_COLOR, RAND_FOR_DIR;
    logic [3:0] RAND_DIR;
    logic [1:0] RAND_COLOR;

    // RNGs
    lcg rng1(.clk(GAME_CLOCK), .o_rand(RAND_FOR_COLOR));
    lcg rng2(.clk(GAME_CLOCK), .o_rand(RAND_FOR_DIR));

    // Target switch clock
    logic PATH_CARRY;
    counter #(.N(2)) path_divider(.i_clk(GAME_CLOCK), .i_en(1), .i_rst(reset), .o_count(), .o_carry(PATH_CARRY));

    logic COLLISION;

    assign COLLISION = CURR_X == 0 || 
                       CURR_X == 1 || 
                       CURR_X == CANVAS_SIZE - 1 || 
                       CURR_X == CANVAS_SIZE - 2 || 
                       CURR_Y == 0 || 
                       CURR_Y == 1 ||
                       CURR_Y == CANVAS_SIZE - 1 ||
                       CURR_Y == CANVAS_SIZE - 2;

    assign CURR_POS = CURR_X + CANVAS_SIZE*CURR_Y;

    always @(posedge GAME_CLOCK) begin
        if (PATH_CARRY || COLLISION) begin
            RAND_DIR <= (RAND_FOR_DIR >> 28);
            RAND_COLOR <= (RAND_FOR_COLOR >> 30);
        end
    end

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

    integer i;
    always @(posedge GAME_CLOCK) begin
        // Background paint
        for (i = 0; i < 4096; i = i + 1) begin
            reds[i] = 4'h1;
            blues[i] = 4'h1;
            greens[i] = 4'h1;
        end

        // Paint target
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