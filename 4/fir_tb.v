`ifdef RTL
	`define CYCLE_TIME 20
`endif
`ifdef GATE
	`define CYCLE_TIME 20
`endif
`timescale 1ns/10ps

module PATTERN(
// output signals
    clk,
    rst_n,
    x4k,
    x4k_1,
    x4k_2,
    x4k_3,
// input signals
    y4k,
    y4k_1,
    y4k_2,
    y4k_3
);

output reg clk, rst_n;
output reg signed [15:0] x4k, x4k_1, x4k_2,x4k_3;
input signed [15:0] y4k,y4k_1, y4k_2,y4k_3;

parameter DATA_NUM = 65536;
integer mem_txt,patcount;
reg signed [15:0] xk,yk;
reg signed [15:0] data_in [0:DATA_NUM-1];
reg signed [15:0] data_out [0:DATA_NUM-1];
//==============CLK==============
initial clk = 0;
always #(`CYCLE_TIME/2) clk=~clk;
//===============================



initial begin
    $readmemb("mem.txt", data_in) ;
    rst_n = 1'b1;
    force clk = 0;
    reset_task;
    for(patcount = 0;patcount < 21845;patcount = patcount + 1) begin
        x4k = data_in[4*patcount];
        x4k_1 = data_in[(4*patcount)+1];
        x4k_2 = data_in[(4*patcount)+2];
        x4k_3 = data_in[(4*patcount)+3];
        data_out[4*patcount] = y4k;
        data_out[(4*patcount)+1] = y4k_1;
        data_out[(4*patcount)+2] = y4k_2;
        data_out[(4*patcount)+3] = y4k_3;
        @(negedge clk);
    end
    for(patcount = 0;patcount < DATA_NUM;patcount = patcount + 1) begin
	    xk = data_in[patcount];
	    yk = data_out[patcount];
        @(negedge clk);
    end
    @(negedge clk);
    $finish;
end

task reset_task;
begin
    #10; rst_n = 1'b0;
    #10;if((y4k != 'b0) || (y4k_1 != 'b0) || (y4k_2 != 'b0) || (y4k_3 != 'b0)) begin
        $display ("------------------------------------------------------------------------------------------------------------------------");
		$display ("                          All output signals should be reset after the reset signal is asserted.                        ");
		$display ("------------------------------------------------------------------------------------------------------------------------");
    repeat(2) @(negedge clk);
    $finish;
    end
    #10; rst_n = 1'b1;
    #(3.0) release clk;
end
endtask

endmodule
