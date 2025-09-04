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
    x2k,
    x2k_1,
// input signals
    y2k,
    y2k_1
);

output reg clk, rst_n;
output reg signed [15:0] x2k, x2k_1;
input signed [15:0] y2k,y2k_1;

parameter DATA_NUM = 65536;
integer mem_txt,data0,data1,patcount;
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
    for(patcount = 0;patcount < 32768;patcount = patcount + 1) begin
	  xk = data_in[patcount];
        x2k = data_in[2*patcount];
        x2k_1 = data_in[(2*patcount)+1];
        data_out[2*patcount] = y2k;
        data_out[(2*patcount)+1] = y2k_1;
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
    #10;if((y2k != 'b0) || (y2k_1 != 'b0)) begin
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
