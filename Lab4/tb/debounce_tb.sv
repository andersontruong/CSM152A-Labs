module debounce_tb;

    parameter MAX_BOUNCE = 4;

    reg clk, rst, btn;
    wire result;

    task setup_task;
        begin
            clk <= 1'b0;
            rst <= 1'b1;
            btn <= 1'b0;
            #1;
            rst <= 1'b0;
            #1;
        end
    endtask

    task bounce_task;
        input int n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1) begin
                btn <= 1'b1;
                #1;
            end
            btn <= 1'b0;
            #1;
        end
    endtask

    task bounce_all_task;
        integer i;
        begin
            for (i = 1; i <= MAX_BOUNCE + 1; i = i + 1) begin
                bounce_task(i);
            end
        end
    endtask

    debounce #(.N($clog2(MAX_BOUNCE))) uut(clk, rst, btn, result);

    always begin
        #0.5 clk <= ~clk;
    end

    initial begin
        setup_task();
        bounce_all_task();
    end

endmodule