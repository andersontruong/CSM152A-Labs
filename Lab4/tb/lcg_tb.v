module lcg_tb;
    reg clk, rst;
    wire [31:0] rand;
    reg [15:0] seed;

    initial begin
        clk = 0;
        seed = 0;
        rst = 1;
        #10;
        rst = 0;
    end
    
   always begin
        #5 clk = ~clk;
   end
    
    lcg lcg_inst (
        .clk(clk),
        .rst(rst),
        .seed(seed),
        .o_rand(rand)
    );

    always @(posedge clk) begin
        $display("rand = %d", rand);
    end
endmodule