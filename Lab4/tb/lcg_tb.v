module lcg_tb;
    reg clk, rand;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    lcg lcg_inst (
        .clk(clk),
        .rand(rand)
    );

    always @(posedge clk) begin
        $display("rand = %d", rand);
    end
endmodule