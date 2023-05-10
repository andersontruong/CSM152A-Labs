module fourdigitdriver
#(
    parameter REFRESH_DIV=1_000_000
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

    divider #(.DIV(REFRESH_DIV)) clk_div(i_clk, i_rst, display_clk);

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
                selected_digit <= 4'b1;
                dig_sel <= 4'b1;
            end
        endcase
    end

    always @(*) begin
        case (selected_digit)
            0: seg <= 8'b11000000;
            1: seg <= 8'b11111001;
            2: seg <= 8'b10100100;
            3: seg <= 8'b10110000;
            4: seg <= 8'b10011001;
            5: seg <= 8'b10010010;
            6: seg <= 8'b10000010;
            7: seg <= 8'b11111000;
            8: seg <= 8'b10000000;
            9: seg <= 8'b10010000;
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