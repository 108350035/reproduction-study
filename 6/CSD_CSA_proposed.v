// H3 0~3 H2+H3 4~5 H2-H3 6~7 H1+H3 8~11 H1-H3 12~15 H1+H5 16~19 0.5*(H1-H5) 20~23 H1+H3+H5 24~27 0.5*(H0+H1+H2+H3) 28~31 
// 0.5*(H0+H1-H2-H3) 32~35 0.5*(H0+H1+H4+H5) 36~37 0.5*(H0+H1-H4-H5) 38~39 0.5*(H0+H2-H1-H3) 40~43
// 0.5*(H0+H3-H1-H2) 44~47 0.5*(H0+H4-H1-H5) 48~49 0.5*(H0+H5-H1-H4) 50~51
// H0+..+H5 52~53 H0+H2+H4-H1-H3-H5 54~55
module CSD_CSA0(
    input  [15:0] x,
    output  [31:0] y
);

wire  [24:0] x_ext = {{9{x[15]}}, x};
wire  [24:0] term1 = x_ext << 9;
wire  [24:0] term2 = -(x_ext << 7);
wire  [24:0] term3 = -(x_ext << 4);  
wire  [24:0] term4 = -x_ext;     

wire [24:0] s1, c1;
CSA #(25) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

wire [25:0] s1_ext = {s1[24], s1};
wire [25:0] c1_ext = {c1, 1'b0};
wire [25:0] term4_ext = {term4[24], term4};

wire [25:0] s2, c2,sum;
CSA #(26) CSA_2(
    .a(s1_ext),
    .b(c1_ext),
    .c(term4_ext),
    .sum(s2),
    .carry(c2)
);
assign sum = s2 + (c2 << 1);
assign y = {{6{sum[25]}},sum};

endmodule

module CSD_CSA1(
input  [15:0] x,
output  [31:0] y);

wire  [29:0] x_ext = {{14{x[15]}}, x};
wire  [29:0] term1 = -(x_ext << 13); 
wire  [29:0] term2 = x_ext << 11;   
wire  [29:0] term3 = x_ext << 9;
wire  [29:0] term4 = x_ext << 6;  
wire  [29:0] term5 = x_ext << 4;  
wire  [29:0] term6 = x_ext << 2;  

wire [29:0] s1,c1,s2,c2;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(30) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [30:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[29],s2};
wire [30:0] s3,c3;
CSA #(31) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [31:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[30],s3};
assign c2_ext = {c2[29],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [31:0] s4,c4;
CSA #(32) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA2(
input  [15:0] x,
output  [31:0] y);

wire  [28:0] x_ext = {{13{x[15]}}, x};
wire  [28:0] term1 = -(x_ext << 12); 
wire  [28:0] term2 = -(x_ext << 10);   
wire  [28:0] term3 = -(x_ext << 8);
wire  [28:0] term4 = -(x_ext << 5);  
wire  [28:0] term5 = -(x_ext << 3);  
wire  [28:0] term6 = x_ext;  

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4,sum;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {sum[30],sum};
endmodule

module CSD_CSA3(
    input  [15:0] x,
    output  [31:0] y
);

wire  [27:0] x_ext = {{12{x[15]}}, x};
wire  [27:0] term1 = x_ext << 10; 
wire  [27:0] term2 = x_ext << 8;   
wire  [27:0] term3 =  -(x_ext << 6);   
wire  [27:0] term4 =  x_ext << 2;
wire  [27:0] term5 =  x_ext;

