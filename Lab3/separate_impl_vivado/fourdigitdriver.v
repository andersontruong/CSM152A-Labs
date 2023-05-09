module fourdigitdriver
#(
    parameter BASE_CLK=100_000_000,
    parameter REFRESH_RATE=1
)
(
    i_clk,
    i_rst,
    dig1,
    dig2,
    dig3,
    dig4,
    seg,
    dig_sel
);
    input i_clk, i_rst;
    input [3:0] dig1, dig2, dig3, dig4;

    output reg [7:0] seg;
    output reg [3:0] dig_sel;

    wire display_clk;
    reg [3:0] selected_digit;

    reg [1:0] dig_state;

    divider #(.BASE_CLK(BASE_CLK), .TARGET_CLK(REFRESH_RATE)) clk_div(i_clk, i_rst, display_clk);

    always @(*) begin
        case (dig_state)
            0: begin
                selected_digit <= dig1;
                dig_sel <= 4'b1110;
            end
            1: begin
                selected_digit <= dig2;
                dig_sel <= 4'b1101;
            end
            2: begin
                selected_digit <= dig3;
                dig_sel <= 4'b1011;
            end
            3: begin
                selected_digit <= dig4;
                dig_sel <= 4'b0111;
            end
            default: begin
                selected_digit <= 4'b0;
                dig_sel <= 4'b0;
            end
        endcase
    end

    always @(*) begin
        case (selected_digit)
            0: seg <= 8'b00111111;
            1: seg <= 8'b00000110;
            2: seg <= 8'b01011011;
            3: seg <= 8'b01001111;
            4: seg <= 8'b01100110;
            5: seg <= 8'b01101101;
            6: seg <= 8'b01111101;
            7: seg <= 8'b00000111;
            8: seg <= 8'b01111111;
            9: seg <= 8'b01101111;
            default:  seg <= 8'b00000000;
        endcase
    end

    always @(posedge display_clk) begin
        if (i_rst)
            dig_state <= 1'b0;
        else 
            dig_state <= dig_state + 1'b1;
    end

endmodule