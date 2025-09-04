`include "fir_tb.v"
`ifdef RTL
`include "fir4_FFA.v"
//`include "fir4_proposed.v"
`elsif GATE
`include "fir_SYN.v"
`endif

module TESTBED();

wire clk;
wire rst_n;
wire signed [15:0] x4k,x4k_1,x4k_2,x4k_3;
wire signed [15:0] y4k,y4k_1,y4k_2,y4k_3;

fir U_FIR(
	.clk(clk),
    .rst_n(rst_n),
    .x4k(x4k),
    .x4k_1(x4k_1), 
     .x4k_2(x4k_2),
     .x4k_3(x4k_3),
    .y4k(y4k),
	.y4k_1(y4k_1),
	.y4k_2(y4k_2),
	.y4k_3(y4k_3)
);

PATTERN U_PATTERN(
.clk(clk),
    .rst_n(rst_n),
    .x4k(x4k),
    .x4k_1(x4k_1), 
     .x4k_2(x4k_2),
     .x4k_3(x4k_3),
    .y4k(y4k),
	.y4k_1(y4k_1),
	.y4k_2(y4k_2),
	.y4k_3(y4k_3)
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