wire [27:0] s1,c1,s2,c2;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(28) CSA_2(.a(term4) ,.b(term5) ,.c(28'b0) ,.sum(s2) ,.carry(c2));

wire [28:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[27],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[27],s2};
wire [28:0] s3,c3;
CSA #(29) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [29:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[28],s3};
assign c2_ext = {c2[27],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [29:0] s4,c4,sum;
CSA #(30) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {{2{sum[29]}},sum};
endmodule

module CSD_CSA4(
    input  [15:0] x,
    output  [30:0] y
);

wire  [28:0] x_ext = {{13{x[15]}}, x};
wire  [28:0] term1 = x_ext << 11; 
wire  [28:0] term2 = -(x_ext << 9);   
wire  [28:0] term3 = x_ext << 6;
wire  [28:0] term4 = -(x_ext << 4);  
wire  [28:0] term5 = x_ext << 2;  
wire  [28:0] term6 = -x_ext;  

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA5(
input  [15:0] x,
output  [30:0] y);

wire  [31:0] x_ext = {{16{x[15]}}, x};
wire  [31:0] term1 = -(x_ext << 14); 
wire  [31:0] term2 = x_ext << 12; 
wire  [31:0] term3 = x_ext << 10;   
wire  [31:0] term4 = x_ext << 8;
wire  [31:0] term5 = x_ext << 6;  
wire  [31:0] term6 = -(x_ext << 4); 
wire  [31:0] term7 = -(x_ext << 2);
wire  [31:0] term8 = x_ext;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext,c2_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
assign c2_ext = {c2,1'b0};
wire [32:0] s3,c3,s4,c4;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));
CSA #(33) CSA_4(.a({term7[31],term7}) ,.b({term8[31],term8}) ,.c(c2_ext) ,.sum(s4) ,.carry(c4));

wire [33:0] s3_ext,c3_ext,c4_ext;
assign s3_ext = {s3[32],s3};
assign c3_ext = {c3,1'b0};
assign c4_ext = {c4,1'b0};
wire [33:0] s5,c5;
CSA #(34) CSA_5(.a(s3_ext) ,.b(c3_ext) ,.c(c4_ext) ,.sum(s5) ,.carry(c5));

wire [34:0] s5_ext,c5_ext,s4_ext;
assign s5_ext = {s5[33],s5};
assign c5_ext = {c5,1'b0};
assign s4_ext = {{2{s4[32]}},s4};
wire [34:0] s6,c6;
CSA #(35) CSA_6(.a(s4_ext) ,.b(c5_ext) ,.c(s5_ext) ,.sum(s6) ,.carry(c6));

assign y = s6 + (c6 << 1);
endmodule

module CSD_CSA6(
input [15:0] x,
output [30:0] y);

wire [28:0] x_ext = {{13{x[15]}}, x};
wire [28:0] term1 = -(x_ext << 10);
wire [28:0] term2 = x_ext << 7;
wire [28:0] term3 = x_ext << 5;
wire [28:0] term4 = x_ext << 3;
wire [28:0] term5 = x_ext << 1;

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(29'b0) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,c1_ext,s2_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA7(
input [15:0] x,
output [30:0] y);

wire [26:0] x_ext = {{11{x[15]}}, x};
wire [26:0] term1 = -(x_ext << 7);
wire [26:0] term2 = -(x_ext << 3);
wire [26:0] term3 = x_ext << 1;

wire [26:0] s1,c1,sum;
CSA #(27) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{4{sum[26]}},sum};
endmodule

module CSD_CSA8(
    input  [15:0] x,
    output  [30:0] y
);

wire  [25:0] x_ext = {{10{x[15]}}, x};
wire  [25:0] term1 = x_ext << 8;
wire  [25:0] term2 = -(x_ext << 5);
wire  [25:0] term3 = -(x_ext << 2);  
wire  [25:0] term4 = x_ext;     

wire [25:0] s1, c1;
CSA #(26) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

wire [26:0] s1_ext = {s1[25], s1};
wire [26:0] c1_ext = {c1, 1'b0};
wire [26:0] term4_ext = {term4[25], term4};

wire [26:0] s2, c2,sum;
CSA #(27) CSA_2(
    .a(s1_ext),
    .b(c1_ext),
    .c(term4_ext),
    .sum(s2),
    .carry(c2)
);
assign sum = s2 + (c2 << 1);
assign y = {{4{sum[26]}},sum};
endmodule

module CSD_CSA9(
    input  [15:0] x,
    output  [30:0] y
);

wire  [28:0] x_ext = {{13{x[15]}}, x};
wire  [28:0] term1 = -(x_ext << 12); 
wire  [28:0] term2 = x_ext << 10;   
wire  [28:0] term3 = -(x_ext << 8);
wire  [28:0] term4 = x_ext << 5;  
wire  [28:0] term5 = -(x_ext << 3);  
wire  [28:0] term6 = -(x_ext << 1);  

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA10(
    input  [15:0] x,
    output  [30:0] y
);
wire  [28:0] x_ext = {{13{x[15]}}, x};
wire  [28:0] term1 = x_ext << 13; 
wire  [28:0] term2 = -(x_ext << 10);   
wire  [28:0] term3 = -(x_ext << 7);
wire  [28:0] term4 = x_ext << 5;  
wire  [28:0] term5 = x_ext << 2;  
wire  [28:0] term6 = x_ext;  

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA11(
    input  [15:0] x,
    output  [30:0] y
);

wire  [26:0] x_ext = {{11{x[15]}}, x};
wire  [26:0] term1 = -(x_ext << 10);
wire  [26:0] term2 = x_ext << 8;
wire  [26:0] term3 = x_ext << 5;  
wire  [26:0] term4 = -(x_ext << 2);     

wire [26:0] s1, c1;
CSA #(27) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

wire [27:0] s1_ext = {s1[26], s1};
wire [27:0] c1_ext = {c1, 1'b0};
wire [27:0] term4_ext = {term4[26], term4};

wire [27:0] s2, c2,sum;
CSA #(28) CSA_2(
    .a(s1_ext),
    .b(c1_ext),
    .c(term4_ext),
    .sum(s2),
    .carry(c2)
);
assign sum = s2 + (c2 << 1);
assign y = {{3{sum[27]}},sum};
endmodule

module CSD_CSA12(
input [15:0] x,
output [30:0] y);

wire [26:0] x_ext = {{11{x[15]}}, x};
wire [26:0] term1 = -(x_ext << 9);
assign y = {{4{term1[26]}},term1};
endmodule

module CSD_CSA13(
input [15:0] x,
output [30:0] y);

wire [28:0] x_ext = {{13{x[15]}}, x};
wire [28:0] term1 = x_ext << 13;
wire [28:0] term2 = -(x_ext << 9);
wire [28:0] term3 = x_ext << 7;
wire [28:0] term4 = -(x_ext << 4);
wire [28:0] term5 = -(x_ext << 1);

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(29'b0) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,c1_ext,s2_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA14(
input [15:0] x,
output [30:0] y);

wire [29:0] x_ext = {{14{x[15]}}, x};
wire [29:0] term1 = x_ext << 14;
wire [29:0] term2 = x_ext << 11;
wire [29:0] term3 = -(x_ext << 9);
wire [29:0] term4 = -(x_ext << 4);
wire [29:0] term5 = x_ext << 1;

wire [29:0] s1,c1,s2,c2;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(30) CSA_2(.a(term4) ,.b(term5) ,.c(30'b0) ,.sum(s2) ,.carry(c2));

wire [30:0] s1_ext,c1_ext,s2_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[29],s2};
wire [30:0] s3,c3;
CSA #(31) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [31:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[30],s3};
assign c2_ext = {c2[29],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [31:0] s4,c4;
CSA #(32) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA15(
    input  [15:0] x,
    output  [30:0] y
);
wire  [28:0] x_ext = {{13{x[15]}}, x};
wire  [28:0] term1 = -(x_ext << 12); 
wire  [28:0] term2 = x_ext << 10;   
wire  [28:0] term3 = -(x_ext << 7);
wire  [28:0] term4 = x_ext << 4;  
wire  [28:0] term5 = x_ext << 2;  
wire  [28:0] term6 = -x_ext;  

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA16(
    input  [16:0] x,
    output  [32:0] y
);

wire  [27:0] x_ext = {{11{x[16]}}, x};
wire  [27:0] term1 = -(x_ext << 10);
wire  [27:0] term2 = -(x_ext << 7);
wire  [27:0] term3 = -(x_ext << 4);  
wire  [27:0] term4 = x_ext << 1;     

wire [27:0] s1, c1;
CSA #(28) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

wire [28:0] s1_ext = {s1[27], s1};
wire [28:0] c1_ext = {c1, 1'b0};
wire [28:0] term4_ext = {term4[27], term4};

wire [28:0] s2, c2,sum;
CSA #(29) CSA_2(
    .a(s1_ext),
    .b(c1_ext),
    .c(term4_ext),
    .sum(s2),
    .carry(c2)
);
assign sum = s2 + (c2 << 1);
assign y = {{4{sum[28]}},sum};
endmodule

module CSD_CSA17(
    input  [16:0] x,
    output  [32:0] y
);
wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 15; 
wire  [31:0] term2 = x_ext << 12;   
wire  [31:0] term3 = -(x_ext << 10);
wire  [31:0] term4 = x_ext << 8;  
wire  [31:0] term5 = -(x_ext << 6);  
wire  [31:0] term6 = -(x_ext << 3);  

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA18(
    input  [16:0] x,
    output  [32:0] y
);
wire  [30:0] x_ext = {{14{x[16]}}, x};
wire  [30:0] term1 = x_ext << 14; 
wire  [30:0] term2 = -(x_ext << 9);   
wire  [30:0] term3 = -(x_ext << 7);
wire  [30:0] term4 = -(x_ext << 5);  
wire  [30:0] term5 = x_ext << 2;  
wire  [30:0] term6 = x_ext;  

wire [30:0] s1,c1,s2,c2;
CSA #(31) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(31) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [31:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[30],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[30],s2};
wire [31:0] s3,c3;
CSA #(32) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [32:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[31],s3};
assign c2_ext = {c2[30],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [32:0] s4,c4;
CSA #(33) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA19(
input [16:0] x,
output [32:0] y);

wire [29:0] x_ext = {{13{x[16]}}, x};
wire [29:0] term1 = -(x_ext << 12);
wire [29:0] term2 = x_ext << 10;
wire [29:0] term3 = x_ext << 8;
wire [29:0] term4 = x_ext << 4;
wire [29:0] term5 = x_ext << 2;

wire [29:0] s1,c1,s2,c2;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(30) CSA_2(.a(term4) ,.b(term5) ,.c(30'b0) ,.sum(s2) ,.carry(c2));

wire [30:0] s1_ext,c1_ext,s2_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[29],s2};
wire [30:0] s3,c3;
CSA #(31) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [31:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[30],s3};
assign c2_ext = {c2[29],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [31:0] s4,c4,sum;
CSA #(32) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {sum[31],sum};
endmodule

module CSD_CSA20(
input [16:0] x,
output [31:0] y);

wire [29:0] x_ext = {{13{x[16]}}, x};
wire [29:0] term1 = x_ext << 9;
wire [29:0] term2 = -(x_ext << 6);
wire [29:0] term3 = -(x_ext << 3);
wire [29:0] term4 = -(x_ext << 1);

wire [29:0] s1,c1;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [30:0] s1_ext,c1_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
wire [30:0] s2,c2,sum;
CSA #(31) CSA_3(.a(s1_ext) ,.b({term4[29],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign sum = s2 + (c2 << 1);
assign y = {sum[30],sum};
endmodule

module CSD_CSA21(
    input  [16:0] x,
    output  [31:0] y
);
wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = -(x_ext << 14); 
wire  [31:0] term2 = x_ext << 9;   
wire  [31:0] term3 = x_ext << 7;
wire  [31:0] term4 = -(x_ext << 5);  
wire  [31:0] term5 = x_ext << 3; 
wire  [31:0] term6 = -(x_ext << 1); 

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA22(
input [16:0] x,
output [31:0] y);

wire [29:0] x_ext = {{13{x[16]}}, x};
wire [29:0] term1 = x_ext << 12;
wire [29:0] term2 = x_ext << 9;
wire [29:0] term3 = x_ext << 5;
wire [29:0] term4 = -(x_ext << 3);

wire [29:0] s1,c1;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [30:0] s1_ext,c1_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
wire [30:0] s2,c2,sum;
CSA #(31) CSA_3(.a(s1_ext) ,.b({term4[29],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign sum = s2 + (c2 << 1);
assign y = {sum[30],sum};
endmodule

module CSD_CSA23(
    input  [16:0] x,
    output  [31:0] y
);

wire  [26:0] x_ext = {{10{x[16]}}, x};
wire  [26:0] term1 = -(x_ext << 9); 
wire  [26:0] term2 = -(x_ext << 6);   
wire  [26:0] term3 = x_ext << 4;   
wire  [26:0] term4 = -(x_ext << 2);
wire  [26:0] term5 = x_ext;

wire [26:0] s1,c1,s2,c2;
CSA #(27) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(27) CSA_2(.a(term4) ,.b(term5) ,.c(27'b0) ,.sum(s2) ,.carry(c2));

wire [27:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[26],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[26],s2};
wire [27:0] s3,c3;
CSA #(28) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [28:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[27],s3};
assign c2_ext = {c2[26],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [28:0] s4,c4,sum;
CSA #(29) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {{3{sum[28]}},sum};
endmodule

module CSD_CSA24(
input [17:0] x,
output [33:0] y);

wire [28:0] x_ext = {{11{x[17]}}, x};
wire [28:0] term1 = -(x_ext << 10);
wire [28:0] term2 = x_ext << 8;
wire [28:0] term3 = -(x_ext << 5);

wire [28:0] s1,c1,sum;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{5{sum[28]}},sum};
endmodule

module CSD_CSA25(
    input  [17:0] x,
    output  [33:0] y
);

wire  [32:0] x_ext = {{15{x[17]}}, x};
wire  [32:0] term1 = x_ext << 15; 
wire  [32:0] term2 = -(x_ext << 11);   
wire  [32:0] term3 = -(x_ext << 8);   
wire  [32:0] term4 =  x_ext << 4;
wire  [32:0] term5 = -(x_ext << 2);

wire [32:0] s1,c1,s2,c2;
CSA #(33) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(33) CSA_2(.a(term4) ,.b(term5) ,.c(33'b0) ,.sum(s2) ,.carry(c2));

wire [33:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[32],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[32],s2};
wire [33:0] s3,c3;
CSA #(34) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [34:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[33],s3};
assign c2_ext = {c2[32],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [34:0] s4,c4;
CSA #(35) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA26(
    input  [17:0] x,
    output  [33:0] y
);

wire  [30:0] x_ext = {{13{x[17]}}, x};
wire  [30:0] term1 = x_ext << 13;
wire  [30:0] term2 = x_ext << 11;
wire  [30:0] term3 = x_ext << 6;  
wire  [30:0] term4 = -x_ext;     

wire [30:0] s1, c1;
CSA #(31) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

wire [31:0] s1_ext = {s1[30], s1};
wire [31:0] c1_ext = {c1, 1'b0};
wire [31:0] term4_ext = {term4[30], term4};

wire [31:0] s2, c2,sum;
CSA #(32) CSA_2(
    .a(s1_ext),
    .b(c1_ext),
    .c(term4_ext),
    .sum(s2),
    .carry(c2)
);
assign sum = s2 + (c2 << 1);
assign y = {{2{sum[31]}},sum};

endmodule

module CSD_CSA27(
    input  [17:0] x,
    output  [33:0] y
);

wire  [29:0] x_ext = {{12{x[17]}}, x};
wire  [29:0] term1 = -(x_ext << 11); 
wire  [29:0] term2 = x_ext << 9;   
wire  [29:0] term3 = -(x_ext << 5);   
wire  [29:0] term4 = -(x_ext << 3);
wire  [29:0] term5 = x_ext;

wire [29:0] s1,c1,s2,c2;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(30) CSA_2(.a(term4) ,.b(term5) ,.c(30'b0) ,.sum(s2) ,.carry(c2));

wire [30:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[29],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[29],s2};
wire [30:0] s3,c3;
CSA #(31) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [31:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[30],s3};
assign c2_ext = {c2[29],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [31:0] s4,c4,sum;
CSA #(32) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {{2{sum[31]}},sum};
endmodule

module CSD_CSA28(
    input  [16:0] x,
    output  [32:0] y
);

wire  [26:0] x_ext = {{10{x[16]}}, x};
wire  [26:0] term1 = x_ext << 8;
wire  [26:0] term2 = x_ext << 6;
wire  [26:0] term3 = -(x_ext << 4);  

wire [26:0] s1, c1,sum;
CSA #(27) CSA_1(
    .a(term1),
    .b(term2),
    .c(term3),
    .sum(s1),
    .carry(c1)
);

assign sum = s1 + (c1 << 1);
assign y = {{6{sum[26]}},sum};
endmodule

module CSD_CSA29(
    input  [16:0] x,
    output  [32:0] y
);

wire  [30:0] x_ext = {{14{x[16]}}, x};
wire  [30:0] term1 = -(x_ext << 12); 
wire  [30:0] term2 = x_ext << 10;   
wire  [30:0] term3 = x_ext << 8;
wire  [30:0] term4 = x_ext << 6;  
wire  [30:0] term5 = x_ext << 2;  

wire [30:0] s1,c1,s2,c2;
CSA #(31) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(31) CSA_2(.a(term4) ,.b(term5) ,.c(31'b0) ,.sum(s2) ,.carry(c2));

wire [31:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[30],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[30],s2};
wire [31:0] s3,c3;
CSA #(32) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [32:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[31],s3};
assign c2_ext = {c2[30],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [32:0] s4,c4;
CSA #(33) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA30(
    input  [16:0] x,
    output  [32:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 14; 
wire  [31:0] term2 = x_ext << 10;   
wire  [31:0] term3 = x_ext << 8;   
wire  [31:0] term4 = -(x_ext << 3);

wire [31:0] s1,c1;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [32:0] s1_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
wire [32:0] s2,c2;
CSA #(33) CSA_3(.a(s1_ext) ,.b({term4[31],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign y = s2 + (c2 << 1);
endmodule

module CSD_CSA31(
    input  [16:0] x,
    output  [32:0] y
);

wire  [28:0] x_ext = {{12{x[16]}}, x};
wire  [28:0] term1 = -(x_ext << 10); 
wire  [28:0] term2 = x_ext << 8;   
wire  [28:0] term3 = x_ext << 6;   
wire  [28:0] term4 = x_ext << 3;
wire  [28:0] term5 = -x_ext;

wire [28:0] s1,c1,s2,c2;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(29) CSA_2(.a(term4) ,.b(term5) ,.c(29'b0) ,.sum(s2) ,.carry(c2));

wire [29:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[28],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[28],s2};
wire [29:0] s3,c3;
CSA #(30) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [30:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[29],s3};
assign c2_ext = {c2[28],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [30:0] s4,c4,sum;
CSA #(31) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign sum = s4 + (c4 << 1);
assign y = {{2{sum[30]}},sum};
endmodule

module CSD_CSA32(
input [16:0] x,
output [32:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = -(x_ext << 10);
wire [27:0] term2 = -(x_ext << 8);
wire [27:0] term3 = -(x_ext << 2);

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{5{sum[27]}},sum};
endmodule

module CSD_CSA33(
input [16:0] x,
output [32:0] y);

wire [29:0] x_ext = {{13{x[16]}}, x};
wire [29:0] term1 = x_ext << 13;
wire [29:0] term2 = x_ext << 5;
wire [29:0] term3 = -(x_ext << 3);

wire [29:0] s1,c1,sum;
CSA #(30) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{3{sum[29]}},sum};
endmodule

module CSD_CSA34(
    input  [16:0] x,
    output  [32:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 15; 
wire  [31:0] term2 = -(x_ext << 12);   
wire  [31:0] term3 = -(x_ext << 6);   
wire  [31:0] term4 = x_ext << 3;
wire  [31:0] term5 = x_ext << 1;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA35(
    input  [16:0] x,
    output  [32:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = -(x_ext << 11); 
wire  [31:0] term2 = -(x_ext << 8);   
wire  [31:0] term3 = x_ext << 4;   
wire  [31:0] term4 = x_ext << 2;

wire [31:0] s1,c1;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [32:0] s1_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
wire [32:0] s2,c2;
CSA #(33) CSA_3(.a(s1_ext) ,.b({term4[31],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign y = s2 + (c2 << 1);
endmodule

module CSD_CSA36(
    input  [17:0] x,
    output  [33:0] y
);

wire  [31:0] x_ext = {{14{x[17]}}, x};
wire  [31:0] term1 = -(x_ext << 11); 
wire  [31:0] term2 = x_ext << 6;   
wire  [31:0] term3 = x_ext << 2;   
wire  [31:0] term4 = -x_ext;

wire [31:0] s1,c1;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [32:0] s1_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
wire [32:0] s2,c2,sum;
CSA #(33) CSA_3(.a(s1_ext) ,.b({term4[31],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign sum = s2 + (c2 << 1);
assign y = {sum[32],sum};
endmodule

module CSD_CSA37(
    input  [17:0] x,
    output  [33:0] y
);
wire  [32:0] x_ext = {{15{x[17]}}, x};
wire  [32:0] term1 = x_ext << 15; 
wire  [32:0] term2 = -(x_ext << 13);   
wire  [32:0] term3 = x_ext << 10;
wire  [32:0] term4 = x_ext << 8;  
wire  [32:0] term5 = x_ext << 4;  
wire  [32:0] term6 = -(x_ext << 1);  

wire [32:0] s1,c1,s2,c2;
CSA #(33) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(33) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [33:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[32],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[32],s2};
wire [33:0] s3,c3;
CSA #(34) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [34:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[33],s3};
assign c2_ext = {c2[32],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [34:0] s4,c4;
CSA #(35) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA38(
input [16:0] x,
output [31:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = -(x_ext << 10);
wire [27:0] term2 = x_ext << 5;
wire [27:0] term3 = -(x_ext << 3);

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{4{sum[27]}},sum};
endmodule

module CSD_CSA39(
    input  [16:0] x,
    output  [31:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 14; 
wire  [31:0] term2 = x_ext << 12;   
wire  [31:0] term3 = -(x_ext << 6);   
wire  [31:0] term4 = -(x_ext << 4);
wire  [31:0] term5 = x_ext << 1;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA40(
input [16:0] x,
output [30:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = x_ext << 6;
wire [27:0] term2 = x_ext << 4;
wire [27:0] term3 = x_ext << 1;

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{3{sum[27]}},sum};
endmodule

module CSD_CSA41(
    input  [16:0] x,
    output  [30:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 9; 
wire  [31:0] term2 = x_ext << 6;   
wire  [31:0] term3 = -(x_ext << 4);   
wire  [31:0] term4 = -x_ext;

wire [31:0] s1,c1;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [32:0] s1_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
wire [32:0] s2,c2;
CSA #(33) CSA_3(.a(s1_ext) ,.b({term4[31],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign y = s2 + (c2 << 1);
endmodule

module CSD_CSA42(
input  [16:0] x,
output  [30:0] y);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 13; 
wire  [31:0] term2 = x_ext << 11; 
wire  [31:0] term3 = x_ext << 8;   
wire  [31:0] term4 = x_ext << 6;
wire  [31:0] term5 = x_ext << 4;  
wire  [31:0] term6 = x_ext << 2 ; 
wire  [31:0] term7 = -x_ext;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext,c2_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
assign c2_ext = {c2,1'b0};
wire [32:0] s3,c3,s4,c4;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));
CSA #(33) CSA_4(.a({term7[31],term7}) ,.b(33'b0) ,.c(c2_ext) ,.sum(s4) ,.carry(c4));

wire [33:0] s3_ext,c3_ext,c4_ext;
assign s3_ext = {s3[32],s3};
assign c3_ext = {c3,1'b0};
assign c4_ext = {c4,1'b0};
wire [33:0] s5,c5;
CSA #(34) CSA_5(.a(s3_ext) ,.b(c3_ext) ,.c(c4_ext) ,.sum(s5) ,.carry(c5));

wire [34:0] s5_ext,c5_ext,s4_ext;
assign s5_ext = {s5[33],s5};
assign c5_ext = {c5,1'b0};
assign s4_ext = {{2{s4[32]}},s4};
wire [34:0] s6,c6,sum;
CSA #(35) CSA_6(.a(s4_ext) ,.b(c5_ext) ,.c(s5_ext) ,.sum(s6) ,.carry(c6));

assign y = s6 + (c6 << 1);
endmodule

module CSD_CSA43(
    input  [16:0] x,
    output  [30:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 6; 
wire  [31:0] term2 = -(x_ext << 4);   
wire  [31:0] term3 = -(x_ext << 2);   
wire  [31:0] term4 = -x_ext;

wire [31:0] s1,c1;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [32:0] s1_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
wire [32:0] s2,c2;
CSA #(33) CSA_3(.a(s1_ext) ,.b({term4[31],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign y = s2 + (c2 << 1);
endmodule

module CSD_CSA44(
input [16:0] x,
output [30:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = -(x_ext << 10);
wire [27:0] term2 = x_ext << 8;
wire [27:0] term3 = -(x_ext << 2);

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{3{sum[27]}},sum};
endmodule

module CSD_CSA45(
    input  [16:0] x,
    output  [30:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 9; 
wire  [31:0] term2 = -(x_ext << 7);   
wire  [31:0] term3 = x_ext << 5;   
wire  [31:0] term4 = x_ext << 3;
wire  [31:0] term5 = x_ext << 1;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA46(
    input  [16:0] x,
    output  [30:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 13; 
wire  [31:0] term2 = x_ext << 11;   
wire  [31:0] term3 = x_ext << 9;   
wire  [31:0] term4 = -(x_ext << 5);
wire  [31:0] term5 = -(x_ext << 3);

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA47(
input [16:0] x,
output [30:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = x_ext << 10;
wire [27:0] term2 = -(x_ext << 7);
wire [27:0] term3 = x_ext;

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{3{sum[27]}},sum};
endmodule

module CSD_CSA48(
    input  [17:0] x,
    output  [31:0] y
);

wire  [31:0] x_ext = {{14{x[17]}}, x};
wire  [31:0] term1 = x_ext << 10; 
wire  [31:0] term2 = -(x_ext << 8);   
wire  [31:0] term3 = x_ext << 6;   
wire  [31:0] term4 = -(x_ext << 4);
wire  [31:0] term5 = -x_ext ;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA49(
    input  [17:0] x,
    output  [31:0] y
);
wire  [31:0] x_ext = {{14{x[17]}}, x};
wire  [31:0] term1 = x_ext << 13; 
wire  [31:0] term2 = x_ext << 11;   
wire  [31:0] term3 = -(x_ext << 7);
wire  [31:0] term4 = x_ext << 5;  
wire  [31:0] term5 = x_ext << 3;  
wire  [31:0] term6 = x_ext << 1;  

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA50(
input [16:0] x,
output [31:0] y);

wire [27:0] x_ext = {{11{x[16]}}, x};
wire [27:0] term1 = x_ext << 7;
wire [27:0] term2 = -(x_ext << 1);

wire [27:0] s1,c1,sum;
CSA #(28) CSA_1(.a(term1) ,.b(term2) ,.c(28'b0) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{4{sum[27]}},sum};
endmodule

module CSD_CSA51(
    input  [16:0] x,
    output  [31:0] y
);

wire  [31:0] x_ext = {{15{x[16]}}, x};
wire  [31:0] term1 = x_ext << 14; 
wire  [31:0] term2 = -(x_ext << 12);   
wire  [31:0] term3 = -(x_ext << 10);   
wire  [31:0] term4 = -(x_ext << 7);
wire  [31:0] term5 = x_ext << 1 ;

wire [31:0] s1,c1,s2,c2;
CSA #(32) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(32) CSA_2(.a(term4) ,.b(term5) ,.c(32'b0) ,.sum(s2) ,.carry(c2));

wire [32:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[31],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[31],s2};
wire [32:0] s3,c3;
CSA #(33) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [33:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[32],s3};
assign c2_ext = {c2[31],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [33:0] s4,c4;
CSA #(34) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA52(
    input  [18:0] x,
    output  [32:0] y
);

wire  [30:0] x_ext = {{12{x[18]}}, x};
wire  [30:0] term1 = -(x_ext << 10); 
wire  [30:0] term2 = -(x_ext << 7);   
wire  [30:0] term3 = -(x_ext << 5);   
wire  [30:0] term4 = -(x_ext << 2);

wire [30:0] s1,c1;
CSA #(31) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

wire [31:0] s1_ext,c1_ext;
assign s1_ext = {s1[30],s1};
assign c1_ext = {c1,1'b0};
wire [31:0] s2,c2,sum;
CSA #(32) CSA_3(.a(s1_ext) ,.b({term4[30],term4}) ,.c(c1_ext) ,.sum(s2) ,.carry(c2));

assign sum = s2 + (c2 << 1);
assign y = {sum[31],sum};
endmodule

module CSD_CSA53(
input  [18:0] x,
output  [32:0] y);

wire  [33:0] x_ext = {{15{x[18]}}, x};
wire  [33:0] term1 = x_ext << 14; 
wire  [33:0] term2 = x_ext << 12; 
wire  [33:0] term3 = -(x_ext << 7);   
wire  [33:0] term4 = x_ext << 5;
wire  [33:0] term5 = x_ext << 3;  
wire  [33:0] term6 = -(x_ext << 1) ; 

wire [33:0] s1,c1,s2,c2;
CSA #(34) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(34) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [34:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[33],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[33],s2};
wire [34:0] s3,c3;
CSA #(35) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [35:0] s3_ext,c3_ext,c2_ext;
assign s3_ext = {s3[34],s3};
assign c3_ext = {c3,1'b0};
assign c2_ext = {c2[33],c2,1'b0};
wire [35:0] s4,c4;
CSA #(36) CSA_4(.a(s3_ext) ,.b(c3_ext) ,.c(c2_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSD_CSA54(
input [18:0] x,
output [32:0] y);

wire [28:0] x_ext = {{10{x[18]}}, x};
wire [28:0] term1 = x_ext << 9;
wire [28:0] term2 = -(x_ext << 7);
wire [28:0] term3 = x_ext << 2;

wire [28:0] s1,c1,sum;
CSA #(29) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));

assign sum = s1 + (c1 << 1);
assign y = {{4{sum[28]}},sum};
endmodule

module CSD_CSA55(
    input  [18:0] x,
    output  [32:0] y
);
wire  [32:0] x_ext = {{14{x[18]}}, x};
wire  [32:0] term1 = x_ext << 13; 
wire  [32:0] term2 = x_ext << 11;   
wire  [32:0] term3 = -(x_ext << 7);
wire  [32:0] term4 = -(x_ext << 5);  
wire  [32:0] term5 = x_ext << 3;  
wire  [32:0] term6 = -x_ext;  

wire [32:0] s1,c1,s2,c2;
CSA #(33) CSA_1(.a(term1) ,.b(term2) ,.c(term3) ,.sum(s1) ,.carry(c1));
CSA #(33) CSA_2(.a(term4) ,.b(term5) ,.c(term6) ,.sum(s2) ,.carry(c2));

wire [33:0] s1_ext,s2_ext,c1_ext;
assign s1_ext = {s1[32],s1};
assign c1_ext = {c1,1'b0};
assign s2_ext = {s2[32],s2};
wire [33:0] s3,c3;
CSA #(34) CSA_3(.a(s1_ext) ,.b(s2_ext) ,.c(c1_ext) ,.sum(s3) ,.carry(c3));

wire [34:0] s3_ext,c2_ext,c3_ext;
assign s3_ext = {s3[33],s3};
assign c2_ext = {c2[32],c2,1'b0};
assign c3_ext = {c3,1'b0};
wire [34:0] s4,c4;
CSA #(35) CSA_4(.a(s3_ext) ,.b(c2_ext) ,.c(c3_ext) ,.sum(s4) ,.carry(c4));

assign y = s4 + (c4 << 1);
endmodule

module CSA #(parameter width = 30)(
input [width-1:0] a,b,c,
output [width-1:0] sum,
output [width-1:0] carry);

assign carry = (a & b) | (b & c) | (a & c);

assign sum = a ^ b ^ c;

endmodule




