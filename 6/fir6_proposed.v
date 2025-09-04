//synopsys translate_off
`include "CSD_CSA_proposed.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x6k,x6k_1,x6k_2,x6k_3,x6k_4,x6k_5,
output reg signed [15:0] y6k,y6k_1,y6k_2,y6k_3,y6k_4,y6k_5);

integer j;
reg signed [15:0] x6k_3_reg,x6k_2_add_x6k_3_reg,x6k_2_sub_x6k_3_reg,x6k_1_add_x6k_3_reg,x6k_1_sub_x6k_3_reg;
reg signed [16:0] x6k_1_sub_x6k_5_reg,x6k_1_add_x6k_5_reg,x6k_0123_reg,x6k_01_sub_23_reg,x6k_02_sub_13_reg,x6k_03_sub_12_reg,x6k_05_sub_14_reg,x6k_01_sub_45_reg;
wire signed [15:0] x6k_2_sub_x6k_3,x6k_1_add_x6k_3,x6k_1_sub_x6k_3,x6k_2_add_x6k_3;
wire signed [16:0] x6k_0123,x6k_01_sub_23,x6k_02_sub_13,x6k_03_sub_12,x6k_05_sub_14,x6k_1_add_x6k_5,x6k_1_sub_x6k_5,x6k_01_sub_45;
reg signed [17:0] x6k_135_reg,x6k_0145_reg,x6k_04_sub_15_reg;
wire signed [18:0] x6k_012345,x6k_024_sub_135;
reg signed [18:0] x6k_012345_reg,x6k_024_sub_135_reg;
wire signed [17:0] x6k_135,x6k_0145,x6k_04_sub_15;
// H3 H2+H3 H2-H3 H1+H3 H1-H3 H1-H5 H0+H1-H4-H5 H0+H2-H1-H3 H0+H3-H1-H2 block def
wire [30:0] H2_plus_H3_mult [1:0],H2_minus_H3_mult [1:0],H1_plus_H3_mult [3:0],H1_minus_H3_mult [3:0],H02_minus_13_mult [3:0],H03_minus_12_mult [3:0];
reg signed [30:0] H2_plus_H3_mult_reg [1:0],H2_minus_H3_mult_reg [1:0],H1_plus_H3_mult_reg [3:0],H1_minus_H3_mult_reg [3:0],H02_minus_13_mult_reg [3:0],H03_minus_12_mult_reg [3:0];
reg signed [30:0] H2_plus_H3_add_reg [2:0],H2_minus_H3_add_reg [2:0],H1_plus_H3_add_reg [2:0],H1_minus_H3_add_reg [2:0],H02_minus_13_add_reg [2:0],H03_minus_12_add_reg [2:0]; 
reg signed [30:0] H2_plus_H3_stage_one_temp,H2_minus_H3_stage_one_temp,H1_plus_H3_stage_one_temp,H1_minus_H3_stage_one_temp,H02_minus_13_stage_one_temp,H03_minus_12_stage_one_temp;
wire [31:0] H3_mult [3:0],H1_minus_H5_mult [3:0],H01_minus_45_mult [1:0];
reg signed [31:0] H3_mult_reg [3:0],H1_minus_H5_mult_reg [3:0],H01_minus_45_mult_reg [1:0];
reg signed [31:0] H3_add_reg [2:0],H1_minus_H5_add_reg [2:0],H01_minus_45_add_reg [2:0];
reg signed [31:0] H3_stage_one_temp,H1_minus_H5_stage_one_temp,H01_minus_45_stage_one_temp;
//H1+H3+H5 H0+H1+H2+H3 H0+H1-H2-H3 H0+H1+H4+H5  block def
wire [33:0] H0_H1_mult [3:0],H4_H5_mult [3:0],H2_H3_mult [1:0],H135_mult [3:0],H024_mult [3:0],H0145_mult [1:0];
reg signed [33:0] H0_H1_mult_reg [3:0],H4_H5_mult_reg [3:0],H2_H3_mult_reg [1:0],H135_mult_reg [3:0],H024_mult_reg [3:0],H0145_mult_reg [1:0];
reg signed [33:0] H0_H1_add_reg [2:0],H4_H5_add_reg [2:0],H2_H3_add_reg [2:0],H135_add_reg [2:0],H024_add_reg [2:0],H0145_add_reg [2:0];
reg signed [33:0] H0_H1_stage_one_temp,H4_H5_stage_one_temp,H2_H3_stage_one_temp,H135_stage_one_temp,H024_stage_one_temp,H0145_stage_one_temp;
wire [32:0] H0123_mult [3:0],H01_minus_23_mult [3:0];
reg signed [32:0] H0123_mult_reg [3:0],H01_minus_23_mult_reg [3:0];
reg signed [32:0] H0123_add_reg [2:0],H01_minus_23_add_reg [2:0];
reg signed [32:0] H0123_stage_one_temp,H01_minus_23_stage_one_temp;
// H0+H1+H2+H3+H4+H5 H0+H2+H4-H1-H3-H5 H1+H5 block def
wire [32:0] H024_minus_135_mult [1:0],H1_plus_H5_mult [3:0],H012345_mult [1:0];
reg signed [32:0] H024_minus_135_mult_reg [3:0],H1_plus_H5_mult_reg [3:0],H012345_mult_reg [1:0];
reg signed [32:0] H024_minus_135_add_reg [2:0],H1_plus_H5_add_reg [2:0],H012345_add_reg [2:0];
reg signed [32:0] H024_minus_135_stage_one_temp,H1_plus_H5_stage_one_temp,H012345_stage_one_temp;
// H0+H5-H1-H4 H0+H4-H1-H5 block def
wire [31:0] H05_minus_14_mult [1:0],H04_minus_15_mult [1:0];
reg signed [31:0] H05_minus_14_mult_reg [1:0],H04_minus_15_mult_reg [3:0];
reg signed [31:0] H05_minus_14_add_reg [2:0],H04_minus_15_add_reg [2:0];
reg signed [31:0] H05_minus_14_stage_one_temp,H04_minus_15_stage_one_temp;

wire signed [31:0] H1_plus_H5_add_reg0_div2;
wire signed [30:0] H04_minus_15_add_reg0_div2;
wire signed [32:0] H0145_add_reg0_div2;
reg signed [31:0] y6k_temp,y6k_temp2,y6k_temp3,y6k_temp4,y6k_temp5,y6k_temp6,y6k_temp7,y6k_temp8,y6k_1_temp,y6k_2_temp,y6k_2_temp2,y6k_2_temp3,y6k_2_temp4,y6k_2_temp5,y6k_2_temp6;
reg signed [31:0] y6k_3_temp,y6k_3_temp2,y6k_4_temp,y6k_4_temp2,y6k_4_temp3,y6k_4_temp4,y6k_4_temp5,y6k_5_temp,y6k_5_temp2;
wire signed [31:0] u,v,w,x,y,z;


///************H3 block ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_3_reg<=0;
    else x6k_3_reg<=x6k_3;
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin            
            H3_mult_reg[j]<=0;  
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H3_mult_reg[j]<=H3_mult[j];
        end
    end
end

CSD_CSA0 H30(.x(x6k_3_reg) ,.y(H3_mult[0]));
CSD_CSA1 H31(.x(x6k_3_reg) ,.y(H3_mult[1]));
CSD_CSA2 H32(.x(x6k_3_reg) ,.y(H3_mult[2]));
CSD_CSA3 H33(.x(x6k_3_reg) ,.y(H3_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H3_stage_one_temp<=0;
    else H3_stage_one_temp<=H3_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H3_add_reg[j]<=0;
        end
    end
    else begin
        H3_add_reg[2] <= H3_stage_one_temp + H3_mult_reg[2];
        for(j=0;j<2;j=j+1) begin
           H3_add_reg[j]<=H3_add_reg[j+1] + H3_mult_reg[j];
        end
    end
end

//******************H2 + H3 && H2 - H3***********************
assign x6k_2_add_x6k_3 = (x6k_2 >>> 1) + (x6k_3 >>> 1);
assign x6k_2_sub_x6k_3 = (x6k_2 >>> 1) - (x6k_3 >>> 1);

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_2_sub_x6k_3_reg<=0;
        x6k_2_add_x6k_3_reg<=0;
    end
    else begin
        x6k_2_sub_x6k_3_reg<=x6k_2_sub_x6k_3;
        x6k_2_add_x6k_3_reg<=x6k_2_add_x6k_3;
    end
end


CSD_CSA4 H2H3(.x(x6k_2_add_x6k_3_reg) ,.y(H2_plus_H3_mult[0]));
CSD_CSA5 H2H3_1(.x(x6k_2_add_x6k_3_reg) ,.y(H2_plus_H3_mult[1]));
CSD_CSA6 H2H3_2(.x(x6k_2_sub_x6k_3_reg) ,.y(H2_minus_H3_mult[0]));
CSD_CSA7 H2H3_3(.x(x6k_2_sub_x6k_3_reg) ,.y(H2_minus_H3_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H2_minus_H3_mult_reg[j]<=0;
            H2_plus_H3_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H2_plus_H3_mult_reg[j]<=H2_plus_H3_mult[j];
            H2_minus_H3_mult_reg[j]<=H2_minus_H3_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H2_plus_H3_stage_one_temp<=0;
        H2_minus_H3_stage_one_temp<=0;
    end
    else begin
        H2_plus_H3_stage_one_temp<=H2_plus_H3_mult_reg[0];
        H2_minus_H3_stage_one_temp<=H2_minus_H3_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H2_plus_H3_add_reg[j]<=0;
            H2_minus_H3_add_reg[j]<=0;
        end
    end
    else begin
        H2_plus_H3_add_reg[2] <= H2_plus_H3_stage_one_temp + H2_plus_H3_mult_reg[1];
        H2_minus_H3_add_reg[2] <= H2_minus_H3_stage_one_temp + H2_minus_H3_mult_reg[1];
        for(j=0;j<2;j=j+1) begin
            H2_plus_H3_add_reg[j]<= H2_plus_H3_mult_reg[j] + H2_plus_H3_add_reg[j+1];
            H2_minus_H3_add_reg[j]<= H2_minus_H3_add_reg[j+1] - H2_minus_H3_mult_reg[j];
        end
    end
end

//******************H1 + H3 && H1 - H3***********************
assign x6k_1_add_x6k_3 = (x6k_1 >>> 1) + (x6k_3 >>> 1);
assign x6k_1_sub_x6k_3 = (x6k_1 >>> 1) - (x6k_3 >>> 1);

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_1_add_x6k_3_reg<=0;
        x6k_1_sub_x6k_3_reg<=0;        
    end
    else begin
        x6k_1_add_x6k_3_reg<=x6k_1_add_x6k_3;
        x6k_1_sub_x6k_3_reg<=x6k_1_sub_x6k_3;
    end
end

CSD_CSA8 H1H3(.x(x6k_1_add_x6k_3_reg) ,.y(H1_plus_H3_mult[0]));
CSD_CSA9 H1H3_1(.x(x6k_1_add_x6k_3_reg) ,.y(H1_plus_H3_mult[1]));
CSD_CSA10 H1H3_2(.x(x6k_1_add_x6k_3_reg) ,.y(H1_plus_H3_mult[2]));
CSD_CSA11 H1H3_3(.x(x6k_1_add_x6k_3_reg) ,.y(H1_plus_H3_mult[3]));
CSD_CSA12 H1H3_4(.x(x6k_1_sub_x6k_3_reg) ,.y(H1_minus_H3_mult[0]));
CSD_CSA13 H1H3_5(.x(x6k_1_sub_x6k_3_reg) ,.y(H1_minus_H3_mult[1]));
CSD_CSA14 H1H3_6(.x(x6k_1_sub_x6k_3_reg) ,.y(H1_minus_H3_mult[2]));
CSD_CSA15 H1H3_7(.x(x6k_1_sub_x6k_3_reg) ,.y(H1_minus_H3_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H1_minus_H3_mult_reg[j]<=0;
            H1_plus_H3_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H1_plus_H3_mult_reg[j]<=H1_plus_H3_mult[j];
            H1_minus_H3_mult_reg[j]<=H1_minus_H3_mult[j];
        end
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1_plus_H3_stage_one_temp<=0;
        H1_minus_H3_stage_one_temp<=0;
    end
    else begin
        H1_plus_H3_stage_one_temp<=H1_plus_H3_mult_reg[3];
        H1_minus_H3_stage_one_temp<=H1_minus_H3_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H1_minus_H3_add_reg[j]<=0;
            H1_plus_H3_add_reg[j]<=0;
        end
    end
    else begin
        H1_minus_H3_add_reg[2] <= H1_minus_H3_stage_one_temp + H1_minus_H3_mult_reg[2];
        H1_plus_H3_add_reg[2] <= H1_plus_H3_stage_one_temp + H1_plus_H3_mult_reg[2];
        for(j=0;j<2;j=j+1) begin
            H1_minus_H3_add_reg[j]<= H1_minus_H3_mult_reg[j] + H1_minus_H3_add_reg[j+1];            
            H1_plus_H3_add_reg[j]<= H1_plus_H3_mult_reg[j] + H1_plus_H3_add_reg[j+1];
        end
    end
end

//******************H1 + H5 && H1 - H5***********************
assign x6k_1_add_x6k_5 = x6k_1 + x6k_5;
assign x6k_1_sub_x6k_5 = x6k_1 - x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_1_add_x6k_5_reg<=0;
        x6k_1_sub_x6k_5_reg<=0;        
    end
    else begin
        x6k_1_add_x6k_5_reg<=x6k_1_add_x6k_5;
        x6k_1_sub_x6k_5_reg<=x6k_1_sub_x6k_5;
    end
end

CSD_CSA16 H1H5(.x(x6k_1_add_x6k_5_reg) ,.y(H1_plus_H5_mult[0]));
CSD_CSA17 H1H5_1(.x(x6k_1_add_x6k_5_reg) ,.y(H1_plus_H5_mult[1]));
CSD_CSA18 H1H5_2(.x(x6k_1_add_x6k_5_reg) ,.y(H1_plus_H5_mult[2]));
CSD_CSA19 H1H5_3(.x(x6k_1_add_x6k_5_reg) ,.y(H1_plus_H5_mult[3]));
CSD_CSA20 H1H5_4(.x(x6k_1_sub_x6k_5_reg) ,.y(H1_minus_H5_mult[0]));
CSD_CSA21 H1H5_5(.x(x6k_1_sub_x6k_5_reg) ,.y(H1_minus_H5_mult[1]));
CSD_CSA22 H1H5_6(.x(x6k_1_sub_x6k_5_reg) ,.y(H1_minus_H5_mult[2]));
CSD_CSA23 H1H5_7(.x(x6k_1_sub_x6k_5_reg) ,.y(H1_minus_H5_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H1_minus_H5_mult_reg[j]<=0;
            H1_plus_H5_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H1_plus_H5_mult_reg[j]<=H1_plus_H5_mult[j];
            H1_minus_H5_mult_reg[j]<=H1_minus_H5_mult[j];
        end
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1_plus_H5_stage_one_temp<=0;
        H1_minus_H5_stage_one_temp<=0;
    end
    else begin
        H1_plus_H5_stage_one_temp<=H1_plus_H5_mult_reg[3];
        H1_minus_H5_stage_one_temp<=H1_minus_H5_mult_reg[3];
    end
end

assign H1_plus_H5_add_reg0_div2 = H1_plus_H5_add_reg[0][32:1];
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H1_minus_H5_add_reg[j]<=0;
            H1_plus_H5_add_reg[j]<=0;
        end
    end
    else begin
        H1_minus_H5_add_reg[2] <= H1_minus_H5_stage_one_temp + H1_minus_H5_mult_reg[2];
        H1_plus_H5_add_reg[2] <= H1_plus_H5_stage_one_temp + H1_plus_H5_mult_reg[2];
        for(j=0;j<2;j=j+1) begin
            H1_minus_H5_add_reg[j]<= H1_minus_H5_mult_reg[j] + H1_minus_H5_add_reg[j+1];            
            H1_plus_H5_add_reg[j]<= H1_plus_H5_mult_reg[j] + H1_plus_H5_add_reg[j+1];
        end
    end
end

//******************H1 + H3 + H5***********************

wire signed [15:0] s1,c1;
CSA #(16) input_add(.a(x6k_1) ,.b(x6k_3) ,.c(x6k_5) ,.sum(s1) ,.carry(c1));
assign x6k_135 = s1 + (c1 << 1);

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_135_reg<=0;
    else x6k_135_reg<=x6k_135;
end

CSD_CSA24 H135_0(.x(x6k_135_reg) ,.y(H135_mult[0]));
CSD_CSA25 H135_1(.x(x6k_135_reg) ,.y(H135_mult[1]));
CSD_CSA26 H135_2(.x(x6k_135_reg) ,.y(H135_mult[2]));
CSD_CSA27 H135_3(.x(x6k_135_reg) ,.y(H135_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H135_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H135_mult_reg[j]<=H135_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H135_stage_one_temp<=0;
    end
    else begin
        H135_stage_one_temp<=H135_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H135_add_reg[j]<=0;
    end
    else begin
        H135_add_reg[2]<=H135_stage_one_temp + H135_mult_reg[2];
        for(j=0;j<2;j=j+1) begin
           H135_add_reg[j]<=H135_add_reg[j+1] + H135_mult_reg[j];
        end
    end
end


//******************H0 + H1 + H2 + H3 && H0 + H1 - H2 - H3***********************
assign x6k_0123 = ((x6k >>> 1) + (x6k_1 >>> 1)) + x6k_2_add_x6k_3;
assign x6k_01_sub_23 = ((x6k >>> 1) + (x6k_1 >>> 1)) - x6k_2_add_x6k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_0123_reg<=0;
        x6k_01_sub_23_reg<=0;
    end
    else begin
        x6k_0123_reg<=x6k_0123;
        x6k_01_sub_23_reg<=x6k_01_sub_23;
    end
end

CSD_CSA28 H0123_0(.x(x6k_0123_reg) ,.y(H0123_mult[0]));
CSD_CSA29 H0123_1(.x(x6k_0123_reg) ,.y(H0123_mult[1]));
CSD_CSA30 H0123_2(.x(x6k_0123_reg) ,.y(H0123_mult[2]));
CSD_CSA31 H0123_3(.x(x6k_0123_reg) ,.y(H0123_mult[3]));
CSD_CSA32 H0123_4(.x(x6k_01_sub_23_reg) ,.y(H01_minus_23_mult[0]));
CSD_CSA33 H0123_5(.x(x6k_01_sub_23_reg) ,.y(H01_minus_23_mult[1]));
CSD_CSA34 H0123_6(.x(x6k_01_sub_23_reg) ,.y(H01_minus_23_mult[2]));
CSD_CSA35 H0123_7(.x(x6k_01_sub_23_reg) ,.y(H01_minus_23_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0123_mult_reg[j]<=0;
            H01_minus_23_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H0123_mult_reg[j]<=H0123_mult[j];
            H01_minus_23_mult_reg[j]<=H01_minus_23_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0123_stage_one_temp<=0;
        H01_minus_23_stage_one_temp<=0;
    end
    else begin
        H0123_stage_one_temp<=H0123_mult_reg[3];
        H01_minus_23_stage_one_temp<=H01_minus_23_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H0123_add_reg[j]<=0;
            H01_minus_23_add_reg[j]<=0;
        end
    end
    else begin
        H0123_add_reg[2]<=H0123_stage_one_temp + H0123_mult_reg[2];
        H01_minus_23_add_reg[2]<=H01_minus_23_stage_one_temp + H01_minus_23_mult_reg[2];        
        for(j=0;j<2;j=j+1) begin
           H01_minus_23_add_reg[j]<=H01_minus_23_add_reg[j+1] + H01_minus_23_mult_reg[j];
           H0123_add_reg[j]<=H0123_add_reg[j+1] + H0123_mult_reg[j];
        end
    end
end


//******************H0 + H1 + H4 + H5 && H0 + H1 - H4 - H5***********************
assign x6k_0145 = (x6k + x6k_1) + (x6k_4 + x6k_5);
assign x6k_01_sub_45 = ((x6k >>> 1) + (x6k_1 >>> 1)) - ((x6k_4 >>> 1) + (x6k_5 >>> 1));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_0145_reg<=0;
        x6k_01_sub_45_reg<=0;
    end
    else begin
        x6k_0145_reg<=x6k_0145;
        x6k_01_sub_45_reg<=x6k_01_sub_45;
    end
end


CSD_CSA36 H0145_0(.x(x6k_0145_reg) ,.y(H0145_mult[0]));
CSD_CSA37 H0145_1(.x(x6k_0145_reg) ,.y(H0145_mult[1]));
CSD_CSA38 H0145_2(.x(x6k_01_sub_45_reg) ,.y(H01_minus_45_mult[0]));
CSD_CSA39 H0145_3(.x(x6k_01_sub_45_reg) ,.y(H01_minus_45_mult[1]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0145_mult_reg[j]<=0;
            H01_minus_45_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H0145_mult_reg[j]<=H0145_mult[j];
            H01_minus_45_mult_reg[j]<=H01_minus_45_mult[j];
        end
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0145_stage_one_temp<=0;
        H01_minus_45_stage_one_temp<=0;
    end
    else begin
        H0145_stage_one_temp<=H0145_mult_reg[0];
        H01_minus_45_stage_one_temp<=H01_minus_45_mult_reg[0];
    end
end

assign H0145_add_reg0_div2 = H0145_add_reg[0][33:1];
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H01_minus_45_add_reg[j]<=0;
            H0145_add_reg[j]<=0;
        end
    end
    else begin
        H01_minus_45_add_reg[2]<=H01_minus_45_stage_one_temp + H01_minus_45_mult_reg[1];            
        H0145_add_reg[2]<=H0145_stage_one_temp + H0145_mult_reg[1];
        for(j=0;j<2;j=j+1) begin
           H01_minus_45_add_reg[j]<=H01_minus_45_add_reg[j+1] - H01_minus_45_mult_reg[j];        
           H0145_add_reg[j]<=H0145_add_reg[j+1] + H0145_mult_reg[j];
        end
    end
end

//******************H0 + H2 - H1 - H3 && H0 + H3 - H1 - H2***********************
assign x6k_02_sub_13 = ((x6k >>> 1) + (x6k_2 >>> 1)) - ((x6k_1 >>> 1) + (x6k_3 >>> 1));
assign x6k_03_sub_12 = ((x6k >>> 1) + (x6k_3 >>> 1)) - ((x6k_1 >>> 1) + (x6k_2 >>> 1));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_02_sub_13_reg<=0;        
        x6k_03_sub_12_reg<=0;
    end
    else begin
        x6k_02_sub_13_reg<=x6k_02_sub_13;        
        x6k_03_sub_12_reg<=x6k_03_sub_12;
    end
end
CSD_CSA40 H0213(.x(x6k_02_sub_13_reg) ,.y(H02_minus_13_mult[0]));
CSD_CSA41 H0213_1(.x(x6k_02_sub_13_reg) ,.y(H02_minus_13_mult[1]));
CSD_CSA42 H0213_2(.x(x6k_02_sub_13_reg) ,.y(H02_minus_13_mult[2]));
CSD_CSA43 H0213_3(.x(x6k_02_sub_13_reg) ,.y(H02_minus_13_mult[3]));
CSD_CSA44 H0312(.x(x6k_03_sub_12_reg) ,.y(H03_minus_12_mult[0]));
CSD_CSA45 H0312_1(.x(x6k_03_sub_12_reg) ,.y(H03_minus_12_mult[1]));
CSD_CSA46 H0312_2(.x(x6k_03_sub_12_reg) ,.y(H03_minus_12_mult[2]));
CSD_CSA47 H0312_3(.x(x6k_03_sub_12_reg) ,.y(H03_minus_12_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H02_minus_13_mult_reg[j]<=0;            
            H03_minus_12_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H02_minus_13_mult_reg[j]<=H02_minus_13_mult[j];
            H03_minus_12_mult_reg[j]<=H03_minus_12_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H02_minus_13_stage_one_temp<=0;        
        H03_minus_12_stage_one_temp<=0;
    end
    else begin
        H02_minus_13_stage_one_temp<=H02_minus_13_mult_reg[3];        
        H03_minus_12_stage_one_temp<=H03_minus_12_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H02_minus_13_add_reg[j]<=0;            
            H03_minus_12_add_reg[j]<=0;
        end
    end
    else begin
        H02_minus_13_add_reg[2]<=H02_minus_13_stage_one_temp + H02_minus_13_mult_reg[2];                
        H03_minus_12_add_reg[2]<=H03_minus_12_stage_one_temp + H03_minus_12_mult_reg[2];        
        for(j=0;j<2;j=j+1) begin
           H02_minus_13_add_reg[j]<=H02_minus_13_add_reg[j+1] + H02_minus_13_mult_reg[j];
           H03_minus_12_add_reg[j]<=H03_minus_12_add_reg[j+1] + H03_minus_12_mult_reg[j];           
        end
    end
end

//******************H0 + H4 - H1 - H5 && H0 + H5 - H1 - H4***********************
assign x6k_04_sub_15 = (x6k + x6k_4) - (x6k_1 + x6k_5);
assign x6k_05_sub_14 = ((x6k >>> 1) + (x6k_5 >>> 1)) - ((x6k_1 >>> 1) + (x6k_4 >>> 1));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_04_sub_15_reg<=0;        
        x6k_05_sub_14_reg<=0;
    end
    else begin
        x6k_04_sub_15_reg<=x6k_04_sub_15;        
        x6k_05_sub_14_reg<=x6k_05_sub_14;
    end
end
CSD_CSA48 H0415(.x(x6k_04_sub_15_reg) ,.y(H04_minus_15_mult[0]));
CSD_CSA49 H0415_1(.x(x6k_04_sub_15_reg) ,.y(H04_minus_15_mult[1]));
CSD_CSA50 H0514(.x(x6k_05_sub_14_reg) ,.y(H05_minus_14_mult[0]));
CSD_CSA51 H0514_1(.x(x6k_05_sub_14_reg) ,.y(H05_minus_14_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H04_minus_15_mult_reg[j]<=0;            
            H05_minus_14_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H04_minus_15_mult_reg[j]<=H04_minus_15_mult[j];
            H05_minus_14_mult_reg[j]<=H05_minus_14_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H04_minus_15_stage_one_temp<=0;        
        H05_minus_14_stage_one_temp<=0;
    end
    else begin
        H04_minus_15_stage_one_temp<=H04_minus_15_mult_reg[0];        
        H05_minus_14_stage_one_temp<=H05_minus_14_mult_reg[0];
    end
end

assign H04_minus_15_add_reg0_div2 = H04_minus_15_add_reg[0][31:1];
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H04_minus_15_add_reg[j]<=0;            
            H05_minus_14_add_reg[j]<=0;
        end
    end
    else begin
        H04_minus_15_add_reg[2]<=H04_minus_15_stage_one_temp + H04_minus_15_mult_reg[1];                
        H05_minus_14_add_reg[2]<=H05_minus_14_stage_one_temp + H05_minus_14_mult_reg[1];        
        for(j=0;j<2;j=j+1) begin
           H04_minus_15_add_reg[j]<=H04_minus_15_add_reg[j+1] - H04_minus_15_mult_reg[j];
           H05_minus_14_add_reg[j]<=H05_minus_14_add_reg[j+1] + H05_minus_14_mult_reg[j];           
        end
    end
end

//******************H0 + H1 + H2 + H3 + H4 + H5***********************666
assign x6k_012345 = x6k + x6k_1 + x6k_2 + x6k_3 + x6k_4 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_012345_reg<=0;
    else x6k_012345_reg<=x6k_012345;
end


CSD_CSA52 H012345_0(.x(x6k_012345_reg) ,.y(H012345_mult[0]));
CSD_CSA53 H012345_1(.x(x6k_012345_reg) ,.y(H012345_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H012345_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H012345_mult_reg[j]<=H012345_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H012345_stage_one_temp<=0;
    end
    else begin
        H012345_stage_one_temp<=H012345_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H012345_add_reg[j]<=0;
    end
    else begin
        H012345_add_reg[2]<=H012345_stage_one_temp + H012345_mult_reg[1];
        for(j=0;j<2;j=j+1)
           H012345_add_reg[j]<=H012345_add_reg[j+1] + H012345_mult_reg[j];
    end
end

//******************H0 + H2 + H4 - H1 - H3 - H5***********************
assign x6k_024_sub_135 = (x6k + x6k_2 + x6k_4) - (x6k_1 + x6k_3 + x6k_5);

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_024_sub_135_reg<=0;
    else x6k_024_sub_135_reg<=x6k_024_sub_135;
end


CSD_CSA54 H024135_0(.x(x6k_024_sub_135_reg) ,.y(H024_minus_135_mult[0]));
CSD_CSA55 H024135_1(.x(x6k_024_sub_135_reg) ,.y(H024_minus_135_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H024_minus_135_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H024_minus_135_mult_reg[j]<=H024_minus_135_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H024_minus_135_stage_one_temp<=0;
    end
    else begin
        H024_minus_135_stage_one_temp<=H024_minus_135_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H024_minus_135_add_reg[j]<=0;
    end
    else begin
        H024_minus_135_add_reg[2]<=H024_minus_135_stage_one_temp + H024_minus_135_mult_reg[1];
        for(j=0;j<2;j=j+1)
           H024_minus_135_add_reg[j]<=H024_minus_135_add_reg[j+1] - H024_minus_135_mult_reg[j];
    end
end


//***************************************

/*assign w = H0123_add_reg[0] + H01_minus_23_add_reg[0] + H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] - H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0] - H1_plus_H3_add_reg[0] 
            - H1_minus_H3_add_reg[0] + H3_add_reg[0] + y6k_temp;
assign x = H0123_add_reg[0] + H01_minus_23_add_reg[0] - H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] - H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0] + y6k_1_temp;
assign y = H0123_add_reg[0] - H01_minus_23_add_reg[0] + H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] + 2*H1_minus_H3_add_reg[0] - H3_add_reg[0] + y6k_2_temp;
assign z = H0123_add_reg[0] - H01_minus_23_add_reg[0] - H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] + y6k_3_temp;
assign v = H0145_add_reg0_div2 - H01_minus_45_add_reg[0] + H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0] + H05_minus_14_add_reg[0] - H04_minus_15_add_reg0_div2;
assign u = H0145_add_reg0_div2 - H01_minus_45_add_reg[0] + H04_minus_15_add_reg0_div2 - H05_minus_14_add_reg[0] - H1_plus_H5_add_reg0_div2 + H1_minus_H5_add_reg[0]
            - H3_add_reg[0] + H1_plus_H3_add_reg[0] - H1_minus_H3_add_reg[0] + H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0] + y6k_4_temp;*/
assign w = y6k_temp6 + y6k_temp7 - y6k_temp8 + y6k_temp5;
assign x = y6k_1_temp + y6k_temp6 - y6k_temp7;
assign y = y6k_2_temp5 + y6k_2_temp6 + y6k_2_temp4;
assign z = y6k_3_temp + y6k_3_temp2;
assign v = y6k_5_temp + y6k_5_temp2;
assign u = y6k_4_temp5 + y6k_4_temp4 + y6k_4_temp3 + y6k_4_temp2;


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y6k<=0;
        y6k_1<=0;
        y6k_2<=0;
        y6k_3<=0;
        y6k_4<=0;
        y6k_5<=0;        
    end
    else begin
        y6k<=w[31:16];
        y6k_1<=x[31:16];
        y6k_2<=y[31:16];
        y6k_3<=z[31:16];
        y6k_4<=u[31:16];
        y6k_5<=v[31:16];                
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y6k_temp<=0;
        y6k_temp2<=0;
        y6k_temp3<=0;
        y6k_temp4<=0;
        y6k_temp5<=0;
        y6k_temp6<=0;
        y6k_temp7<=0;
        y6k_temp8<=0;        
        y6k_1_temp<=0;
        y6k_2_temp<=0;
        y6k_2_temp2<=0;
        y6k_2_temp3<=0;
        y6k_2_temp4<=0;
        y6k_2_temp5<=0;
        y6k_2_temp6<=0;        
        y6k_3_temp<=0;
        y6k_3_temp2<=0;
        y6k_4_temp<=0;
        y6k_4_temp2<=0;
        y6k_4_temp3<=0;
        y6k_4_temp4<=0;
        y6k_4_temp5<=0;  
        y6k_5_temp<=0;
        y6k_5_temp2<=0;        
        
    end
    else begin 
        y6k_temp<=H012345_add_reg[0] - H0145_add_reg[0] - H0123_add_reg[0] + H01_minus_23_add_reg[0] - H2_plus_H3_add_reg[0];
        y6k_temp2<=H024_minus_135_add_reg[0] - H04_minus_15_add_reg[0] - H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] - H2_minus_H3_add_reg[0];
        y6k_temp3<=H1_plus_H5_add_reg[0] + H1_plus_H5_add_reg0_div2 + H3_add_reg[0] + H3_add_reg[0] - H135_add_reg[0];
        y6k_temp4<=H1_plus_H3_add_reg[0] - H1_minus_H3_add_reg[0] - H1_minus_H5_add_reg[0];
        y6k_temp5<=y6k_temp + y6k_temp2 + y6k_temp3 + y6k_temp4 ;
        y6k_temp6<=H0123_add_reg[0] + H01_minus_23_add_reg[0] - H2_plus_H3_add_reg[0];
        y6k_temp7<=H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] - H2_minus_H3_add_reg[0];
        y6k_temp8<=H1_minus_H3_add_reg[0] + H1_plus_H3_add_reg[0] - H3_add_reg[0];
        y6k_1_temp<=y6k_temp - y6k_temp2;
        
        y6k_2_temp<=H0145_add_reg0_div2 + H01_minus_45_add_reg[0] - H0123_add_reg[0] - H01_minus_23_add_reg[0] + H2_plus_H3_add_reg[0];
        y6k_2_temp2<=H04_minus_15_add_reg0_div2 + H05_minus_14_add_reg[0] - H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] + H2_minus_H3_add_reg[0];
        y6k_2_temp3<=H1_minus_H3_add_reg[0] + H1_minus_H3_add_reg[0]  - H1_minus_H5_add_reg[0];
        y6k_2_temp4<= y6k_2_temp + y6k_2_temp2 - y6k_temp3  + y6k_2_temp3;
        y6k_2_temp5<=H0123_add_reg[0] - H01_minus_23_add_reg[0] + H1_minus_H3_add_reg[0];
        y6k_2_temp6<=H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] + H1_minus_H3_add_reg[0] - H3_add_reg[0];
        y6k_3_temp<= y6k_2_temp - y6k_2_temp2;
        y6k_3_temp2<=H0123_add_reg[0] - H01_minus_23_add_reg[0] - H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0];
        y6k_4_temp<=H1_plus_H5_add_reg0_div2 - H1_minus_H3_add_reg[0] + H1_minus_H5_add_reg[0] - H1_plus_H3_add_reg[0] + H3_add_reg[0];
        y6k_4_temp2<=y6k_4_temp;
        y6k_4_temp3<=H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0] - H1_minus_H3_add_reg[0] - H1_plus_H5_add_reg0_div2;
        y6k_4_temp4<=H0145_add_reg0_div2 - H01_minus_45_add_reg[0] + H04_minus_15_add_reg0_div2 - H05_minus_14_add_reg[0];
        y6k_4_temp5<=H1_minus_H5_add_reg[0] - H3_add_reg[0] + H1_plus_H3_add_reg[0];
        y6k_5_temp<=H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0] + H05_minus_14_add_reg[0];
        y6k_5_temp2<=H0145_add_reg0_div2 - H01_minus_45_add_reg[0] - H04_minus_15_add_reg0_div2;

        /*y6k_temp<=H012345_add_reg[0] - H0145_add_reg[0] - H0123_add_reg[0] + H01_minus_23_add_reg[0] - H2_plus_H3_add_reg[0] + H024_minus_135_add_reg[0]
                 - H04_minus_15_add_reg[0] - H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] - H2_minus_H3_add_reg[0] - H135_add_reg[0] + H1_plus_H5_add_reg[0]
                  + H1_plus_H3_add_reg[0] - H1_minus_H3_add_reg[0] + 2*H3_add_reg[0] - H1_minus_H5_add_reg[0] + H1_plus_H5_add_reg0_div2;
        y6k_1_temp<=H012345_add_reg[0] - H0145_add_reg[0] - H0123_add_reg[0] + H01_minus_23_add_reg[0] - H2_plus_H3_add_reg[0] - H024_minus_135_add_reg[0]
                 + H04_minus_15_add_reg[0] + H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] + H2_minus_H3_add_reg[0];
        y6k_2_temp<= H0145_add_reg[0]/2 + H01_minus_45_add_reg[0] - H0123_add_reg[0] - H01_minus_23_add_reg[0] + H2_plus_H3_add_reg[0] +
                 H04_minus_15_add_reg0_div2 + H05_minus_14_add_reg[0] - H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] + H2_minus_H3_add_reg[0] +
                 H135_add_reg[0] - H1_plus_H5_add_reg[0] + 2*H1_minus_H3_add_reg[0] - 2*H3_add_reg[0] - H1_plus_H5_add_reg0_div2 - H1_minus_H5_add_reg[0];
        y6k_3_temp<= H0145_add_reg[0]/2 + H01_minus_45_add_reg[0] - H0123_add_reg[0] - H01_minus_23_add_reg[0] + H2_plus_H3_add_reg[0] -
                H04_minus_15_add_reg0_div2 - H05_minus_14_add_reg[0] + H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] - H2_minus_H3_add_reg[0];
        y6k_4_temp<=H1_plus_H5_add_reg0_div2 + H1_minus_H5_add_reg[0] - H1_plus_H3_add_reg[0] - H1_minus_H3_add_reg[0] + H3_add_reg[0];*/
    end
end

endmodule
