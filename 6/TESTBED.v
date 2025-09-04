`include "fir_tb.v"
`ifdef RTL
`include "fir6_FFA.v"
//`include "fir6_proposed.v"
`elsif GATE
`include "fir_SYN.v"
`endif

module TESTBED();

wire clk;
wire rst_n;
wire signed [15:0] x6k,x6k_1,x6k_2,x6k_3,x6k_4,x6k_5;
wire signed [15:0] y6k,y6k_1,y6k_2,y6k_3,y6k_4,y6k_5;

fir U_FIR(
	.clk(clk),
    .rst_n(rst_n),
    .x6k(x6k),
    .x6k_1(x6k_1), 
     .x6k_2(x6k_2),
     .x6k_3(x6k_3),
     .x6k_4(x6k_4),
     .x6k_5(x6k_5),
    .y6k(y6k),
	.y6k_1(y6k_1),
	.y6k_2(y6k_2),
	.y6k_3(y6k_3),
	.y6k_4(y6k_4),
	.y6k_5(y6k_5)
);

PATTERN U_PATTERN(
.clk(clk),
    .rst_n(rst_n),
    .x6k(x6k),
    .x6k_1(x6k_1), 
     .x6k_2(x6k_2),
     .x6k_3(x6k_3),
     .x6k_4(x6k_4),
     .x6k_5(x6k_5),
    .y6k(y6k),
	.y6k_1(y6k_1),
	.y6k_2(y6k_2),
	.y6k_3(y6k_3),
	.y6k_4(y6k_4),
	.y6k_5(y6k_5)
);

initial begin
	`ifdef RTL
		$fsdbDumpfile("fir.fsdb");
		$fsdbDumpvars(0,"+mda");
		$fsdbDumpvars();
	`elsif GATE
		$sdf_annotate("fir_SYN.sdf",U_FIR);
		$fsdbDumpfile("fir_SYN.fsdb");
		$fsdbDumpvars();

	`endif
end

endmodule


