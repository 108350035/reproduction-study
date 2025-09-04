`include "fir_tb.v"
`ifdef RTL
//`include "fir2_FFA.v"
`include "fir2_proposed.v"
`elsif GATE
`include "fir_SYN.v"
`endif



module TESTBED();

wire clk;
wire rst_n;
wire signed [15:0] x2k,x2k_1;
wire signed [15:0] y2k,y2k_1;

fir U_FIR(
	.clk(clk),
    .rst_n(rst_n),
    .x2k(x2k),
    .x2k_1(x2k_1), 
    .y2k(y2k),
	.y2k_1(y2k_1)
);

PATTERN U_PATTERN(
	.clk(clk),
    .rst_n(rst_n),
    .x2k(x2k),
    .x2k_1(x2k_1), 
    .y2k(y2k),
	.y2k_1(y2k_1)
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




