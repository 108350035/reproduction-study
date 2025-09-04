`include "fir_tb.v"
`ifdef RTL
`include "fir3_FFA.v"
//`include "fir3_proposed.v"
`elsif GATE
`include "fir_SYN.v"
`endif

module TESTBED();

wire clk;
wire rst_n;
wire signed [15:0] x3k,x3k_1,x3k_2;
wire signed [15:0] y3k,y3k_1,y3k_2;

fir U_FIR(
	.clk(clk),
    .rst_n(rst_n),
    .x3k(x3k),
    .x3k_1(x3k_1), 
     .x3k_2(x3k_2),
    .y3k(y3k),
	.y3k_1(y3k_1),
	.y3k_2(y3k_2)
);

PATTERN U_PATTERN(
	.clk(clk),
    .rst_n(rst_n),
    .x3k(x3k),
    .x3k_1(x3k_1), 
     .x3k_2(x3k_2),
    .y3k(y3k),
	.y3k_1(y3k_1),
	.y3k_2(y3k_2)
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


