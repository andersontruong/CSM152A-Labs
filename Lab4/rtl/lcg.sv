module lcg #(parameter N=32, a=1103515245, c=12345) (
        input clk,
        input rst,
        input [15:0] seed,
        output logic [N-1:0] o_rand
    );

    reg [N-1:0] next_o_rand;

    always @(*) begin
        next_o_rand = a * o_rand + c;
    end

    always @(posedge clk) begin
        if (rst)
            o_rand <= {seed, seed};
        else
            o_rand <= next_o_rand;
    end
endmodule