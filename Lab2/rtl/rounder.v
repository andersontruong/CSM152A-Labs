module rounder(i_mag_temp, i_exp, o_significand, o_exp);

    input wire [10:0] i_mag_temp;
    input wire [2:0]  i_exp;
    output reg [3:0] o_significand;
    output reg [2:0] o_exp;

    reg [4:0] temp;

    genvar i;
    generate
        for (i = 1; i <= 7; i = i + 1) begin
            always @(*) begin
                if (i_exp == i)
                    temp <= i_mag_temp[(3+i):i - 1];
                    // temp <= 3 + i;
            end
        end
    endgenerate

    // If round, then if all 1s => 1000, else add 1
    // Else just keep upper 4 bits
    always @(*) begin
        // If exp = 0
        if (!i_exp) begin
            o_significand <= i_mag_temp[3:0];
        end
        else begin
            // If 5th bit => round
            if (temp[0]) begin
                // If sig is all 1s
                if (&temp[4:1]) begin
                    // If exp already maxed
                    if (&i_exp) begin
                        o_significand <= 'b1111;
                    end
                    // Still have space in exp
                    else begin
                        o_significand <= 'b1000;
                    end
                end
                // Do normal rounding
                else begin
                    o_significand <= temp[4:1] + 1;
                end
            end
            // No round => keep upper 4 bits
            else begin
                o_significand <= temp[4:1];
            end
        end
    end
    always @(*) begin
        // If upper bits are all 1
        if (&temp) begin
            // If exp bits all 1
            if (&i_exp) begin
                o_exp <= i_exp;
            end
            // We can increase exp without overflow
            else begin
                o_exp <= i_exp + 1;
            end
        end
        // Handle normal
        else begin
            o_exp <= i_exp;
        end
    end
    // assign o_significand = !i_exp ? i_mag_temp[3:0] : (temp[0] ? (&temp[4:1] ? 'b1000 : temp[4:1] + 1) : temp[4:1]);
    // assign o_exp = &temp[4:1] ? (&i_exp ? i_exp : i_exp + 1) : i_exp;

endmodule