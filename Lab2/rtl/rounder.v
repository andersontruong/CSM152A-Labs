module rounder(i_mag_temp, i_exp, o_significand, o_exp);

    input wire [10:0] i_mag_temp;
    input wire [2:0]  i_exp;
    output wire [3:0] o_significand;
    output wire [2:0] o_exp;

    reg [4:0] temp;

    integer i;
    always @(*) begin
        for (i = 0; i <= 7; i = i + 1) begin
            if (i_exp == i)
                temp <= i_mag_temp[(10-0)-:5];
        end
    end

    // "All it takes is faith, trust, and pixie dust." - Peter Pan
     assign o_significand = (temp[0] & ~&temp[4:1]) ? temp[4:1] + 1 : temp[4:1];
    assign o_significand = temp[0] ? (&temp[4:1] ? temp[4:1] : temp[4:1] + 1) : temp[4:1];
    assign o_exp = &temp[4:1] ? (&i_exp ? i_exp : i_exp + 1) : i_exp;

endmodule