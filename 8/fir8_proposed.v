//synopsys translate_off
`include "CSD_CSA_proposed.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x8k,x8k_1,x8k_2,x8k_3,x8k_4,x8k_5,x8k_6,x8k_7,
output reg signed [15:0] y8k,y8k_1,y8k_2,y8k_3,y8k_4,y8k_5,y8k_6,y8k_7);

integer j;

reg signed [15:0] x8k_7_reg,x8k_7_2_reg,x8k_3_add_x8k_7_reg,x8k_3_add_x8k_7_2_reg,x8k_3_sub_x8k_7_reg,x8k_3_sub_x8k_7_2_reg,x8k_5_add_x8k_7_reg,x8k_5_add_x8k_7_2_reg,
                    x8k_5_sub_x8k_7_reg,x8k_5_sub_x8k_7_2_reg,x8k_6_add_x8k_7_reg,x8k_6_add_x8k_7_2_reg,x8k_6_sub_x8k_7_reg,x8k_6_sub_x8k_7_2_reg;
reg signed [16:0] x8k_1357_reg,x8k_1357_2_reg,x8k_13_sub_57_reg,x8k_13_sub_57_2_reg,x8k_15_sub_37_reg,x8k_15_sub_37_2_reg,x8k_17_sub_35_reg,x8k_17_sub_35_2_reg,x8k_0246_reg,
                    x8k_1346_reg,x8k_0257_reg,x8k_46_sub_57_reg,x8k_46_sub_57_2_reg,x8k_47_sub_56_reg,x8k_47_sub_56_2_reg,x8k_0347_reg,x8k_1256_reg,x8k_0356_reg,
                    x8k_1247_reg,x8k_2367_reg,x8k_2367_2_reg,x8k_23_sub_67_reg,x8k_23_sub_67_2_reg,x8k_26_sub_37_reg,x8k_26_sub_37_2_reg,x8k_27_sub_36_reg,x8k_27_sub_36_2_reg,
                    x8k_0167_reg,x8k_2345_reg,x8k_4567_reg,x8k_0145_reg,x8k_4567_2_reg,x8k_45_sub_67_reg,x8k_45_sub_67_2_reg,x8k_0123_reg;
reg signed [17:0] x8k_01234567_reg,x8k_0123_sub_4567_reg,x8k_0145_sub_2367_reg,x8k_0167_sub_2345_reg,x8k_0246_sub_1357_reg,
                    x8k_0257_sub_1346_reg,x8k_0347_sub_1256_reg,x8k_0356_sub_1247_reg;
// H7 H3+H7 H3-H7 H1357 H13-H57 H15-H37 H17-H35 H5+H7 H5-H7 H0+...+H7
// H0123-H4567 H4567 H0145-H2367 H45-H67 H2367 H23-H67 H26-H37 H27-H36 BLOCK
wire [30:0] H5_plus_H7_mult [2:0],H5_minus_H7_mult [2:0],H26_minus_37_mult [2:0],H27_minus_36_mult [2:0];
reg signed  [30:0] H5_plus_H7_mult_reg [2:0],H5_minus_H7_mult_reg [2:0],H26_minus_37_mult_reg [2:0],H27_minus_36_mult_reg [2:0];
reg signed  [30:0] H5_plus_H7_add_reg [1:0],H5_minus_H7_add_reg [1:0],H26_minus_37_add_reg [1:0],H27_minus_36_add_reg [1:0];
reg signed  [30:0] H5_plus_H7_stage_one_temp,H5_minus_H7_stage_one_temp,H26_minus_37_stage_one_temp,H27_minus_36_stage_one_temp;
wire [31:0] H7_mult [2:0],H1357_mult [2:0],H13_minus_57_mult [2:0],H15_minus_37_mult [2:0],H4567_mult [2:0],H0145_minus_2367_mult [1:0],H2367_mult [2:0],H3_plus_H7_mult [2:0],
                    H3_minus_H7_mult [2:0],H0123_minus_4567_mult [1:0];
reg signed [31:0] H7_mult_reg [2:0],H1357_mult_reg [2:0],H13_minus_57_mult_reg [2:0],H15_minus_37_mult_reg [2:0],H4567_mult_reg [2:0],H0145_minus_2367_mult_reg [1:0],
                    H2367_mult_reg [2:0],H3_plus_H7_mult_reg [2:0],H3_minus_H7_mult_reg [2:0],H0123_minus_4567_mult_reg [1:0];
reg signed [31:0] H7_add_reg [1:0],H1357_add_reg [1:0],H13_minus_57_add_reg [1:0],H15_minus_37_add_reg [1:0],H4567_add_reg [1:0],H0145_minus_2367_add_reg [1:0],
                    H2367_add_reg [1:0],H3_plus_H7_add_reg [1:0],H3_minus_H7_add_reg [1:0],H0123_minus_4567_add_reg [1:0];
reg signed [31:0] H7_stage_one_temp,H1357_stage_one_temp,H13_minus_57_stage_one_temp,H15_minus_37_stage_one_temp,H4567_stage_one_temp,H0145_minus_2367_stage_one_temp,
                    H2367_stage_one_temp,H3_plus_H7_stage_one_temp,H3_minus_H7_stage_one_temp,H0123_minus_4567_stage_one_temp;
wire [32:0] H17_minus_35_mult [2:0],H23_minus_67_mult [2:0],H45_minus_67_mult [2:0],H01234567_mult [1:0];
reg signed [32:0] H17_minus_35_mult_reg [2:0],H23_minus_67_mult_reg [2:0],H45_minus_67_mult_reg [2:0],H01234567_mult_reg [1:0];
reg signed [32:0] H17_minus_35_add_reg [1:0],H23_minus_67_add_reg [1:0],H45_minus_67_add_reg [1:0],H01234567_add_reg [1:0];
reg signed [32:0] H17_minus_35_stage_one_temp,H23_minus_67_stage_one_temp,H45_minus_67_stage_one_temp,H01234567_stage_one_temp;
//H0167-H2345 H6+H7 H6-H7 H0246-H1357 BLOCK
wire [31:0] H6_plus_H7_mult [2:0],H6_minus_H7_mult [2:0],H0246_minus_1357_mult [1:0];
reg signed [31:0] H6_plus_H7_mult_reg [2:0],H6_minus_H7_mult_reg [2:0],
                    H0246_minus_1357_mult_reg [1:0];
reg signed [31:0] H6_plus_H7_add_reg [1:0],H6_minus_H7_add_reg [1:0],H0246_minus_1357_add_reg [1:0];
reg signed [31:0] H6_plus_H7_stage_one_temp,H6_minus_H7_stage_one_temp,
                    H0246_minus_1357_stage_one_temp;
wire [33:0] H0167_minus_2345_mult [1:0];
reg signed [33:0] H0167_minus_2345_mult_reg [1:0];
reg signed [33:0] H0167_minus_2345_add_reg [1:0];
reg signed [33:0] H0167_minus_2345_stage_one_temp;
//H0257-H1346 H46-H57 H0347-H1256 H0356-H1247 H47-H56 BLOCK
wire [31:0] H46_minus_57_mult [2:0],H0356_minus_1247_mult [1:0];
reg signed [31:0] H46_minus_57_mult_reg [2:0],H0356_minus_1247_mult_reg [1:0];
reg signed [31:0] H46_minus_57_add_reg [1:0],H0356_minus_1247_add_reg [1:0];
reg signed [31:0] H46_minus_57_stage_one_temp,H0356_minus_1247_stage_one_temp;
wire [32:0] H0257_minus_1346_mult [1:0],H0347_minus_1256_mult [1:0],H47_minus_56_mult [2:0];
reg signed [32:0] H0257_minus_1346_mult_reg [1:0],H0347_minus_1256_mult_reg [1:0],H47_minus_56_mult_reg [2:0];
reg signed [32:0] H0257_minus_1346_add_reg [1:0],H0347_minus_1256_add_reg [1:0],H47_minus_56_add_reg [1:0];
reg signed [32:0] H0257_minus_1346_stage_one_temp,H0347_minus_1256_stage_one_temp,H47_minus_56_stage_one_temp;

reg signed [31:0] y8k_temp,y8k_temp2,y8k_temp3,y8k_temp4,y8k_temp5,y8k_temp6,y8k_temp7,y8k_temp8,y8k_temp9,y8k_temp10,y8k_temp11,y8k_temp12,y8k_temp13;
reg signed [31:0] y8k_1_temp,y8k_1_temp2,y8k_1_temp3,y8k_1_temp4,y8k_1_temp5;
reg signed [31:0] y8k_2_temp,y8k_2_temp2,y8k_2_temp3,y8k_2_temp4,y8k_2_temp5,y8k_2_temp6,y8k_2_temp7,y8k_2_temp8,y8k_2_temp9,y8k_2_temp10;
reg signed [31:0] y8k_3_temp,y8k_3_temp2,y8k_3_temp3,y8k_3_temp4,y8k_3_temp5,y8k_3_temp6;
reg signed [31:0] y8k_4_temp,y8k_4_temp2,y8k_4_temp3,y8k_4_temp4,y8k_4_temp5,y8k_4_temp6,y8k_4_temp7,y8k_4_temp8,y8k_4_temp9;
reg signed [31:0] y8k_5_temp,y8k_5_temp2,y8k_5_temp3,y8k_5_temp4,y8k_5_temp5;
reg signed [31:0] y8k_6_temp,y8k_6_temp2,y8k_6_temp3,y8k_6_temp4,y8k_6_temp5,y8k_6_temp6,y8k_6_temp7,y8k_6_temp8,y8k_7_temp;
wire signed [31:0] s,t,u,v,w,x,y,z;


///************H7 BLOCK ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_7_reg<=0;
        x8k_7_2_reg<=0;  
    end
    else begin
        x8k_7_reg<=x8k_7;
        x8k_7_2_reg<=x8k_7_reg;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H7_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
             H7_mult_reg[j]<=H7_mult[j];
        end
    end
end

CSD_CSA0 H70(.x(x8k_7_2_reg) ,.y(H7_mult[0]));
CSD_CSA1 H71(.x(x8k_7_2_reg) ,.y(H7_mult[1]));
CSD_CSA2 H72(.x(x8k_7_2_reg) ,.y(H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H7_stage_one_temp<=0;
    end
    else begin
        H7_stage_one_temp<=H7_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H7_add_reg[j]<=0;
        end
    end
    else begin
        H7_add_reg[1] <= H7_stage_one_temp + H7_mult_reg[1];        
        H7_add_reg[0]<=H7_add_reg[1] + H7_mult_reg[0];
    end
end

//******************H3 + H7 && H3 - H7***********************

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_3_add_x8k_7_reg<=0;
        x8k_3_add_x8k_7_2_reg<=0;        
        x8k_3_sub_x8k_7_reg<=0;
        x8k_3_sub_x8k_7_2_reg<=0;        
    end
    else begin
        x8k_3_sub_x8k_7_reg<=(x8k_3 >>> 1) - (x8k_7 >>> 1);
        x8k_3_sub_x8k_7_2_reg<=x8k_3_sub_x8k_7_reg;        
        x8k_3_add_x8k_7_reg<=(x8k_3 >>> 1) + (x8k_7 >>> 1);
        x8k_3_add_x8k_7_2_reg<=x8k_3_add_x8k_7_reg;                
    end
end

CSD_CSA3 H3H7(.x(x8k_3_add_x8k_7_2_reg) ,.y(H3_plus_H7_mult[0]));
CSD_CSA4 H3H7_1(.x(x8k_3_add_x8k_7_2_reg) ,.y(H3_plus_H7_mult[1]));
CSD_CSA5 H3H7_2(.x(x8k_3_add_x8k_7_2_reg) ,.y(H3_plus_H7_mult[2]));
CSD_CSA6 H3H7_3(.x(x8k_3_sub_x8k_7_2_reg) ,.y(H3_minus_H7_mult[0]));
CSD_CSA7 H3H7_4(.x(x8k_3_sub_x8k_7_2_reg) ,.y(H3_minus_H7_mult[1]));
CSD_CSA8 H3H7_5(.x(x8k_3_sub_x8k_7_2_reg) ,.y(H3_minus_H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H3_plus_H7_mult_reg[j]<=0;
            H3_minus_H7_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H3_plus_H7_mult_reg[j]<=H3_plus_H7_mult[j];
            H3_minus_H7_mult_reg[j]<=H3_minus_H7_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H3_plus_H7_stage_one_temp<=0;
        H3_minus_H7_stage_one_temp<=0;
    end
    else begin
        H3_plus_H7_stage_one_temp<=H3_plus_H7_mult_reg[2];
        H3_minus_H7_stage_one_temp<=H3_minus_H7_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H3_plus_H7_add_reg[j]<=0;
            H3_minus_H7_add_reg[j]<=0;
        end
    end
    else begin
        H3_plus_H7_add_reg[1] <= H3_plus_H7_stage_one_temp + H3_plus_H7_mult_reg[1];
        H3_plus_H7_add_reg[0]<= H3_plus_H7_mult_reg[0] + H3_plus_H7_add_reg[1];        
        H3_minus_H7_add_reg[1] <= H3_minus_H7_stage_one_temp + H3_minus_H7_mult_reg[1];
        H3_minus_H7_add_reg[0]<= H3_minus_H7_mult_reg[0] + H3_minus_H7_add_reg[1]; 
    end
end

//******************H5 + H7 && H5 - H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_5_add_x8k_7_reg<=0;
        x8k_5_add_x8k_7_2_reg<=0;        
        x8k_5_sub_x8k_7_reg<=0;
        x8k_5_sub_x8k_7_2_reg<=0;                
    end
    else begin
        x8k_5_sub_x8k_7_reg<=(x8k_5 >>> 1) - (x8k_7 >>> 1);
        x8k_5_sub_x8k_7_2_reg<=x8k_5_sub_x8k_7_reg;        
        x8k_5_add_x8k_7_reg<=(x8k_5 >>> 1) + (x8k_7 >>> 1); 
        x8k_5_add_x8k_7_2_reg<=x8k_5_add_x8k_7_reg;                
    end
end

CSD_CSA15 H5H7(.x(x8k_5_add_x8k_7_2_reg) ,.y(H5_plus_H7_mult[0]));
CSD_CSA16 H5H7_1(.x(x8k_5_add_x8k_7_2_reg) ,.y(H5_plus_H7_mult[1]));
CSD_CSA17 H5H7_2(.x(x8k_5_add_x8k_7_2_reg) ,.y(H5_plus_H7_mult[2]));
CSD_CSA18 H5H7_3(.x(x8k_5_sub_x8k_7_2_reg) ,.y(H5_minus_H7_mult[0]));
CSD_CSA19 H5H7_4(.x(x8k_5_sub_x8k_7_2_reg) ,.y(H5_minus_H7_mult[1]));
CSD_CSA20 H5H7_5(.x(x8k_5_sub_x8k_7_2_reg) ,.y(H5_minus_H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H5_plus_H7_mult_reg[j]<=0;
            H5_minus_H7_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H5_plus_H7_mult_reg[j]<=H5_plus_H7_mult[j];
            H5_minus_H7_mult_reg[j]<=H5_minus_H7_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H5_plus_H7_stage_one_temp<=0;
        H5_minus_H7_stage_one_temp<=0;
    end
    else begin
        H5_plus_H7_stage_one_temp<=H5_plus_H7_mult_reg[2];
        H5_minus_H7_stage_one_temp<=H5_minus_H7_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H5_plus_H7_add_reg[j]<=0;
            H5_minus_H7_add_reg[j]<=0;
        end
    end
    else begin
        H5_plus_H7_add_reg[1] <= H5_plus_H7_stage_one_temp + H5_plus_H7_mult_reg[1];
        H5_plus_H7_add_reg[0]<= H5_plus_H7_mult_reg[0] + H5_plus_H7_add_reg[1];        
        H5_minus_H7_add_reg[1] <= H5_minus_H7_stage_one_temp + H5_minus_H7_mult_reg[1];
        H5_minus_H7_add_reg[0]<= H5_minus_H7_mult_reg[0] + H5_minus_H7_add_reg[1]; 
    end
end

//******************H1357 && H13-H57 && H15-H37 && H17-H35***********************

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_1357_reg<=0;
        x8k_1357_2_reg<=0;        
        x8k_13_sub_57_reg<=0;
        x8k_13_sub_57_2_reg<=0;        
        x8k_15_sub_37_reg<=0;
        x8k_15_sub_37_2_reg<=0;        
        x8k_17_sub_35_reg<=0;
        x8k_17_sub_35_2_reg<=0;        
    end
    else begin
        x8k_1357_reg<=((x8k_1 >>> 1) + (x8k_3 >>> 1)) + ((x8k_5 >>> 1) + (x8k_7 >>> 1));                        
        x8k_1357_2_reg<=x8k_1357_reg;        
        x8k_13_sub_57_reg<=((x8k_1 >>> 1) + (x8k_3 >>> 1)) - ((x8k_5 >>> 1) + (x8k_7 >>> 1));
        x8k_13_sub_57_2_reg<=x8k_13_sub_57_reg;        
        x8k_15_sub_37_reg<=((x8k_1 >>> 1) + (x8k_5 >>> 1)) - ((x8k_3 >>> 1) + (x8k_7 >>> 1));
        x8k_15_sub_37_2_reg<=x8k_15_sub_37_reg;        
        x8k_17_sub_35_reg<=((x8k_1 >>> 1) + (x8k_7 >>> 1)) - ((x8k_3 >>> 1) + (x8k_5 >>> 1));
        x8k_17_sub_35_2_reg<=x8k_17_sub_35_reg;        
    end
end

CSD_CSA9 H1357_0(.x(x8k_1357_2_reg) ,.y(H1357_mult[0]));
CSD_CSA10 H1357_1(.x(x8k_1357_2_reg) ,.y(H1357_mult[1]));
CSD_CSA11 H1357_2(.x(x8k_1357_2_reg) ,.y(H1357_mult[2]));
CSD_CSA12 H1357_3(.x(x8k_13_sub_57_2_reg) ,.y(H13_minus_57_mult[0]));
CSD_CSA13 H1357_4(.x(x8k_13_sub_57_2_reg) ,.y(H13_minus_57_mult[1]));
CSD_CSA14 H1357_5(.x(x8k_13_sub_57_2_reg) ,.y(H13_minus_57_mult[2]));
CSD_CSA21 H1357_6(.x(x8k_15_sub_37_2_reg) ,.y(H15_minus_37_mult[0]));
CSD_CSA22 H1357_7(.x(x8k_15_sub_37_2_reg) ,.y(H15_minus_37_mult[1]));
CSD_CSA23 H1357_8(.x(x8k_15_sub_37_2_reg) ,.y(H15_minus_37_mult[2]));
CSD_CSA24 H1357_9(.x(x8k_17_sub_35_2_reg) ,.y(H17_minus_35_mult[0]));
CSD_CSA25 H1357_10(.x(x8k_17_sub_35_2_reg) ,.y(H17_minus_35_mult[1]));
CSD_CSA26 H1357_11(.x(x8k_17_sub_35_2_reg) ,.y(H17_minus_35_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H1357_mult_reg[j]<=0;
            H13_minus_57_mult_reg[j]<=0;
            H15_minus_37_mult_reg[j]<=0;
            H17_minus_35_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H1357_mult_reg[j]<=H1357_mult[j];
            H13_minus_57_mult_reg[j]<=H13_minus_57_mult[j];
            H15_minus_37_mult_reg[j]<=H15_minus_37_mult[j];
            H17_minus_35_mult_reg[j]<=H17_minus_35_mult[j];  
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1357_stage_one_temp<=0;
        H15_minus_37_stage_one_temp<=0;
        H17_minus_35_stage_one_temp<=0;
        H13_minus_57_stage_one_temp<=0;        
    end
    else begin
        H1357_stage_one_temp<=H1357_mult_reg[2];
        H15_minus_37_stage_one_temp<=H15_minus_37_mult_reg[2];
        H13_minus_57_stage_one_temp<=H13_minus_57_mult_reg[2];
        H17_minus_35_stage_one_temp<=H17_minus_35_mult_reg[2];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H1357_add_reg[j]<=0;
            H15_minus_37_add_reg[j]<=0;
            H13_minus_57_add_reg[j]<=0;
            H17_minus_35_add_reg[j]<=0;  
        end
    end
    else begin
        H1357_add_reg[1]<=H1357_stage_one_temp + H1357_mult_reg[1];
        H15_minus_37_add_reg[1]<=H15_minus_37_stage_one_temp + H15_minus_37_mult_reg[1];
        H13_minus_57_add_reg[1]<=H13_minus_57_stage_one_temp + H13_minus_57_mult_reg[1];
        H17_minus_35_add_reg[1]<=H17_minus_35_stage_one_temp + H17_minus_35_mult_reg[1];        
        H1357_add_reg[0]<=H1357_add_reg[1] + H1357_mult_reg[0];
        H15_minus_37_add_reg[0]<=H15_minus_37_add_reg[1] + H15_minus_37_mult_reg[0];
        H17_minus_35_add_reg[0]<=H17_minus_35_add_reg[1] + H17_minus_35_mult_reg[0];
        H13_minus_57_add_reg[0]<=H13_minus_57_add_reg[1] + H13_minus_57_mult_reg[0];
        
    end
end

//******************H01234567 && H0123-H4567***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0123_reg<=0;
        x8k_01234567_reg<=0;        
        x8k_0123_sub_4567_reg<=0;
    end
    else begin
        x8k_0123_reg<=((x8k >>> 1) + (x8k_1 >>> 1)) + ((x8k_2 >>> 1) + (x8k_3 >>> 1));
        x8k_01234567_reg<=x8k_0123_reg + x8k_4567_reg;
        x8k_0123_sub_4567_reg<=x8k_0123_reg - x8k_4567_reg;
    end
end

CSD_CSA27 H01234567_0(.x(x8k_01234567_reg) ,.y(H01234567_mult[0]));
CSD_CSA28 H01234567_1(.x(x8k_01234567_reg) ,.y(H01234567_mult[1]));
CSD_CSA29 H01234567_2(.x(x8k_0123_sub_4567_reg) ,.y(H0123_minus_4567_mult[0]));
CSD_CSA30 H01234567_3(.x(x8k_0123_sub_4567_reg) ,.y(H0123_minus_4567_mult[1]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0123_minus_4567_mult_reg[j]<=0;
            H01234567_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H0123_minus_4567_mult_reg[j]<=H0123_minus_4567_mult[j];
            H01234567_mult_reg[j]<=H01234567_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0123_minus_4567_stage_one_temp<=0;
        H01234567_stage_one_temp<=0;        
    end
    else begin
        H0123_minus_4567_stage_one_temp<=H0123_minus_4567_mult_reg[0];
        H01234567_stage_one_temp<=H01234567_mult_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0123_minus_4567_add_reg[j]<=0;            
            H01234567_add_reg[j]<=0;
        end
    end
    else begin
        H0123_minus_4567_add_reg[1]<=H0123_minus_4567_stage_one_temp + H0123_minus_4567_mult_reg[1];        
        H01234567_add_reg[1]<=H01234567_stage_one_temp + H01234567_mult_reg[1];
        H0123_minus_4567_add_reg[0]<=H0123_minus_4567_add_reg[1] - H0123_minus_4567_mult_reg[0];
        H01234567_add_reg[0]<=H01234567_add_reg[1] + H01234567_mult_reg[0];        
    end
end


//******************H4567 && H45-H67***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n)  begin
        x8k_4567_reg<=0;
        x8k_4567_2_reg<=0;        
        x8k_45_sub_67_reg<=0;
        x8k_45_sub_67_2_reg<=0;        
    end
    else begin
        x8k_4567_reg<=((x8k_4 >>> 1) + (x8k_5 >>> 1)) + ((x8k_6 >>> 1) + (x8k_7 >>> 1));
        x8k_4567_2_reg<=x8k_4567_reg;        
        x8k_45_sub_67_reg<=((x8k_4 >>> 1) + (x8k_5 >>> 1)) - ((x8k_6 >>> 1) + (x8k_7 >>> 1));
        x8k_45_sub_67_2_reg<=x8k_45_sub_67_reg;        
    end
end

CSD_CSA31 H4567(.x(x8k_4567_2_reg) ,.y(H4567_mult[0]));
CSD_CSA32 H4567_1(.x(x8k_4567_2_reg) ,.y(H4567_mult[1]));
CSD_CSA33 H4567_2(.x(x8k_4567_2_reg) ,.y(H4567_mult[2]));
CSD_CSA38 H4567_3(.x(x8k_45_sub_67_2_reg) ,.y(H45_minus_67_mult[0]));
CSD_CSA39 H4567_4(.x(x8k_45_sub_67_2_reg) ,.y(H45_minus_67_mult[1]));
CSD_CSA40 H4567_5(.x(x8k_45_sub_67_2_reg) ,.y(H45_minus_67_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H4567_mult_reg[j]<=0;
            H45_minus_67_mult_reg[j]<=0; 
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H4567_mult_reg[j]<=H4567_mult[j];
            H45_minus_67_mult_reg[j]<=H45_minus_67_mult[j];
        end
            
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H4567_stage_one_temp<=0;
        H45_minus_67_stage_one_temp<=0;        
    end
    else begin
        H4567_stage_one_temp<=H4567_mult_reg[2];
        H45_minus_67_stage_one_temp<=H45_minus_67_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H4567_add_reg[j]<=0;
            H45_minus_67_add_reg[j]<=0;
        end
    end
    else begin
        H4567_add_reg[1] <= H4567_stage_one_temp + H4567_mult_reg[1];
        H45_minus_67_add_reg[1] <= H45_minus_67_stage_one_temp + H45_minus_67_mult_reg[1];        
        H4567_add_reg[0]<= H4567_mult_reg[0] + H4567_add_reg[1];
        H45_minus_67_add_reg[0]<= H45_minus_67_mult_reg[0] + H45_minus_67_add_reg[1];        
    end
end

//******************H0167-H2345 && H0145-H2367***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0145_sub_2367_reg<=0;
        x8k_0145_reg<=0; 
        x8k_2367_reg<=0;        
        x8k_0167_sub_2345_reg<=0;
        x8k_0167_reg<=0;
        x8k_2345_reg<=0;        
    end
    else begin
        x8k_0145_reg<=((x8k >>> 1) + (x8k_1 >>> 1)) + ((x8k_4 >>> 1) + (x8k_5 >>> 1));     
        x8k_2367_reg<=((x8k_2 >>> 1) + (x8k_3 >>> 1)) + ((x8k_6 >>> 1) + (x8k_7 >>> 1));     
        x8k_0145_sub_2367_reg<=x8k_0145_reg - x8k_2367_reg;
        x8k_0167_reg<=((x8k >>> 1) + (x8k_1 >>> 1)) + ((x8k_6 >>> 1) + (x8k_7 >>> 1));
        x8k_2345_reg<=((x8k_2 >>> 1) + (x8k_3 >>> 1)) + ((x8k_4 >>> 1) + (x8k_5 >>> 1));             
        x8k_0167_sub_2345_reg<=x8k_0167_reg - x8k_2345_reg;
    end
end

CSD_CSA36 H01672345_0(.x(x8k_0167_sub_2345_reg) ,.y(H0167_minus_2345_mult[0]));
CSD_CSA37 H01672345_1(.x(x8k_0167_sub_2345_reg) ,.y(H0167_minus_2345_mult[1]));
CSD_CSA34 H01452367_0(.x(x8k_0145_sub_2367_reg) ,.y(H0145_minus_2367_mult[0]));
CSD_CSA35 H01452367_1(.x(x8k_0145_sub_2367_reg) ,.y(H0145_minus_2367_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0145_minus_2367_mult_reg[j]<=0;
            H0167_minus_2345_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H0145_minus_2367_mult_reg[j]<=H0145_minus_2367_mult[j];
            H0167_minus_2345_mult_reg[j]<=H0167_minus_2345_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0145_minus_2367_stage_one_temp<=0;
        H0167_minus_2345_stage_one_temp<=0;        
    end
    else begin
        H0145_minus_2367_stage_one_temp<=H0145_minus_2367_mult_reg[0];
        H0167_minus_2345_stage_one_temp<=H0167_minus_2345_mult_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0145_minus_2367_add_reg[j]<=0;            
            H0167_minus_2345_add_reg[j]<=0;
        end
    end
    else begin
        H0145_minus_2367_add_reg[1]<=H0145_minus_2367_stage_one_temp + H0145_minus_2367_mult_reg[1];        
        H0167_minus_2345_add_reg[1]<=H0167_minus_2345_stage_one_temp + H0167_minus_2345_mult_reg[1];
        H0145_minus_2367_add_reg[0]<=H0145_minus_2367_add_reg[1] - H0145_minus_2367_mult_reg[0];
        H0167_minus_2345_add_reg[0]<=H0167_minus_2345_add_reg[1] + H0167_minus_2345_mult_reg[0];        
    end
end

//******************H2367 && H23-H67 && H26-H37 && H27-H36***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_2367_2_reg<=0;        
        x8k_23_sub_67_reg<=0;
        x8k_23_sub_67_2_reg<=0;        
        x8k_26_sub_37_reg<=0;
        x8k_26_sub_37_2_reg<=0;        
        x8k_27_sub_36_reg<=0;
        x8k_27_sub_36_2_reg<=0;                
    end
    else begin
        x8k_2367_2_reg<=x8k_2367_reg;
        x8k_23_sub_67_reg<=((x8k_2 >>> 1) + (x8k_3 >>> 1)) - ((x8k_6 >>> 1) + (x8k_7 >>> 1));
        x8k_23_sub_67_2_reg<=x8k_23_sub_67_reg;
        x8k_26_sub_37_reg<=((x8k_2 >>> 1) + (x8k_6 >>> 1)) - ((x8k_3 >>> 1) + (x8k_7 >>> 1));
        x8k_26_sub_37_2_reg<=x8k_26_sub_37_reg;
        x8k_27_sub_36_reg<=((x8k_2 >>> 1) + (x8k_7 >>> 1)) - ((x8k_3 >>> 1) + (x8k_6 >>> 1)); 
        x8k_27_sub_36_2_reg<=x8k_27_sub_36_reg;
    end
end

CSD_CSA41 H2367_0(.x(x8k_2367_2_reg) ,.y(H2367_mult[0]));
CSD_CSA42 H2367_1(.x(x8k_2367_2_reg) ,.y(H2367_mult[1]));
CSD_CSA43 H2367_2(.x(x8k_2367_2_reg) ,.y(H2367_mult[2]));
CSD_CSA44 H2367_3(.x(x8k_23_sub_67_2_reg) ,.y(H23_minus_67_mult[0]));
CSD_CSA72 H2367_4(.x(x8k_23_sub_67_2_reg) ,.y(H23_minus_67_mult[1]));
CSD_CSA45 H2367_5(.x(x8k_23_sub_67_2_reg) ,.y(H23_minus_67_mult[2]));
CSD_CSA52 H2637_0(.x(x8k_26_sub_37_2_reg) ,.y(H26_minus_37_mult[0]));
CSD_CSA53 H2637_1(.x(x8k_26_sub_37_2_reg) ,.y(H26_minus_37_mult[1]));
CSD_CSA54 H2637_2(.x(x8k_26_sub_37_2_reg) ,.y(H26_minus_37_mult[2]));
CSD_CSA55 H2736_0(.x(x8k_27_sub_36_2_reg) ,.y(H27_minus_36_mult[0]));
CSD_CSA56 H2736_1(.x(x8k_27_sub_36_2_reg) ,.y(H27_minus_36_mult[1]));
CSD_CSA57 H2736_2(.x(x8k_27_sub_36_2_reg) ,.y(H27_minus_36_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H26_minus_37_mult_reg[j]<=0;
            H27_minus_36_mult_reg[j]<=0;
            H23_minus_67_mult_reg[j]<=0;            
            H2367_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H26_minus_37_mult_reg[j]<=H26_minus_37_mult[j];
            H27_minus_36_mult_reg[j]<=H27_minus_36_mult[j];
            H23_minus_67_mult_reg[j]<=H23_minus_67_mult[j];            
            H2367_mult_reg[j]<=H2367_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H27_minus_36_stage_one_temp<=0;
        H26_minus_37_stage_one_temp<=0;
        H23_minus_67_stage_one_temp<=0;        
        H2367_stage_one_temp<=0;        
    end
    else begin
        H27_minus_36_stage_one_temp<=H27_minus_36_mult_reg[2];
        H26_minus_37_stage_one_temp<=H26_minus_37_mult_reg[2];
        H23_minus_67_stage_one_temp<=H23_minus_67_mult_reg[2];        
        H2367_stage_one_temp<=H2367_mult_reg[2];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H26_minus_37_add_reg[j]<=0;  
            H23_minus_67_add_reg[j]<=0;            
            H27_minus_36_add_reg[j]<=0;                        
            H2367_add_reg[j]<=0;
        end
    end
    else begin
        H23_minus_67_add_reg[1]<=H23_minus_67_stage_one_temp + H23_minus_67_mult_reg[1];        
        H2367_add_reg[1]<=H2367_stage_one_temp + H2367_mult_reg[1];
        H23_minus_67_add_reg[0]<=H23_minus_67_add_reg[1] + H23_minus_67_mult_reg[0];
        H2367_add_reg[0]<=H2367_add_reg[1] + H2367_mult_reg[0]; 
        H26_minus_37_add_reg[1]<=H26_minus_37_stage_one_temp + H26_minus_37_mult_reg[1];        
        H27_minus_36_add_reg[1]<=H27_minus_36_stage_one_temp + H27_minus_36_mult_reg[1];
        H26_minus_37_add_reg[0]<=H26_minus_37_add_reg[1] + H26_minus_37_mult_reg[0];
        H27_minus_36_add_reg[0]<=H27_minus_36_add_reg[1] + H27_minus_36_mult_reg[0];        
    end
end

//******************H6 + H7 && H6 - H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_6_add_x8k_7_reg<=0;
        x8k_6_add_x8k_7_2_reg<=0;
        x8k_6_sub_x8k_7_reg<=0;
        x8k_6_sub_x8k_7_2_reg<=0;        
    end
    else begin
        x8k_6_add_x8k_7_reg<=(x8k_6 >>> 1) + (x8k_7 >>> 1);
        x8k_6_add_x8k_7_2_reg<=x8k_6_add_x8k_7_reg;
        x8k_6_sub_x8k_7_reg<=(x8k_6 >>> 1) - (x8k_7 >>> 1);
        x8k_6_sub_x8k_7_2_reg<=x8k_6_sub_x8k_7_reg;      
    end
end

CSD_CSA46 H6H7(.x(x8k_6_add_x8k_7_2_reg) ,.y(H6_plus_H7_mult[0]));
CSD_CSA47 H6H7_1(.x(x8k_6_add_x8k_7_2_reg) ,.y(H6_plus_H7_mult[1]));
CSD_CSA48 H6H7_2(.x(x8k_6_add_x8k_7_2_reg) ,.y(H6_plus_H7_mult[2]));
CSD_CSA49 H6H7_3(.x(x8k_6_sub_x8k_7_2_reg) ,.y(H6_minus_H7_mult[0]));
CSD_CSA50 H6H7_4(.x(x8k_6_sub_x8k_7_2_reg) ,.y(H6_minus_H7_mult[1]));
CSD_CSA51 H6H7_5(.x(x8k_6_sub_x8k_7_2_reg) ,.y(H6_minus_H7_mult[2]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H6_plus_H7_mult_reg[j]<=0;
            H6_minus_H7_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H6_plus_H7_mult_reg[j]<=H6_plus_H7_mult[j];
            H6_minus_H7_mult_reg[j]<=H6_minus_H7_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H6_plus_H7_stage_one_temp<=0;
        H6_minus_H7_stage_one_temp<=0;
    end
    else begin 
        H6_plus_H7_stage_one_temp<=H6_plus_H7_mult_reg[2];
        H6_minus_H7_stage_one_temp<=H6_minus_H7_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H6_plus_H7_add_reg[j]<=0;
            H6_minus_H7_add_reg[j]<=0;
        end
    end
    else begin
        H6_plus_H7_add_reg[1] <= H6_plus_H7_stage_one_temp + H6_plus_H7_mult_reg[1];
        H6_minus_H7_add_reg[1] <= H6_minus_H7_stage_one_temp + H6_minus_H7_mult_reg[1];        
        H6_plus_H7_add_reg[0]<= H6_plus_H7_mult_reg[0] + H6_plus_H7_add_reg[1];
        H6_minus_H7_add_reg[0]<= H6_minus_H7_mult_reg[0] + H6_minus_H7_add_reg[1];        
    end
end

//******************H0246-H1357 && H0257-H1346***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0246_sub_1357_reg<=0;
        x8k_0246_reg<=0;
        x8k_0257_sub_1346_reg<=0;
        x8k_0257_reg<=0;
        x8k_1346_reg<=0;        
    end
    else begin
        x8k_0246_sub_1357_reg<=x8k_0246_reg - x8k_1357_reg;
        x8k_0246_reg<=((x8k >>> 1) + (x8k_2 >>> 1)) + ((x8k_4 >>> 1) + (x8k_6 >>> 1));        
        x8k_0257_sub_1346_reg<=x8k_0257_reg - x8k_1346_reg;
        x8k_0257_reg<=((x8k >>> 1) + (x8k_2 >>> 1)) + ((x8k_5 >>> 1) + (x8k_7 >>> 1));
        x8k_1346_reg<=((x8k_1 >>> 1) + (x8k_3 >>> 1)) + ((x8k_4 >>> 1) + (x8k_6 >>> 1));        
    end
end

CSD_CSA58 H02461357_0(.x(x8k_0246_sub_1357_reg) ,.y(H0246_minus_1357_mult[0]));
CSD_CSA59 H02461357_1(.x(x8k_0246_sub_1357_reg) ,.y(H0246_minus_1357_mult[1]));
CSD_CSA60 H02571346_0(.x(x8k_0257_sub_1346_reg) ,.y(H0257_minus_1346_mult[0]));
CSD_CSA61 H02571346_1(.x(x8k_0257_sub_1346_reg) ,.y(H0257_minus_1346_mult[1]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0257_minus_1346_mult_reg[j]<=0;
            H0246_minus_1357_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H0257_minus_1346_mult_reg[j]<=H0257_minus_1346_mult[j];
            H0246_minus_1357_mult_reg[j]<=H0246_minus_1357_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0257_minus_1346_stage_one_temp<=0;
        H0246_minus_1357_stage_one_temp<=0;        
    end
    else begin
        H0257_minus_1346_stage_one_temp<=H0257_minus_1346_mult_reg[0];
        H0246_minus_1357_stage_one_temp<=H0246_minus_1357_mult_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0257_minus_1346_add_reg[j]<=0;            
            H0246_minus_1357_add_reg[j]<=0;
        end
    end
    else begin
        H0257_minus_1346_add_reg[1]<=H0257_minus_1346_stage_one_temp + H0257_minus_1346_mult_reg[1];        
        H0246_minus_1357_add_reg[1]<=H0246_minus_1357_stage_one_temp - H0246_minus_1357_mult_reg[1];
        H0257_minus_1346_add_reg[0]<=H0257_minus_1346_add_reg[1] + H0257_minus_1346_mult_reg[0];
        H0246_minus_1357_add_reg[0]<=H0246_minus_1357_add_reg[1] + H0246_minus_1357_mult_reg[0];        
    end
end

//******************H46-H57 && H47-H56***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n)  begin
        x8k_46_sub_57_reg<=0;
        x8k_46_sub_57_2_reg<=0;        
        x8k_47_sub_56_reg<=0;
        x8k_47_sub_56_2_reg<=0;        
    end
    else begin
        x8k_46_sub_57_reg<=((x8k_4 >>> 1) + (x8k_6 >>> 1)) - ((x8k_5 >>> 1) + (x8k_7 >>> 1));
        x8k_46_sub_57_2_reg<=x8k_46_sub_57_reg;
        x8k_47_sub_56_reg<=((x8k_4 >>> 1) + (x8k_7 >>> 1)) - ((x8k_5 >>> 1) + (x8k_6 >>> 1));
        x8k_47_sub_56_2_reg<=x8k_47_sub_56_reg;
    end
end

CSD_CSA62 H4657(.x(x8k_46_sub_57_2_reg) ,.y(H46_minus_57_mult[0]));
CSD_CSA63 H4657_1(.x(x8k_46_sub_57_2_reg) ,.y(H46_minus_57_mult[1]));
CSD_CSA64 H4657_2(.x(x8k_46_sub_57_2_reg) ,.y(H46_minus_57_mult[2]));
CSD_CSA69 H4756_0(.x(x8k_47_sub_56_2_reg) ,.y(H47_minus_56_mult[0]));
CSD_CSA70 H4756_1(.x(x8k_47_sub_56_2_reg) ,.y(H47_minus_56_mult[1]));
CSD_CSA71 H4756_2(.x(x8k_47_sub_56_2_reg) ,.y(H47_minus_56_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H46_minus_57_mult_reg[j]<=0;
            H47_minus_56_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H46_minus_57_mult_reg[j]<=H46_minus_57_mult[j];
            H47_minus_56_mult_reg[j]<=H47_minus_56_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H46_minus_57_stage_one_temp<=0;
        H47_minus_56_stage_one_temp<=0;        
    end
    else begin
        H46_minus_57_stage_one_temp<=H46_minus_57_mult_reg[2];
        H47_minus_56_stage_one_temp<=H47_minus_56_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H46_minus_57_add_reg[j]<=0;
            H47_minus_56_add_reg[j]<=0;
        end
    end
    else begin
        H46_minus_57_add_reg[1] <= H46_minus_57_stage_one_temp + H46_minus_57_mult_reg[1];
        H47_minus_56_add_reg[1] <= H47_minus_56_stage_one_temp + H47_minus_56_mult_reg[1];        
        H46_minus_57_add_reg[0]<= H46_minus_57_mult_reg[0] + H46_minus_57_add_reg[1];
        H47_minus_56_add_reg[0]<= H47_minus_56_mult_reg[0] + H47_minus_56_add_reg[1];        
    end
end

//******************H0347-H1256 && H0356-H1247***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0347_sub_1256_reg<=0;
        x8k_0347_reg<=0;  
        x8k_1256_reg<=0;        
        x8k_0356_sub_1247_reg<=0;
        x8k_0356_reg<=0;   
        x8k_1247_reg<=0;        
    end
    else begin
        x8k_0347_sub_1256_reg<=x8k_0347_reg - x8k_1256_reg;
        x8k_0347_reg<=((x8k >>> 1) + (x8k_3 >>> 1)) + ((x8k_4 >>> 1) + (x8k_7 >>> 1));
        x8k_1256_reg<=((x8k_1 >>> 1) + (x8k_2 >>> 1)) + ((x8k_5 >>> 1) + (x8k_6 >>> 1));       
        x8k_0356_sub_1247_reg<=x8k_0356_reg - x8k_1247_reg;
        x8k_0356_reg<=((x8k >>> 1) + (x8k_3 >>> 1)) + ((x8k_5 >>> 1) + (x8k_6 >>> 1)); 
        x8k_1247_reg<=((x8k_1 >>> 1) + (x8k_2 >>> 1)) + ((x8k_4 >>> 1) + (x8k_7 >>> 1));               
    end
end

CSD_CSA65 H03471256_0(.x(x8k_0347_sub_1256_reg) ,.y(H0347_minus_1256_mult[0]));
CSD_CSA66 H03471256_1(.x(x8k_0347_sub_1256_reg) ,.y(H0347_minus_1256_mult[1]));
CSD_CSA67 H03561247_0(.x(x8k_0356_sub_1247_reg) ,.y(H0356_minus_1247_mult[0]));
CSD_CSA68 H03561247_1(.x(x8k_0356_sub_1247_reg) ,.y(H0356_minus_1247_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0356_minus_1247_mult_reg[j]<=0;
            H0347_minus_1256_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H0356_minus_1247_mult_reg[j]<=H0356_minus_1247_mult[j];
            H0347_minus_1256_mult_reg[j]<=H0347_minus_1256_mult[j];            
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0356_minus_1247_stage_one_temp<=0;
        H0347_minus_1256_stage_one_temp<=0;        
    end
    else begin
        H0356_minus_1247_stage_one_temp<=H0356_minus_1247_mult_reg[0];
        H0347_minus_1256_stage_one_temp<=H0347_minus_1256_mult_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0356_minus_1247_add_reg[j]<=0;            
            H0347_minus_1256_add_reg[j]<=0;
        end
    end
    else begin
        H0356_minus_1247_add_reg[1]<=H0356_minus_1247_stage_one_temp + H0356_minus_1247_mult_reg[1];        
        H0347_minus_1256_add_reg[1]<=H0347_minus_1256_stage_one_temp + H0347_minus_1256_mult_reg[1];
        H0356_minus_1247_add_reg[0]<=H0356_minus_1247_add_reg[1] - H0356_minus_1247_mult_reg[0];
        H0347_minus_1256_add_reg[0]<=H0347_minus_1256_add_reg[1] + H0347_minus_1256_mult_reg[0];        
    end
end

//***************************************

/*assign w = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] - H4567_add_reg[0] + H0145_minus_2367_add_reg[0] + H0167_minus_2345_add_reg[0] - H45_minus_67_add_reg[0] -
            H2367_add_reg[0] - H23_minus_67_add_reg[0] + H6_minus_H7_add_reg[0] + H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] - 
            H46_minus_57_add_reg[0] + H0347_minus_1256_add_reg[0] + H0356_minus_1247_add_reg[0] - H47_minus_56_add_reg[0] - H26_minus_37_add_reg[0] - 
            H27_minus_36_add_reg[0] + H6_plus_H7_add_reg[0] - H1357_add_reg[0] - H13_minus_57_add_reg[0] + H5_plus_H7_add_reg[0] - H17_minus_35_add_reg[0] -
            H15_minus_37_add_reg[0] + H5_minus_H7_add_reg[0] + H3_plus_H7_add_reg[0] + H3_minus_H7_add_reg[0] - H7_add_reg[0] + y8k_temp;
assign x = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] - H4567_add_reg[0] + H0145_minus_2367_add_reg[0] + H0167_minus_2345_add_reg[0] - H45_minus_67_add_reg[0] -
            H2367_add_reg[0] - H23_minus_67_add_reg[0] + H6_plus_H7_add_reg[0] - H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0] + 
            H46_minus_57_add_reg[0] - H0347_minus_1256_add_reg[0] - H0356_minus_1247_add_reg[0] + H47_minus_56_add_reg[0] + H26_minus_37_add_reg[0] +
            H27_minus_36_add_reg[0] - H6_minus_H7_add_reg[0] + y8k_1_temp;
assign y = H01234567_add_reg[0] + H0123_minus_4567_add_reg[0] - H4567_add_reg[0] - H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0] + H45_minus_67_add_reg[0] +
            H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] - H46_minus_57_add_reg[0] - H0347_minus_1256_add_reg[0] - H0356_minus_1247_add_reg[0] + 
            H47_minus_56_add_reg[0] + 2*H17_minus_35_add_reg[0] + 2*H15_minus_37_add_reg[0] - 2*H5_minus_H7_add_reg[0] - H3_plus_H7_add_reg[0] - H3_minus_H7_add_reg[0] +
            H7_add_reg[0] + y8k_2_temp;
assign z = H01234567_add_reg[0] + H0123_minus_4567_add_reg[0] - H4567_add_reg[0] - H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0] + H45_minus_67_add_reg[0] - 
            H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0] + H46_minus_57_add_reg[0] + H0347_minus_1256_add_reg[0] + H0356_minus_1247_add_reg[0] -
            H47_minus_56_add_reg[0] + y8k_3_temp;
assign u = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0] + 2*H23_minus_67_add_reg[0] -
           H6_plus_H7_add_reg[0] + H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0] + H0347_minus_1256_add_reg[0] - H0356_minus_1247_add_reg[0] +
           2*H27_minus_36_add_reg[0] - H6_minus_H7_add_reg[0] + 2*H13_minus_57_add_reg[0] - H5_plus_H7_add_reg[0] - 2*H15_minus_37_add_reg[0] + H5_minus_H7_add_reg[0] -
           2*H3_minus_H7_add_reg[0] + H7_add_reg[0] + y8k_4_temp;
assign v = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0] + 2*H23_minus_67_add_reg[0] - H6_plus_H7_add_reg[0] -
           H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] - H0347_minus_1256_add_reg[0] + H0356_minus_1247_add_reg[0] - 2*H27_minus_36_add_reg[0] +
           H6_minus_H7_add_reg[0] + y8k_5_temp;
assign s = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0167_minus_2345_add_reg[0] - H0145_minus_2367_add_reg[0] + H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0] +
            H0356_minus_1247_add_reg[0] - H0347_minus_1256_add_reg[0] + 2*H15_minus_37_add_reg[0] - 2*H17_minus_35_add_reg[0] - H7_add_reg[0] +
            2*H3_minus_H7_add_reg[0] + y8k_6_temp;
assign t = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0167_minus_2345_add_reg[0] - H0145_minus_2367_add_reg[0] - H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] -
            H0356_minus_1247_add_reg[0] + H0347_minus_1256_add_reg[0];*/

assign w = y8k_temp11  + y8k_temp13;
assign x = y8k_1_temp3 + y8k_1_temp5;
assign y = y8k_2_temp4 + y8k_2_temp10;
assign z = y8k_3_temp3 + y8k_3_temp6;
assign u = y8k_4_temp3 + y8k_4_temp9;
assign v = y8k_5_temp3 + y8k_5_temp5;
assign s = y8k_6_temp3 + y8k_6_temp8;
assign t = H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0167_minus_2345_add_reg[0] - H0145_minus_2367_add_reg[0] - H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] -
            H0356_minus_1247_add_reg[0] + H0347_minus_1256_add_reg[0];


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y8k<=0;
        y8k_1<=0;
        y8k_2<=0;
        y8k_3<=0;
        y8k_4<=0;
        y8k_5<=0;
        y8k_6<=0;        
        y8k_7<=0;                
    end
    else begin
        y8k<=w[31:16];
        y8k_1<=x[31:16];
        y8k_2<=y[31:16];
        y8k_3<=z[31:16];
        y8k_4<=u[31:16];
        y8k_5<=v[31:16]; 
        y8k_6<=s[31:16];  
        y8k_7<=y8k_7_temp[31:16];                                                
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y8k_temp<=0;
        y8k_temp2<=0; 
        y8k_temp3<=0;        
        y8k_temp4<=0;        
        y8k_temp5<=0;        
        y8k_temp6<=0;        
        y8k_temp7<=0;        
        y8k_temp8<=0;        
        y8k_temp9<=0;        
        y8k_temp10<=0;        
        y8k_temp11<=0;        
        y8k_temp12<=0;        
        y8k_temp13<=0;        
        y8k_1_temp<=0;
        y8k_1_temp2<=0;
        y8k_1_temp3<=0;
        y8k_1_temp4<=0;
        y8k_1_temp5<=0;        
        y8k_2_temp<=0;
        y8k_2_temp2<=0;
        y8k_2_temp3<=0;
        y8k_2_temp4<=0;
        y8k_2_temp5<=0;
        y8k_2_temp6<=0;
        y8k_2_temp7<=0;
        y8k_2_temp8<=0;
        y8k_2_temp9<=0;
        y8k_2_temp10<=0;
        y8k_3_temp<=0;
        y8k_3_temp2<=0;
        y8k_3_temp3<=0;
        y8k_3_temp4<=0;
        y8k_3_temp5<=0;
        y8k_3_temp6<=0;
        y8k_4_temp<=0;
        y8k_4_temp2<=0;
        y8k_4_temp3<=0;
        y8k_4_temp4<=0;
        y8k_4_temp5<=0;
        y8k_4_temp6<=0;
        y8k_4_temp7<=0;
        y8k_4_temp8<=0;
        y8k_4_temp9<=0;        
        y8k_5_temp<=0;
        y8k_5_temp2<=0;
        y8k_5_temp3<=0;
        y8k_5_temp4<=0;
        y8k_5_temp5<=0;        
        y8k_6_temp<=0;
        y8k_6_temp2<=0;
        y8k_6_temp3<=0;
        y8k_6_temp4<=0;
        y8k_6_temp5<=0;
        y8k_6_temp6<=0;
        y8k_6_temp7<=0;
        y8k_6_temp8<=0;  
        y8k_7_temp<=0;
    end
    else begin // delay 3 cycle
        y8k_temp<=H1357_add_reg[0] - H13_minus_57_add_reg[0] + H17_minus_35_add_reg[0] + H26_minus_37_add_reg[0] - H6_minus_H7_add_reg[0];
        y8k_temp2<=H3_minus_H7_add_reg[0] - H3_plus_H7_add_reg[0] + H7_add_reg[0] + H47_minus_56_add_reg[0] - H5_minus_H7_add_reg[0];
        y8k_temp3<=H4567_add_reg[0] - H6_plus_H7_add_reg[0] + H45_minus_67_add_reg[0] + H2367_add_reg[0] - H23_minus_67_add_reg[0];
        y8k_temp4<=H46_minus_57_add_reg[0] - H5_plus_H7_add_reg[0] - H27_minus_36_add_reg[0] - H15_minus_37_add_reg[0];
        y8k_temp12<= y8k_temp + y8k_temp2 + y8k_temp3 + y8k_temp4;
        y8k_temp13<=y8k_temp12;
        y8k_temp5<=H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0145_minus_2367_add_reg[0] - H4567_add_reg[0] - H45_minus_67_add_reg[0];
        y8k_temp6<=H0246_minus_1357_add_reg[0] + H0347_minus_1256_add_reg[0] + H0356_minus_1247_add_reg[0] - H26_minus_37_add_reg[0] - H47_minus_56_add_reg[0];
        y8k_temp7<=H6_plus_H7_add_reg[0] - H2367_add_reg[0] + H0167_minus_2345_add_reg[0];
        y8k_temp8<=H3_plus_H7_add_reg[0] + H3_minus_H7_add_reg[0] - H7_add_reg[0] - H23_minus_67_add_reg[0] - H1357_add_reg[0];
        y8k_temp9<=H5_plus_H7_add_reg[0] - H17_minus_35_add_reg[0] + H0257_minus_1346_add_reg[0] - H46_minus_57_add_reg[0] - H27_minus_36_add_reg[0];
        y8k_temp10<=H6_minus_H7_add_reg[0]  - H13_minus_57_add_reg[0] - H15_minus_37_add_reg[0] + H5_minus_H7_add_reg[0];
        y8k_temp11<=(y8k_temp5 + y8k_temp6) + (y8k_temp7 + y8k_temp8) + (y8k_temp9 + y8k_temp10);
        y8k_1_temp<=H27_minus_36_add_reg[0] - H46_minus_57_add_reg[0] - H47_minus_56_add_reg[0] + H6_minus_H7_add_reg[0] - H26_minus_37_add_reg[0];
        y8k_1_temp2<=y8k_temp3 + y8k_1_temp;
        y8k_1_temp3<=y8k_1_temp2;
        y8k_1_temp4<=H46_minus_57_add_reg[0] + H27_minus_36_add_reg[0] - H23_minus_67_add_reg[0]- H0257_minus_1346_add_reg[0] - H6_minus_H7_add_reg[0];
        y8k_1_temp5<=y8k_1_temp4 + y8k_temp5 - y8k_temp6 + y8k_temp7;
        y8k_2_temp<=H4567_add_reg[0] - H45_minus_67_add_reg[0] + H46_minus_57_add_reg[0] - H47_minus_56_add_reg[0] + H5_minus_H7_add_reg[0];
        y8k_2_temp2<=H5_minus_H7_add_reg[0] + H3_plus_H7_add_reg[0] - H3_minus_H7_add_reg[0] - H7_add_reg[0];
        y8k_2_temp3<=y8k_2_temp + y8k_2_temp2;
        y8k_2_temp4<=y8k_2_temp3;
        y8k_2_temp5<=H01234567_add_reg[0] + H0123_minus_4567_add_reg[0] - H4567_add_reg[0] - H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0];
        y8k_2_temp6<=H0246_minus_1357_add_reg[0] + H0257_minus_1346_add_reg[0] - H46_minus_57_add_reg[0] - H0347_minus_1256_add_reg[0] - H0356_minus_1247_add_reg[0];
        y8k_2_temp7<=H45_minus_67_add_reg[0] + H47_minus_56_add_reg[0] - H3_minus_H7_add_reg[0] - H5_minus_H7_add_reg[0];
        y8k_2_temp8<=H17_minus_35_add_reg[0] + H15_minus_37_add_reg[0] - H5_minus_H7_add_reg[0] - H3_plus_H7_add_reg[0];
        y8k_2_temp9<=H17_minus_35_add_reg[0] + H7_add_reg[0] + H15_minus_37_add_reg[0];
        y8k_2_temp10<=y8k_2_temp5 + y8k_2_temp6 + y8k_2_temp7 + y8k_2_temp8 + y8k_2_temp9;
        y8k_3_temp<=H4567_add_reg[0] - H45_minus_67_add_reg[0] - H46_minus_57_add_reg[0] + H47_minus_56_add_reg[0];
        y8k_3_temp2<=y8k_3_temp;
        y8k_3_temp3<=y8k_3_temp2;
        y8k_3_temp4<=H46_minus_57_add_reg[0] + H0347_minus_1256_add_reg[0] + H0356_minus_1247_add_reg[0] - H47_minus_56_add_reg[0];
        y8k_3_temp5<=H45_minus_67_add_reg[0] - H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0];
        y8k_3_temp6<=y8k_2_temp5 + y8k_3_temp4 + y8k_3_temp5;
        y8k_4_temp<=H6_plus_H7_add_reg[0] + H6_minus_H7_add_reg[0] - H7_add_reg[0] + H5_plus_H7_add_reg[0] - H5_minus_H7_add_reg[0];
        y8k_4_temp2<=y8k_4_temp;
        y8k_4_temp3<=y8k_4_temp2;  
        y8k_4_temp4<=H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0145_minus_2367_add_reg[0] - H0167_minus_2345_add_reg[0] + H23_minus_67_add_reg[0];
        y8k_4_temp5<=H0246_minus_1357_add_reg[0] - H0257_minus_1346_add_reg[0] + H0347_minus_1256_add_reg[0] - H0356_minus_1247_add_reg[0] + H27_minus_36_add_reg[0];
        y8k_4_temp6<=H13_minus_57_add_reg[0] - H6_plus_H7_add_reg[0] + H27_minus_36_add_reg[0] - H6_minus_H7_add_reg[0] - H15_minus_37_add_reg[0];
        y8k_4_temp7<=H23_minus_67_add_reg[0] + H13_minus_57_add_reg[0] - H5_plus_H7_add_reg[0] - H15_minus_37_add_reg[0] - H3_minus_H7_add_reg[0];
        y8k_4_temp8<=H5_minus_H7_add_reg[0] - H3_minus_H7_add_reg[0] + H7_add_reg[0];
        y8k_4_temp9<=y8k_4_temp4 + y8k_4_temp5 + y8k_4_temp6 + y8k_4_temp7 + y8k_4_temp8;
        y8k_5_temp<=H6_plus_H7_add_reg[0] + H6_minus_H7_add_reg[0];
        y8k_5_temp2<=y8k_5_temp;
        y8k_5_temp3<=y8k_5_temp2;   
        y8k_5_temp4<=H23_minus_67_add_reg[0] - H6_plus_H7_add_reg[0] - H27_minus_36_add_reg[0] + H6_minus_H7_add_reg[0];
        y8k_5_temp5<=y8k_4_temp4 - y8k_4_temp5 + y8k_5_temp4;
        y8k_6_temp<=H7_add_reg[0];
        y8k_6_temp2<=y8k_6_temp;
        y8k_6_temp3<=y8k_6_temp2;    
        y8k_6_temp4<=H01234567_add_reg[0] - H0123_minus_4567_add_reg[0] + H0167_minus_2345_add_reg[0] - H0145_minus_2367_add_reg[0] + H0246_minus_1357_add_reg[0];
        y8k_6_temp5<=H0356_minus_1247_add_reg[0] - H0347_minus_1256_add_reg[0] - H0257_minus_1346_add_reg[0];
        y8k_6_temp6<=H15_minus_37_add_reg[0] - H17_minus_35_add_reg[0] - H7_add_reg[0] + H3_minus_H7_add_reg[0];
        y8k_6_temp7<=H15_minus_37_add_reg[0] - H17_minus_35_add_reg[0] + H3_minus_H7_add_reg[0];
        y8k_6_temp8<=y8k_6_temp4 + y8k_6_temp5 + y8k_6_temp6 + y8k_6_temp7;

        y8k_7_temp<=y8k_6_temp4 - y8k_6_temp5;

        /*y8k_temp<=H3_minus_H7_add_reg[0] - H3_plus_H7_add_reg[0] + H7_add_reg[0] - H5_plus_H7_add_reg[0] - H5_minus_H7_add_reg[0] +
                H1357_add_reg[0] - H13_minus_57_add_reg[0] + H17_minus_35_add_reg[0] -  H15_minus_37_add_reg[0] +
                H2367_add_reg[0] - H23_minus_67_add_reg[0] + H26_minus_37_add_reg[0] - H27_minus_36_add_reg[0] + H4567_add_reg[0] + H45_minus_67_add_reg[0] + 
                H46_minus_57_add_reg[0] + H47_minus_56_add_reg[0] - H6_plus_H7_add_reg[0] - H6_minus_H7_add_reg[0];
        y8k_1_temp<=H4567_add_reg[0] + H45_minus_67_add_reg[0] - H6_plus_H7_add_reg[0] + H2367_add_reg[0] - H23_minus_67_add_reg[0] -  H46_minus_57_add_reg[0] -
                    H47_minus_56_add_reg[0] + H6_minus_H7_add_reg[0] - H26_minus_37_add_reg[0] + H27_minus_36_add_reg[0];
        y8k_2_temp<=H4567_add_reg[0] - H45_minus_67_add_reg[0] + H46_minus_57_add_reg[0] - H47_minus_56_add_reg[0] + 2*H5_minus_H7_add_reg[0] - H7_add_reg[0] + 
                H3_plus_H7_add_reg[0] - H3_minus_H7_add_reg[0];
        y8k_3_temp<=H4567_add_reg[0] - H45_minus_67_add_reg[0] - H46_minus_57_add_reg[0] + H47_minus_56_add_reg[0];
        y8k_4_temp<=H6_plus_H7_add_reg[0] + H6_minus_H7_add_reg[0] - H7_add_reg[0] + H5_plus_H7_add_reg[0] - H5_minus_H7_add_reg[0];
        y8k_5_temp<=H6_plus_H7_add_reg[0] + H6_minus_H7_add_reg[0];
        y8k_6_temp<=H7_add_reg[0];*/
    end
end

endmodule
