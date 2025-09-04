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
    x8k,
    x8k_1,
    x8k_2,
    x8k_3,
    x8k_4,
    x8k_5,
    x8k_6,
    x8k_7,
// input signals
    y8k,
    y8k_1,
    y8k_2,
    y8k_3,
    y8k_4,
    y8k_5,
    y8k_6,
    y8k_7		
);

output reg clk, rst_n;
output reg signed [15:0] x8k, x8k_1, x8k_2,x8k_3,x8k_4,x8k_5,x8k_6,x8k_7;
input signed [15:0] y8k,y8k_1, y8k_2,y8k_3,y8k_4,y8k_5,y8k_6,y8k_7;

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
    for(patcount = 0;patcount < 8192;patcount = patcount + 1) begin
        x8k = data_in[8*patcount];
        x8k_1 = data_in[(8*patcount)+1];
        x8k_2 = data_in[(8*patcount)+2];
        x8k_3 = data_in[(8*patcount)+3];
        x8k_4 = data_in[(8*patcount)+4];
        x8k_5 = data_in[(8*patcount)+5];
        x8k_6 = data_in[(8*patcount)+6];
        x8k_7 = data_in[(8*patcount)+7];
        data_out[8*patcount] = y8k;
        data_out[(8*patcount)+1] = y8k_1;
        data_out[(8*patcount)+2] = y8k_2;
        data_out[(8*patcount)+3] = y8k_3;
        data_out[(8*patcount)+4] = y8k_4;
        data_out[(8*patcount)+5] = y8k_5;
        data_out[(8*patcount)+6] = y8k_6;
        data_out[(8*patcount)+7] = y8k_7;
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
    #10;if((y8k != 'b0) || (y8k_1 != 'b0) || (y8k_2 != 'b0) || (y8k_3 != 'b0) || (y8k_4 != 'b0) || (y8k_5 != 'b0) || (y8k_6 != 'b0) || (y8k_7 != 'b0)) begin
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
