//synopsys translate_off
`include "CSD_CSA_proposed.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x4k,x4k_1,x4k_2,x4k_3,
output reg signed [15:0] y4k,y4k_1,y4k_2,y4k_3);

integer j;
reg signed [15:0] x4k_1_reg,x4k_3_reg,x4k_2_add_x4k_3_reg,x4k_2_sub_x4k_3_reg;
wire signed [15:0] x4k_2_add_x4k_3,x4k_2_sub_x4k_3;
reg signed [16:0] x4k_0123_reg,x4k_01_sub_23_reg,x4k_02_sub_13_reg,x4k_03_sub_12_reg,x4k_1_add_x4k_3_reg;
wire signed [16:0] x4k_0123,x4k_01_sub_23,x4k_02_sub_13,x4k_03_sub_12,x4k_1_add_x4k_3;

//H1 H3 H2+H3 H2-H3 H1+H3 BLOCK def
wire [31:0] H1_mult [5:0],H3_mult [5:0];
reg signed [31:0] H1_mult_reg [5:0],H3_mult_reg [5:0];
reg signed [31:0] H1_add_reg [4:0],H3_add_reg [4:0]; //HX_add_reg[0] is output of HX
reg signed [31:0] H1_stage_one_temp,H3_stage_one_temp,H1_add_reg_delay,H3_add_reg_delay;
wire [32:0] H2_minus_H3_mult [5:0],H1_H3_mult [5:0];
wire [33:0] H2_plus_H3_mult [5:0];
reg signed [32:0] H2_minus_H3_mult_reg [5:0],H1_H3_mult_reg [5:0];
reg signed [32:0] H2_minus_H3_add_reg [4:0],H1_H3_add_reg [5:0];
reg signed [32:0] H2_minus_H3_stage_one_temp,H1_H3_stage_one_temp;
reg signed [33:0] H2_plus_H3_mult_reg [5:0];
reg signed [33:0] H2_plus_H3_add_reg [4:0];
reg signed [33:0] H2_plus_H3_stage_one_temp;

// 0.5*(H0+H1+H2+H3) 0.5*(H0+H1-H2-H3) 0.5*(H0+H2-H1-H3) 0.5*(H0+H3-H1-H2) BLOCK def
wire [31:0] H0123_mult [2:0],H03_minus_12_mult [2:0],H02_minus_13_mult [2:0];
reg signed [31:0] H0123_mult_reg [2:0],H03_minus_12_mult_reg [2:0],H02_minus_13_mult_reg [2:0];
reg signed [33:0] H0123_add_reg [4:0],H03_minus_12_add_reg [4:0],H02_minus_13_add_reg [4:0];
reg signed [33:0] H0123_stage_one_temp,H03_minus_12_stage_one_temp,H02_minus_13_stage_one_temp;
wire [32:0] H01_minus_23_mult [2:0];
reg signed [32:0] H01_minus_23_mult_reg [2:0];
reg signed [32:0] H01_minus_23_add_reg [4:0];
reg signed [32:0] H01_minus_23_stage_one_temp;

reg signed [31:0] y4k_temp,y4k_temp2,y4k_temp3,y4k_temp4,y4k_1_temp,y4k_1_temp2,y4k_1_temp3,y4k_2_temp,y4k_2_temp2,y4k_2_temp3,y4k_3_temp;
wire signed [31:0] w,x,y;

///************H1 H3 BLOCK ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x4k_1_reg<=0;
        x4k_3_reg<=0;
    end
    else begin
        x4k_1_reg<=x4k_1;
        x4k_3_reg<=x4k_3;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1) begin
            H1_mult_reg[j]<=0;
            H3_mult_reg[j]<=0;  
        end
    end
    else begin
        for(j=0;j<6;j=j+1) begin
            H1_mult_reg[j]<=H1_mult[j];
            H3_mult_reg[j]<=H3_mult[j];
        end
    end
end

CSD_CSA0 H10(.x(x4k_1_reg) ,.y(H1_mult[0]));
CSD_CSA1 H11(.x(x4k_1_reg) ,.y(H1_mult[1]));
CSD_CSA2 H12(.x(x4k_1_reg) ,.y(H1_mult[2]));
CSD_CSA3 H13(.x(x4k_1_reg) ,.y(H1_mult[3]));
CSD_CSA4 H14(.x(x4k_1_reg) ,.y(H1_mult[4]));
CSD_CSA5 H15(.x(x4k_1_reg) ,.y(H1_mult[5]));

CSD_CSA6 H30(.x(x4k_3_reg) ,.y(H3_mult[0]));
CSD_CSA7 H31(.x(x4k_3_reg) ,.y(H3_mult[1]));
CSD_CSA8 H32(.x(x4k_3_reg) ,.y(H3_mult[2]));
CSD_CSA9 H33(.x(x4k_3_reg) ,.y(H3_mult[3]));
CSD_CSA10 H34(.x(x4k_3_reg) ,.y(H3_mult[4]));
CSD_CSA11 H35(.x(x4k_3_reg) ,.y(H3_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1_stage_one_temp<=0;
        H3_stage_one_temp<=0;
    end
    else begin
        H1_stage_one_temp<=H1_mult_reg[5];
        H3_stage_one_temp<=H3_mult_reg[5];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1) begin
            H1_add_reg[j]<=0;
            H3_add_reg[j]<=0;
        end
    end
    else begin
        H1_add_reg[4] <= H1_stage_one_temp + H1_mult_reg[4];
        H3_add_reg[4] <= H3_stage_one_temp + H3_mult_reg[4];
        for(j=0;j<4;j=j+1) begin
           H1_add_reg[j]<=H1_add_reg[j+1] + H1_mult_reg[j];
           H3_add_reg[j]<=H3_add_reg[j+1] + H3_mult_reg[j];
        end
    end
end

//******************H2 + H3***********************
assign x4k_2_add_x4k_3 = (x4k_2 >>> 1) + (x4k_3 >>> 1);
//assign x4k_2_add_x4k_3 = (x4k_2+x4k_3)/2;
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_2_add_x4k_3_reg<=0;
    else x4k_2_add_x4k_3_reg<=x4k_2_add_x4k_3;
end

CSD_CSA12 H2H3(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[0]));
CSD_CSA13 H2H3_1(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[1]));
CSD_CSA14 H2H3_2(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[2]));
CSD_CSA15 H2H3_3(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[3]));
CSD_CSA16 H2H3_4(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[4]));
CSD_CSA17 H2H3_5(.x(x4k_2_add_x4k_3_reg) ,.y(H2_plus_H3_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H2_plus_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H2_plus_H3_mult_reg[j]<=H2_plus_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_plus_H3_stage_one_temp<=0;
    else H2_plus_H3_stage_one_temp<=H2_plus_H3_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H2_plus_H3_add_reg[j]<=0;
    end
    else begin
        H2_plus_H3_add_reg[4] <= H2_plus_H3_stage_one_temp + H2_plus_H3_mult_reg[4];
        for(j=0;j<4;j=j+1) begin
           H2_plus_H3_add_reg[j]<= H2_plus_H3_mult_reg[j] + H2_plus_H3_add_reg[j+1];            
        end
    end
end

//******************H2 - H3***********************
assign x4k_2_sub_x4k_3 = (x4k_2 >>> 1) - (x4k_3 >>> 1);

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_2_sub_x4k_3_reg<=0;
    else x4k_2_sub_x4k_3_reg<=x4k_2_sub_x4k_3;
end

CSD_CSA18 H2H3_6(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[0]));
CSD_CSA19 H2H3_7(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[1]));
CSD_CSA20 H2H3_8(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[2]));
CSD_CSA21 H2H3_9(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[3]));
CSD_CSA22 H2H3_10(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[4]));
CSD_CSA23 H2H3_11(.x(x4k_2_sub_x4k_3_reg) ,.y(H2_minus_H3_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H2_minus_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H2_minus_H3_mult_reg[j]<=H2_minus_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_minus_H3_stage_one_temp<=0;
    else H2_minus_H3_stage_one_temp<=H2_minus_H3_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H2_minus_H3_add_reg[j]<=0;
    end
    else begin
        H2_minus_H3_add_reg[4] <= H2_minus_H3_stage_one_temp + H2_minus_H3_mult_reg[4];
        for(j=0;j<4;j=j+1) begin
           H2_minus_H3_add_reg[j]<= H2_minus_H3_mult_reg[j] + H2_minus_H3_add_reg[j+1];            
        end
    end
end


//******************H1 + H3***********************
assign x4k_1_add_x4k_3 = x4k_1 + x4k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_1_add_x4k_3_reg<=0;
    else x4k_1_add_x4k_3_reg<=x4k_1_add_x4k_3;
end

CSD_CSA36 H1H3(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[0]));
CSD_CSA37 H1H3_1(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[1]));
CSD_CSA38 H1H3_2(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[2]));
CSD_CSA39 H1H3_3(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[3]));
CSD_CSA40 H1H3_4(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[4]));
CSD_CSA41 H1H3_5(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H1_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H1_H3_mult_reg[j]<=H1_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H3_stage_one_temp<=0;
    else H1_H3_stage_one_temp<=H1_H3_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H1_H3_add_reg[j]<=0;
    end
    else begin
        H1_H3_add_reg[4] <= H1_H3_stage_one_temp + H1_H3_mult_reg[4];
        for(j=0;j<4;j=j+1)
           H1_H3_add_reg[j]<= H1_H3_mult_reg[j] + H1_H3_add_reg[j+1];            
    end
end

//******************H0 + H1 + H2 + H3***********************
assign x4k_0123 = ((x4k >>> 1) + (x4k_1 >>> 1)) + x4k_2_add_x4k_3;
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_0123_reg<=0;
    else x4k_0123_reg<=x4k_0123;
end

CSD_CSA24 H0123_0(.x(x4k_0123_reg) ,.y(H0123_mult[0]));
CSD_CSA25 H0123_1(.x(x4k_0123_reg) ,.y(H0123_mult[1]));
CSD_CSA26 H0123_2(.x(x4k_0123_reg) ,.y(H0123_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H0123_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H0123_mult_reg[j]<=H0123_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0123_stage_one_temp<=0;
    end
    else begin
        H0123_stage_one_temp<=H0123_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H0123_add_reg[j]<=0;
    end
    else begin
        H0123_add_reg[4]<=H0123_stage_one_temp + H0123_mult_reg[1];
        H0123_add_reg[3]<=H0123_mult_reg[2] + H0123_add_reg[4];
        for(j=0;j<3;j=j+1)
           H0123_add_reg[j]<=H0123_add_reg[j+1] + H0123_mult_reg[j];
    end
end

//******************H0 + H1 - H2 - H3***********************
assign x4k_01_sub_23 = ((x4k >>> 1) + (x4k_1 >>> 1)) - x4k_2_add_x4k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_01_sub_23_reg<=0;
    else x4k_01_sub_23_reg<=x4k_01_sub_23;
end

CSD_CSA27 H01_minus_23_0(.x(x4k_01_sub_23_reg) ,.y(H01_minus_23_mult[0]));
CSD_CSA28 H01_minus_23_1(.x(x4k_01_sub_23_reg) ,.y(H01_minus_23_mult[1]));
CSD_CSA29 H01_minus_23_2(.x(x4k_01_sub_23_reg) ,.y(H01_minus_23_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H01_minus_23_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H01_minus_23_mult_reg[j]<=H01_minus_23_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H01_minus_23_stage_one_temp<=0;
    end
    else begin
        H01_minus_23_stage_one_temp<=H01_minus_23_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H01_minus_23_add_reg[j]<=0;
    end
    else begin
        H01_minus_23_add_reg[4]<=H01_minus_23_stage_one_temp + H01_minus_23_mult_reg[1];
        H01_minus_23_add_reg[3]<=H01_minus_23_mult_reg[2] + H01_minus_23_add_reg[4];
        for(j=0;j<3;j=j+1)
           H01_minus_23_add_reg[j]<=H01_minus_23_add_reg[j+1] - H01_minus_23_mult_reg[j];
    end
end

//******************H0 + H2 - H1 - H3***********************
assign x4k_02_sub_13 = ((x4k >>> 1) + (x4k_2 >>> 1)) - ((x4k_1 >>> 1) + (x4k_3 >>> 1));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_02_sub_13_reg<=0;
    else x4k_02_sub_13_reg<=x4k_02_sub_13;
end

CSD_CSA30 H02_minus_13_0(.x(x4k_02_sub_13_reg) ,.y(H02_minus_13_mult[0]));
CSD_CSA31 H02_minus_13_1(.x(x4k_02_sub_13_reg) ,.y(H02_minus_13_mult[1]));
CSD_CSA32 H02_minus_13_2(.x(x4k_02_sub_13_reg) ,.y(H02_minus_13_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H02_minus_13_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H02_minus_13_mult_reg[j]<=H02_minus_13_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H02_minus_13_stage_one_temp<=0;
    end
    else begin
        H02_minus_13_stage_one_temp<=H02_minus_13_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H02_minus_13_add_reg[j]<=0;
    end
    else begin
        H02_minus_13_add_reg[4]<=H02_minus_13_stage_one_temp + H02_minus_13_mult_reg[1];
        H02_minus_13_add_reg[3]<=H02_minus_13_mult_reg[2] + H02_minus_13_add_reg[4];
        for(j=0;j<3;j=j+1)
           H02_minus_13_add_reg[j]<=H02_minus_13_add_reg[j+1] - H02_minus_13_mult_reg[j];
    end
end

//******************H0 + H3 - H1 - H2***********************
assign x4k_03_sub_12 = ((x4k >>> 1) + (x4k_3 >>> 1)) - ((x4k_1 >>> 1) + (x4k_2 >>> 1));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_03_sub_12_reg<=0;
    else x4k_03_sub_12_reg<=x4k_03_sub_12;
end

CSD_CSA33 H03_minus_12_0(.x(x4k_03_sub_12_reg) ,.y(H03_minus_12_mult[0]));
CSD_CSA34 H03_minus_12_1(.x(x4k_03_sub_12_reg) ,.y(H03_minus_12_mult[1]));
CSD_CSA35 H03_minus_12_2(.x(x4k_03_sub_12_reg) ,.y(H03_minus_12_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H03_minus_12_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H03_minus_12_mult_reg[j]<=H03_minus_12_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H03_minus_12_stage_one_temp<=0;
    end
    else begin
        H03_minus_12_stage_one_temp<=H03_minus_12_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H03_minus_12_add_reg[j]<=0;
    end
    else begin
        H03_minus_12_add_reg[4]<=H03_minus_12_stage_one_temp + H03_minus_12_mult_reg[1];
        H03_minus_12_add_reg[3]<=H03_minus_12_mult_reg[2] + H03_minus_12_add_reg[4];
        for(j=0;j<3;j=j+1)
           H03_minus_12_add_reg[j]<=H03_minus_12_add_reg[j+1] + H03_minus_12_mult_reg[j];
    end
end

//***************************************

//assign w = H0123_add_reg[0] + H01_minus_23_add_reg[0] - H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0] + H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0] + y4k_temp - H1_add_reg[0];
//assign x = H0123_add_reg[0] + H01_minus_23_add_reg[0] - H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0] - H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0] + y4k_1_temp;
//assign y = H0123_add_reg[0] - H01_minus_23_add_reg[0] - H03_minus_12_add_reg[0] + H02_minus_13_add_reg[0] - H1_H3_add_reg[0] + 2*H1_add_reg[0] + H3_add_reg[0] + y4k_2_temp;
//assign z = H0123_add_reg[0] - H01_minus_23_add_reg[0] + H03_minus_12_add_reg[0] - H02_minus_13_add_reg[0];

assign w = y4k_temp2 + y4k_temp3 + y4k_temp4 - H1_add_reg_delay;
assign x = y4k_1_temp2 - y4k_temp3 + y4k_1_temp3;
assign y = y4k_2_temp2 + y4k_2_temp3 + y4k_2_temp;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y4k<=0;
        y4k_1<=0;
        y4k_2<=0;
        y4k_3<=0;             
    end
    else begin
        y4k<=w[31:16];
        y4k_1<=x[31:16];
        y4k_2<=y[31:16];
        y4k_3<=y4k_3_temp[31:16];                                      
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1_add_reg_delay<=0;
        H3_add_reg_delay<=0;
    end
    else begin
        H1_add_reg_delay<=H1_add_reg[0];
        H3_add_reg_delay<=H3_add_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y4k_temp<=0;
        y4k_temp2<=0;
        y4k_temp3<=0;
        y4k_temp4<=0;
        y4k_1_temp<=0;
        y4k_1_temp2<=0;
        y4k_1_temp3<=0;
        y4k_2_temp<=0;
        y4k_2_temp2<=0;
        y4k_2_temp3<=0;
        y4k_3_temp<=0;
    end
    else begin
        y4k_temp<=(H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0]) + H1_H3_add_reg[0] - H3_add_reg[0];
        y4k_1_temp<=H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0];
        y4k_2_temp<=H3_add_reg_delay;
        y4k_temp2<=(H0123_add_reg[0] + H01_minus_23_add_reg[0]) - (H2_plus_H3_add_reg[0] + H2_minus_H3_add_reg[0]);
        y4k_temp3<=H02_minus_13_add_reg[0] + H03_minus_12_add_reg[0];
        y4k_temp4<=y4k_temp - H3_add_reg_delay - H1_add_reg_delay;
        y4k_1_temp2<=(H0123_add_reg[0] + H01_minus_23_add_reg[0]) - (H2_plus_H3_add_reg[0] - H2_minus_H3_add_reg[0]);        
        y4k_1_temp3<=y4k_1_temp;
        y4k_2_temp2<=(H0123_add_reg[0] - H01_minus_23_add_reg[0]) + (H02_minus_13_add_reg[0] - H03_minus_12_add_reg[0]);
        y4k_2_temp3<=(H1_add_reg[0] + H3_add_reg[0]) + (H1_add_reg[0] - H1_H3_add_reg[0]);
        y4k_3_temp<=H0123_add_reg[0] - H01_minus_23_add_reg[0] + H03_minus_12_add_reg[0] - H02_minus_13_add_reg[0];

    end
end

endmodule
