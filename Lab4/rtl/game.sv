module game(
    input CLK100MHZ,
    output reg [3:0] reds [63:0],
    output reg [3:0] blues [63:0],
    output reg [3:0] greens [63:0]
);
    wire GAME_CLOCK;

    divider #(.DIV(50_000_000)) game_clock_gen(.i_clk(CLK100MHZ), .i_rst(reset), .o_clk(GAME_CLOCK));

    wire [31:0] RAND;
    wire [5:0] NEXT_POS;
    wire [3:0] RAND_COLOR;

    wire [5:0] CURR_POS;

    lcg rng(.clk(GAME_CLOCK), .o_rand(RAND));

    assign NEXT_POS = RAND % (2 << 6);
    assign RAND_COLOR = (RAND >> 30) % 4;

    always @(posedge GAME_CLOCK) begin
        CURR_POS <= NEXT_POS;
    end

    integer i;
    always @(posedge GAME_CLOCK) begin
        for (i = 0; i < 64; i = i + 1) begin
            reds[i] <= 4'h0;
            blues[i] <= 4'h0;
            greens[i] <= 4'h0;
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