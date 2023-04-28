module round_tb;

    reg [10:0] mag;
    wire [2:0]  exp_in, exp_out;
    wire [3:0] out;

    exp extract_exp(mag, exp_in);
    round uut(mag, exp_in, out, exp_out);

    initial begin
        mag <= 'b11110000000;
        #10;
        mag <= 'b11101000000;
        #10;
        mag <= 'b11111000000;
        #10;
        mag <= 'b01110100000;
        #10;
        mag <= 'b11111111111;
    end

endmodule