`include "fir_tb.v"
`ifdef RTL
`include "fir8_FFA.v"
//`include "fir8_proposed.v"
`elsif GATE
`include "fir_SYN.v"
`endif

module TESTBED();

wire clk;
wire rst_n;
wire signed [15:0] x8k,x8k_1,x8k_2,x8k_3,x8k_4,x8k_5,x8k_6,x8k_7;
wire signed [15:0] y8k,y8k_1,y8k_2,y8k_3,y8k_4,y8k_5,y8k_6,y8k_7;

fir U_FIR(
	.clk(clk),
    .rst_n(rst_n),
    .x8k(x8k),
    .x8k_1(x8k_1), 
     .x8k_2(x8k_2),
     .x8k_3(x8k_3),
     .x8k_4(x8k_4),
     .x8k_5(x8k_5),
     .x8k_6(x8k_6),
     .x8k_7(x8k_7),
    .y8k(y8k),
	.y8k_1(y8k_1),
	.y8k_2(y8k_2),
	.y8k_3(y8k_3),
	.y8k_4(y8k_4),
	.y8k_5(y8k_5),
	.y8k_6(y8k_6),
	.y8k_7(y8k_7)
);

PATTERN U_PATTERN(
.clk(clk),
    .rst_n(rst_n),
    .x8k(x8k),
    .x8k_1(x8k_1), 
     .x8k_2(x8k_2),
     .x8k_3(x8k_3),
     .x8k_4(x8k_4),
     .x8k_5(x8k_5),
     .x8k_6(x8k_6),
     .x8k_7(x8k_7),
    .y8k(y8k),
	.y8k_1(y8k_1),
	.y8k_2(y8k_2),
	.y8k_3(y8k_3),
	.y8k_4(y8k_4),
	.y8k_5(y8k_5),
	.y8k_6(y8k_6),
	.y8k_7(y8k_7)
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


