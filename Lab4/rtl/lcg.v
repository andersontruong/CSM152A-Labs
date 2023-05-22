module lcg #(parameter N=32, a=1103515245, c=12345, seed=1) (
        input clk,
        output reg [N-1:0] rand
    );

    assign rand = seed;

    reg [N-1:0] next_rand;

    always @(*) begin
        next_rand = (a * rand + c) % (2**N);
    end

    always @(posedge clk) begin
        rand <= next_rand;
    end
endmodule