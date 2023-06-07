module game
#(
    parameter integer PIXELS = 64
)
(
    input CLK100MHZ,
    input reset,
    input [3:0] btn_no,
    input [1:0] X_DIR,
    input [1:0] Y_DIR,
    input [15:0] sw,
    output reg [3:0] reds [PIXELS - 1:0],
    output reg [3:0] blues [PIXELS - 1:0],
    output reg [3:0] greens [PIXELS - 1:0],
    output reg [13:0] score
);
    localparam integer POS_SIZE = $clog2(PIXELS);
    localparam integer CANVAS_SIZE = $sqrt(PIXELS);
    localparam integer VEC_SIZE = $clog2(CANVAS_SIZE);

    logic [3:0] btn;

    debounce db0 (
        CLK100MHZ,
        rst,
        btn_no[0],
        btn[0]
    );

    debounce db1 (
        CLK100MHZ,
        rst,
        btn_no[1],
        btn[1]
    );

    debounce db2 (
        CLK100MHZ,
        rst,
        btn_no[2],
        btn[2]
    );

    debounce db3 (
        CLK100MHZ,
        rst,
        btn_no[3],
        btn[3]
    );

    // Game clock
    logic GAME_CLOCK, PLAYER_CLOCK;
    logic [26:0] target_speed, player_speed;

    assign target_speed = score < 50 ? 25_000_000 - 500_000*score : 500_000;
    assign player_speed = score < 50 ? 2_500_000 - 50_000*score : 50_000;

    playerdivider game_clock_gen(.i_clk(CLK100MHZ), .i_rst(0), .i_DIV(target_speed), .o_clk(GAME_CLOCK));
    playerdivider player_clock_gen(.i_clk(CLK100MHZ), .i_rst(0), .i_DIV(player_speed), .o_clk(PLAYER_CLOCK));

    // Array positions and position vectors
    logic [POS_SIZE - 1:0] CURR_POS;
    logic [VEC_SIZE - 1:0] CURR_X, CURR_Y;

    // Random quantities
    logic [31:0] RAND_FOR_COLOR, RAND_FOR_DIR;
    logic [2:0] RAND_DIR;
    logic [1:0] RAND_COLOR;

    // RNGs
    lcg rng1(.clk(GAME_CLOCK), .rst(reset), .o_rand(RAND_FOR_COLOR), .seed(sw));
    lcg rng2(.clk(GAME_CLOCK), .rst(reset), .o_rand(RAND_FOR_DIR), .seed(sw));

    // Target switch clock
    logic PATH_CARRY;
    counter #(.N(4)) path_divider(.i_clk(GAME_CLOCK), .i_en(1), .i_rst(reset), .o_count(), .o_carry(PATH_CARRY), .max(0));

    // player position
    logic [POS_SIZE - 1:0] PLAYER_POS;

    assign CURR_POS = CURR_X + CANVAS_SIZE*CURR_Y;

    always @(posedge PLAYER_CLOCK) begin
        PLAYER_POS <= PLAYER_POS + (X_DIR - 1) + CANVAS_SIZE*(Y_DIR - 1);
    end

    always @(posedge GAME_CLOCK) begin
        if (PATH_CARRY | reset) begin
            RAND_DIR <= (RAND_FOR_DIR >> 29);
            RAND_COLOR <= (RAND_FOR_COLOR >> 30);
        end
    end

    localparam integer MOVE_STEP = 1;

    always @(posedge GAME_CLOCK) begin
        if (reset || move) begin
            move <= 0;
            CURR_X <= 0;
            CURR_Y <= 0;
        end
        else begin
        case (RAND_DIR)
            0: begin
                CURR_X <= CURR_X;
                CURR_Y <= CURR_Y + MOVE_STEP;
            end
            1: begin
                CURR_X <= CURR_X + MOVE_STEP;
                CURR_Y <= CURR_Y + MOVE_STEP;
            end
            2: begin
                CURR_X <= CURR_X + MOVE_STEP;
                CURR_Y <= CURR_Y;
            end
            3: begin
                CURR_X <= CURR_X + MOVE_STEP;
                CURR_Y <= CURR_Y - MOVE_STEP;
            end
            4: begin
                CURR_X <= CURR_X;
                CURR_Y <= CURR_Y - MOVE_STEP;
            end
            5:  begin
                CURR_X <= CURR_X - MOVE_STEP;
                CURR_Y <= CURR_Y - MOVE_STEP;
            end
            6: begin
                CURR_X <= CURR_X - MOVE_STEP;
                CURR_Y <= CURR_Y;
            end
            7: begin
                CURR_X <= CURR_X - MOVE_STEP;
                CURR_Y <= CURR_Y + MOVE_STEP;
            end
        endcase
        end
    end

    logic move;
    logic score_changed;

    always @(posedge PLAYER_CLOCK) begin 
        if (reset) begin
            score <= 0;
        end
        else if (~score_changed) begin
            if (btn[RAND_COLOR]) begin
                if(PLAYER_POS % CANVAS_SIZE <= CURR_X + 2 && PLAYER_POS % CANVAS_SIZE >= CURR_X - 2 && PLAYER_POS / CANVAS_SIZE <= CURR_Y + 2 && PLAYER_POS / CANVAS_SIZE >= CURR_Y - 2) begin
                    score <= score + 1;
                    move <= 1;
                    score_changed <= 1;
                end
                else if (score > 0) begin
                    score <= score - 1;
                    score_changed <= 1;
                end
            end
            else if (|btn && score > 0) begin
                score <= score - 1;
                score_changed <= 1;
            end
        end
        else begin
            score_changed <= 0;
        end
    end

    integer i;
    always @(posedge PLAYER_CLOCK) begin
        // Background paint
        for (i = 0; i < 4096; i = i + 1) begin
            reds[i] = 4'h1;
            blues[i] = 4'h1;
            greens[i] = 4'h1;
        end

        // Paint target
        case (RAND_COLOR)
            0: begin // RED UP
                reds[CURR_POS] <= 4'hf;
                blues[CURR_POS] <= 4'h0;
                greens[CURR_POS] <= 4'h0;
            end
            1: begin // GREEN LEFT
                reds[CURR_POS] <= 4'h0;
                blues[CURR_POS] <= 4'h0;
                greens[CURR_POS] <= 4'hf;
            end
            2: begin // BLUE RIGHT
                reds[CURR_POS] <= 4'h0;
                blues[CURR_POS] <= 4'hf;
                greens[CURR_POS] <= 4'h0;
            end
            3: begin // YELLOW DOWN
                reds[CURR_POS] <= 4'hf;
                blues[CURR_POS] <= 4'h0;
                greens[CURR_POS] <= 4'hf;
            end
        endcase

        // player position
        reds[PLAYER_POS] <= 4'hf;
        blues[PLAYER_POS] <= 4'hf;
        greens[PLAYER_POS] <= 4'hf;
    end

endmodule