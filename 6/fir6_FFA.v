//synopsys translate_off
`include "CSD_CSA_FFA.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x6k,x6k_1,x6k_2,x6k_3,x6k_4,x6k_5,
output reg signed [15:0] y6k,y6k_1,y6k_2,y6k_3,y6k_4,y6k_5);

integer j;
reg signed [15:0] x6k_reg,x6k_1_reg,x6k_2_reg,x6k_3_reg,x6k_4_reg,x6k_5_reg; // input data
reg signed [16:0] x6k_1_add_x6k_3_reg,x6k_3_add_x6k_5_reg,x6k_add_x6k_1_reg,x6k_2_add_x6k_3_reg,x6k_2_add_x6k_4_reg,x6k_add_x6k_2_reg,x6k_4_add_x6k_5_reg;
reg signed [17:0] x6k_135_reg,x6k_024_reg,x6k_0123_reg,x6k_2345_reg;
reg signed [18:0] x6k_012345_reg;
wire signed [16:0] x6k_1_add_x6k_3,x6k_3_add_x6k_5,x6k_add_x6k_1,x6k_2_add_x6k_3,x6k_2_add_x6k_4,x6k_add_x6k_2,x6k_4_add_x6k_5;
wire signed [17:0] x6k_135,x6k_024,x6k_0123,x6k_2345;
wire signed [18:0] x6k_012345;
// H0 H1 H2 H3 H4 H5 H0+H1 H4+H5 H1+H3 H2+H4 H2+H3 H3+H5 H0+H2 H1+H3+H5 BLOCK def
wire [31:0] H0_mult [3:0],H1_mult [3:0],H2_mult [3:0],H3_mult [3:0],H4_mult [3:0],H5_mult [3:0];
reg signed [31:0] H0_mult_reg [3:0],H1_mult_reg [3:0],H2_mult_reg [3:0],H3_mult_reg [3:0],H4_mult_reg [3:0],H5_mult_reg [3:0];
reg signed [31:0] H0_add_reg [2:0],H1_add_reg [2:0],H2_add_reg [2:0],H3_add_reg [2:0],H4_add_reg [2:0],H5_add_reg [2:0]; //HX_add_reg[0] is output of HX
reg signed [31:0] H0_stage_one_temp,H1_stage_one_temp,H2_stage_one_temp,H3_stage_one_temp,H4_stage_one_temp,H5_stage_one_temp;
wire [32:0] H1_H3_mult [3:0],H2_H4_mult [3:0],H3_H5_mult [3:0],H0_H2_mult [3:0];
reg signed [32:0] H1_H3_mult_reg [3:0],H2_H4_mult_reg [3:0],H3_H5_mult_reg [3:0],H0_H2_mult_reg [3:0];
reg signed [32:0] H1_H3_add_reg [2:0],H2_H4_add_reg [2:0],H3_H5_add_reg [2:0],H0_H2_add_reg [2:0];
reg signed [32:0] H1_H3_stage_one_temp,H2_H4_stage_one_temp,H3_H5_stage_one_temp,H0_H2_stage_one_temp;
wire [33:0] H0_H1_mult [3:0],H4_H5_mult [3:0],H2_H3_mult [1:0],H135_mult [3:0],H024_mult [3:0];
reg signed [33:0] H0_H1_mult_reg [3:0],H4_H5_mult_reg [3:0],H2_H3_mult_reg [1:0],H135_mult_reg[3:0],H024_mult_reg[3:0];
reg signed [33:0] H0_H1_add_reg [2:0],H4_H5_add_reg [2:0],H2_H3_add_reg [2:0],H135_add_reg [2:0],H024_add_reg [2:0];
reg signed [33:0] H0_H1_stage_one_temp,H4_H5_stage_one_temp,H2_H3_stage_one_temp,H135_stage_one_temp,H024_stage_one_temp;
// H0+H1+H2+H3 H2+H3+H4+H5 H0+H1+H2+H3+H4+H5 BLOCK def
wire [33:0] H0123_mult [3:0],H2345_mult [3:0];
reg signed [33:0] H0123_mult_reg [3:0],H2345_mult_reg [3:0];
reg signed [33:0] H0123_add_reg [2:0],H2345_add_reg [2:0];
reg signed [33:0] H0123_stage_one_temp,H2345_stage_one_temp;
wire [34:0] H012345_mult [1:0];
reg signed [34:0] H012345_mult_reg [3:0];
reg signed [34:0] H012345_add_reg [2:0];
reg signed [34:0] H012345_stage_one_temp;



reg signed [31:0] y6k_temp,y6k_temp2,y6k_temp3,y6k_temp4,y6k_1_temp,y6k_1_temp2,y6k_1_temp3,y6k_1_temp4,y6k_2_temp,y6k_2_temp2,y6k_2_temp3;
reg signed [31:0] y6k_3_temp,y6k_3_temp2,y6k_3_temp3,y6k_3_temp4,y6k_3_temp5,y6k_4_temp,y6k_4_temp2,y6k_4_temp3,y6k_4_temp4,y6k_5_temp,y6k_5_temp2,y6k_5_temp3,y6k_5_temp4;
wire signed [31:0] u,v,w,x,y,z;


///************H0 H1 H2 H3 H4 H5 BLOCK ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x6k_reg<=0;
        x6k_1_reg<=0;
        x6k_2_reg<=0;
        x6k_3_reg<=0;
        x6k_4_reg<=0;
        x6k_5_reg<=0;
    end
    else begin
        x6k_reg<=x6k;
        x6k_1_reg<=x6k_1;
        x6k_2_reg<=x6k_2;
        x6k_3_reg<=x6k_3;
        x6k_4_reg<=x6k_4;
        x6k_5_reg<=x6k_5;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0_mult_reg[j]<=0;
            H1_mult_reg[j]<=0;
            H2_mult_reg[j]<=0;
            H3_mult_reg[j]<=0;  
            H4_mult_reg[j]<=0;
            H5_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H0_mult_reg[j]<=H0_mult[j];
            H1_mult_reg[j]<=H1_mult[j];
            H2_mult_reg[j]<=H2_mult[j];
            H3_mult_reg[j]<=H3_mult[j];
            H4_mult_reg[j]<=H4_mult[j];
            H5_mult_reg[j]<=H5_mult[j];
        end
    end
end

CSD_CSA0 H00(.x(x6k_reg) ,.y(H0_mult[0]));
CSD_CSA6 H01(.x(x6k_reg) ,.y(H0_mult[1]));
CSD_CSA11 H02(.x(x6k_reg) ,.y(H0_mult[2]));
CSD_CSA5 H03(.x(x6k_reg) ,.y(H0_mult[3]));

CSD_CSA1 H10(.x(x6k_1_reg) ,.y(H1_mult[0]));
CSD_CSA7 H11(.x(x6k_1_reg) ,.y(H1_mult[1]));
CSD_CSA10 H12(.x(x6k_1_reg) ,.y(H1_mult[2]));
CSD_CSA4 H13(.x(x6k_1_reg) ,.y(H1_mult[3]));

CSD_CSA2 H20(.x(x6k_2_reg) ,.y(H2_mult[0]));
CSD_CSA8 H21(.x(x6k_2_reg) ,.y(H2_mult[1]));
CSD_CSA9 H22(.x(x6k_2_reg) ,.y(H2_mult[2]));
CSD_CSA3 H23(.x(x6k_2_reg) ,.y(H2_mult[3]));

CSD_CSA3 H30(.x(x6k_3_reg) ,.y(H3_mult[0]));
CSD_CSA9 H31(.x(x6k_3_reg) ,.y(H3_mult[1]));
CSD_CSA8 H32(.x(x6k_3_reg) ,.y(H3_mult[2]));
CSD_CSA2 H33(.x(x6k_3_reg) ,.y(H3_mult[3]));

CSD_CSA4 H40(.x(x6k_4_reg) ,.y(H4_mult[0]));
CSD_CSA10 H41(.x(x6k_4_reg) ,.y(H4_mult[1]));
CSD_CSA7 H42(.x(x6k_4_reg) ,.y(H4_mult[2]));
CSD_CSA1 H43(.x(x6k_4_reg) ,.y(H4_mult[3]));

CSD_CSA5 H50(.x(x6k_5_reg) ,.y(H5_mult[0]));
CSD_CSA11 H51(.x(x6k_5_reg) ,.y(H5_mult[1]));
CSD_CSA6 H52(.x(x6k_5_reg) ,.y(H5_mult[2]));
CSD_CSA0 H53(.x(x6k_5_reg) ,.y(H5_mult[3]));




always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_stage_one_temp<=0;
        H1_stage_one_temp<=0;
        H2_stage_one_temp<=0;
        H3_stage_one_temp<=0;
        H4_stage_one_temp<=0;
        H5_stage_one_temp<=0;
    end
    else begin
        H0_stage_one_temp<=H0_mult_reg[3];
        H1_stage_one_temp<=H1_mult_reg[3];
        H2_stage_one_temp<=H2_mult_reg[3];
        H3_stage_one_temp<=H3_mult_reg[3];
        H4_stage_one_temp<=H4_mult_reg[3];
        H5_stage_one_temp<=H5_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H0_add_reg[j]<=0;
            H1_add_reg[j]<=0;
            H2_add_reg[j]<=0;
            H3_add_reg[j]<=0;
            H4_add_reg[j]<=0;
            H5_add_reg[j]<=0;
        end
    end
    else begin
        H0_add_reg[2] <= H0_stage_one_temp + H0_mult_reg[2];
        H1_add_reg[2] <= H1_stage_one_temp + H1_mult_reg[2];
        H2_add_reg[2] <= H2_stage_one_temp + H2_mult_reg[2];
        H3_add_reg[2] <= H3_stage_one_temp + H3_mult_reg[2];
        H4_add_reg[2] <= H4_stage_one_temp + H4_mult_reg[2];
        H5_add_reg[2] <= H5_stage_one_temp + H5_mult_reg[2];
        for(j=0;j<2;j=j+1) begin
           H0_add_reg[j]<=H0_add_reg[j+1] + H0_mult_reg[j];
           H1_add_reg[j]<=H1_add_reg[j+1] + H1_mult_reg[j];
           H2_add_reg[j]<=H2_add_reg[j+1] + H2_mult_reg[j];
           H3_add_reg[j]<=H3_add_reg[j+1] + H3_mult_reg[j];
           H4_add_reg[j]<=H4_add_reg[j+1] + H4_mult_reg[j];
           H5_add_reg[j]<=H5_add_reg[j+1] + H5_mult_reg[j];
        end
    end
end

//******************H1 + H3***********************
assign x6k_1_add_x6k_3 = x6k_1 + x6k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_1_add_x6k_3_reg<=0;
    else x6k_1_add_x6k_3_reg<=x6k_1_add_x6k_3;
end

CSD_CSA12 H1H3(.x(x6k_1_add_x6k_3_reg) ,.y(H1_H3_mult[0]));
CSD_CSA13 H1H3_1(.x(x6k_1_add_x6k_3_reg) ,.y(H1_H3_mult[1]));
CSD_CSA14 H1H3_2(.x(x6k_1_add_x6k_3_reg) ,.y(H1_H3_mult[2]));
CSD_CSA15 H1H3_3(.x(x6k_1_add_x6k_3_reg) ,.y(H1_H3_mult[3]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H1_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H1_H3_mult_reg[j]<=H1_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H3_stage_one_temp<=0;
    else H1_H3_stage_one_temp<=H1_H3_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H1_H3_add_reg[j]<=0;
    end
    else begin
        H1_H3_add_reg[2] <= H1_H3_stage_one_temp + H1_H3_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H1_H3_add_reg[j]<= H1_H3_mult_reg[j] + H1_H3_add_reg[j+1];
    end
end

//******************H2 + H4***********************
assign x6k_2_add_x6k_4 = x6k_2 + x6k_4;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_2_add_x6k_4_reg<=0;
    else x6k_2_add_x6k_4_reg<=x6k_2_add_x6k_4;
end

CSD_CSA15 H2H4(.x(x6k_2_add_x6k_4_reg) ,.y(H2_H4_mult[0]));
CSD_CSA14 H2H4_1(.x(x6k_2_add_x6k_4_reg) ,.y(H2_H4_mult[1]));
CSD_CSA13 H2H4_2(.x(x6k_2_add_x6k_4_reg) ,.y(H2_H4_mult[2]));
CSD_CSA12 H2H4_3(.x(x6k_2_add_x6k_4_reg) ,.y(H2_H4_mult[3]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H2_H4_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H2_H4_mult_reg[j]<=H2_H4_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_H4_stage_one_temp<=0;
    else H2_H4_stage_one_temp<=H2_H4_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H2_H4_add_reg[j]<=0;
    end
    else begin
        H2_H4_add_reg[2] <= H2_H4_stage_one_temp + H2_H4_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H2_H4_add_reg[j]<= H2_H4_mult_reg[j] + H2_H4_add_reg[j+1];
    end
end



//******************H3 + H5***********************
assign x6k_3_add_x6k_5 = x6k_3 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_3_add_x6k_5_reg<=0;
    else x6k_3_add_x6k_5_reg<=x6k_3_add_x6k_5;
end


CSD_CSA16 H3H5(.x(x6k_3_add_x6k_5_reg) ,.y(H3_H5_mult[0]));
CSD_CSA17 H3H5_1(.x(x6k_3_add_x6k_5_reg) ,.y(H3_H5_mult[1]));
CSD_CSA18 H3H5_2(.x(x6k_3_add_x6k_5_reg) ,.y(H3_H5_mult[2]));
CSD_CSA19 H3H5_3(.x(x6k_3_add_x6k_5_reg) ,.y(H3_H5_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H3_H5_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H3_H5_mult_reg[j]<=H3_H5_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H3_H5_stage_one_temp<=0;
    else H3_H5_stage_one_temp<=H3_H5_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H3_H5_add_reg[j]<=0;
    end
    else begin
        H3_H5_add_reg[2] <= H3_H5_stage_one_temp + H3_H5_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H3_H5_add_reg[j]<= H3_H5_mult_reg[j] + H3_H5_add_reg[j+1];
    end
end

//******************H0 + H2***********************
assign x6k_add_x6k_2 = x6k + x6k_2;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_add_x6k_2_reg<=0;
    else x6k_add_x6k_2_reg<=x6k_add_x6k_2;
end


CSD_CSA19 H0H2(.x(x6k_add_x6k_2_reg) ,.y(H0_H2_mult[0]));
CSD_CSA18 H0H2_1(.x(x6k_add_x6k_2_reg) ,.y(H0_H2_mult[1]));
CSD_CSA17 H0H2_2(.x(x6k_add_x6k_2_reg) ,.y(H0_H2_mult[2]));
CSD_CSA16 H0H2_3(.x(x6k_add_x6k_2_reg) ,.y(H0_H2_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H0_H2_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H0_H2_mult_reg[j]<=H0_H2_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H2_stage_one_temp<=0;
    else H0_H2_stage_one_temp<=H0_H2_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0_H2_add_reg[j]<=0;
    end
    else begin
        H0_H2_add_reg[2] <= H0_H2_stage_one_temp + H0_H2_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H0_H2_add_reg[j]<= H0_H2_mult_reg[j] + H0_H2_add_reg[j+1];
    end
end


//******************H0 + H1***********************
assign x6k_add_x6k_1 = x6k + x6k_1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_add_x6k_1_reg<=0;
    else x6k_add_x6k_1_reg<=x6k_add_x6k_1;
end


CSD_CSA20 H0H1(.x(x6k_add_x6k_1_reg) ,.y(H0_H1_mult[0]));
CSD_CSA21 H0H1_1(.x(x6k_add_x6k_1_reg) ,.y(H0_H1_mult[1]));
CSD_CSA22 H0H1_2(.x(x6k_add_x6k_1_reg) ,.y(H0_H1_mult[2]));
CSD_CSA23 H0H1_3(.x(x6k_add_x6k_1_reg) ,.y(H0_H1_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H0_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H0_H1_mult_reg[j]<=H0_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H1_stage_one_temp<=0;
    else H0_H1_stage_one_temp<=H0_H1_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0_H1_add_reg[j]<=0;
    end
    else begin
        H0_H1_add_reg[2] <= H0_H1_stage_one_temp + H0_H1_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H0_H1_add_reg[j]<= H0_H1_mult_reg[j] + H0_H1_add_reg[j+1];
    end
end

//******************H4 + H5***********************
assign x6k_4_add_x6k_5 = x6k_4 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_4_add_x6k_5_reg<=0;
    else x6k_4_add_x6k_5_reg<=x6k_4_add_x6k_5;
end


CSD_CSA23 H4H5(.x(x6k_4_add_x6k_5_reg) ,.y(H4_H5_mult[0]));
CSD_CSA22 H4H5_1(.x(x6k_4_add_x6k_5_reg) ,.y(H4_H5_mult[1]));
CSD_CSA21 H4H5_2(.x(x6k_4_add_x6k_5_reg) ,.y(H4_H5_mult[2]));
CSD_CSA20 H4H5_3(.x(x6k_4_add_x6k_5_reg) ,.y(H4_H5_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1)
            H4_H5_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<4;j=j+1)
            H4_H5_mult_reg[j]<=H4_H5_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H4_H5_stage_one_temp<=0;
    else H4_H5_stage_one_temp<=H4_H5_mult_reg[3];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H4_H5_add_reg[j]<=0;
    end
    else begin
        H4_H5_add_reg[2] <= H4_H5_stage_one_temp + H4_H5_mult_reg[2];
        for(j=0;j<2;j=j+1)
            H4_H5_add_reg[j]<= H4_H5_mult_reg[j] + H4_H5_add_reg[j+1];
    end
end


//******************H2 + H3***********************

assign x6k_2_add_x6k_3 = x6k_2 + x6k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_2_add_x6k_3_reg<=0;
    else x6k_2_add_x6k_3_reg<=x6k_2_add_x6k_3;
end


CSD_CSA24 H2H3(.x(x6k_2_add_x6k_3_reg) ,.y(H2_H3_mult[0]));
CSD_CSA25 H2H3_1(.x(x6k_2_add_x6k_3_reg) ,.y(H2_H3_mult[1]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H2_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<2;j=j+1)
            H2_H3_mult_reg[j]<=H2_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_H3_stage_one_temp<=0;
    else H2_H3_stage_one_temp<=H2_H3_mult_reg[0];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H2_H3_add_reg[j]<=0;
    end
    else begin
        H2_H3_add_reg[2] <= H2_H3_stage_one_temp + H2_H3_mult_reg[1];
        for(j=0;j<2;j=j+1)
            H2_H3_add_reg[j]<= H2_H3_mult_reg[j] + H2_H3_add_reg[j+1];
    end
end

//******************H1 + H3 + H5***********************

assign x6k_135 = x6k_1 +  x6k_3 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_135_reg<=0;
    else x6k_135_reg<=x6k_135;
end


CSD_CSA26 H135_0(.x(x6k_135_reg) ,.y(H135_mult[0]));
CSD_CSA27 H135_1(.x(x6k_135_reg) ,.y(H135_mult[1]));
CSD_CSA28 H135_2(.x(x6k_135_reg) ,.y(H135_mult[2]));
CSD_CSA29 H135_3(.x(x6k_135_reg) ,.y(H135_mult[3]));

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
        for(j=0;j<2;j=j+1)
           H135_add_reg[j]<=H135_add_reg[j+1] + H135_mult_reg[j];
    end
end

//******************H0 + H2 + H4***********************

assign x6k_024 = x6k +  x6k_2 + x6k_4 ;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_024_reg<=0;
    else x6k_024_reg<=x6k_024;
end


CSD_CSA29 H024_0(.x(x6k_024_reg) ,.y(H024_mult[0]));
CSD_CSA28 H024_1(.x(x6k_024_reg) ,.y(H024_mult[1]));
CSD_CSA27 H024_2(.x(x6k_024_reg) ,.y(H024_mult[2]));
CSD_CSA26 H024_3(.x(x6k_024_reg) ,.y(H024_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H024_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H024_mult_reg[j]<=H024_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H024_stage_one_temp<=0;
    end
    else begin
        H024_stage_one_temp<=H024_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H024_add_reg[j]<=0;
    end
    else begin
        H024_add_reg[2]<=H024_stage_one_temp + H024_mult_reg[2];
        for(j=0;j<2;j=j+1)
           H024_add_reg[j]<=H024_add_reg[j+1] + H024_mult_reg[j];
    end
end



//******************H0 + H1 + H2 + H3***********************

assign x6k_0123 = x6k + x6k_1 + x6k_2 + x6k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_0123_reg<=0;
    else x6k_0123_reg<=x6k_0123;
end


CSD_CSA30 H0123_0(.x(x6k_0123_reg) ,.y(H0123_mult[0]));
CSD_CSA31 H0123_1(.x(x6k_0123_reg) ,.y(H0123_mult[1]));
CSD_CSA32 H0123_2(.x(x6k_0123_reg) ,.y(H0123_mult[2]));
CSD_CSA33 H0123_3(.x(x6k_0123_reg) ,.y(H0123_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0123_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
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
        H0123_stage_one_temp<=H0123_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0123_add_reg[j]<=0;
    end
    else begin
        H0123_add_reg[2]<=H0123_stage_one_temp + H0123_mult_reg[2];
        for(j=0;j<2;j=j+1)
           H0123_add_reg[j]<=H0123_add_reg[j+1] + H0123_mult_reg[j];
    end
end


//******************H2 + H3 + H4 + H5***********************

assign x6k_2345 = x6k_2 + x6k_3 + x6k_4 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_2345_reg<=0;
    else x6k_2345_reg<=x6k_2345;
end


CSD_CSA33 H2345_0(.x(x6k_2345_reg) ,.y(H2345_mult[0]));
CSD_CSA32 H2345_1(.x(x6k_2345_reg) ,.y(H2345_mult[1]));
CSD_CSA31 H2345_2(.x(x6k_2345_reg) ,.y(H2345_mult[2]));
CSD_CSA30 H2345_3(.x(x6k_2345_reg) ,.y(H2345_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H2345_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H2345_mult_reg[j]<=H2345_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H2345_stage_one_temp<=0;
    end
    else begin
        H2345_stage_one_temp<=H2345_mult_reg[3];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H2345_add_reg[j]<=0;
    end
    else begin
        H2345_add_reg[2]<=H2345_stage_one_temp + H2345_mult_reg[2];
        for(j=0;j<2;j=j+1)
           H2345_add_reg[j]<=H2345_add_reg[j+1] + H2345_mult_reg[j];
    end
end


//******************H0 + H1 + H2 + H3 + H4 + H5***********************

wire [15:0] s4,c4,s5,c5;
CSA #(16) INPUT_ADD4(.a(x6k) ,.b(x6k_1) ,.c(x6k_2) ,.sum(s4) ,.carry(c4));
CSA #(16) INPUT_ADD5(.a(x6k_3) ,.b(x6k_4) ,.c(x6k_5) ,.sum(s5) ,.carry(c5));
wire [16:0] s4_ext,c4_ext,c5_ext;
assign s4_ext = {s4[15],s4};
assign c4_ext = {c4,1'b0};
assign c5_ext = {c5,1'b0};
wire [16:0] s6,c6;
CSA #(17) INPUT_ADD6(.a(c4_ext) ,.b(s4_ext) ,.c(c5_ext) ,.sum(s6) ,.carry(c6));
wire  [17:0] s5_ext,s6_ext,c6_ext;
assign s6_ext = {s6[16],s6};
assign c6_ext = {c6,1'b0};
assign s5_ext = {{2{s5[15]}},s5};
wire signed [17:0] s7,c7;
CSA #(18) INPUT_ADD7(.a(c6_ext) ,.b(s6_ext) ,.c(s5_ext) ,.sum(s7) ,.carry(c7));
//assign x6k_012345 = s7 + (c7 << 1);
assign x6k_012345 = x6k + x6k_1 + x6k_2 + x6k_3 + x6k_4 + x6k_5;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x6k_012345_reg<=0;
    else x6k_012345_reg<=x6k_012345;
end


CSD_CSA34 H012345_0(.x(x6k_012345_reg) ,.y(H012345_mult[0]));
CSD_CSA35 H012345_1(.x(x6k_012345_reg) ,.y(H012345_mult[1]));

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


//***************************************

/*assign w = H0_add_reg[0] + y6k_temp;
assign x = H0_H1_add_reg[0] + y6k_1_temp - H0_add_reg[0] - H1_add_reg[0];
assign y = H0_H2_add_reg[0] - H0_add_reg[0] - H2_add_reg[0] + H1_add_reg[0] + y6k_2_temp;
assign z = H0123_add_reg[0] - H0_H1_add_reg[0] - H2_H3_add_reg[0] + H0_add_reg[0] + H2_add_reg[0] - H0_H2_add_reg[0] + H1_add_reg[0] + H3_add_reg[0] - H1_H3_add_reg[0] + y6k_3_temp;
assign v = H012345_add_reg[0] - H0123_add_reg[0] - H2345_add_reg[0] + 2*H2_H3_add_reg[0] - 2*H2_add_reg[0] - 2*H3_add_reg[0] + H1_H3_add_reg[0] 
            + H0_H2_add_reg[0] + H3_H5_add_reg[0] + H2_H4_add_reg[0] - H135_add_reg[0] - H024_add_reg[0];
assign u = H024_add_reg[0] - H0_H2_add_reg[0] - H2_H4_add_reg[0] + 2*H2_add_reg[0] + H1_H3_add_reg[0] - H1_add_reg[0] - H3_add_reg[0] + y6k_4_temp;*/

assign w = y6k_temp3 + y6k_temp4;
assign x = y6k_1_temp3 + y6k_1_temp4;
assign y = y6k_2_temp2 + y6k_2_temp3;
assign z = y6k_3_temp3 + y6k_3_temp4 + y6k_3_temp5 + y6k_3_temp2;
assign v = y6k_5_temp + y6k_5_temp2 + y6k_5_temp3 + y6k_5_temp4;
assign u = y6k_4_temp3 + y6k_4_temp4 + y6k_4_temp2;

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
        y6k_1_temp<=0;
        y6k_1_temp2<=0;
        y6k_1_temp3<=0;
        y6k_1_temp4<=0;        
        y6k_2_temp<=0;
        y6k_2_temp2<=0;
        y6k_2_temp3<=0;        
        y6k_3_temp<=0;
        y6k_3_temp2<=0;
        y6k_3_temp3<=0;
        y6k_3_temp4<=0;
        y6k_3_temp5<=0;        
        y6k_4_temp<=0;
        y6k_4_temp2<=0;
        y6k_4_temp3<=0;
        y6k_4_temp4<=0;  
        y6k_5_temp<=0; 
        y6k_5_temp2<=0;        
        y6k_5_temp3<=0;        
        y6k_5_temp4<=0;                
    end
    else begin
        y6k_temp<=H135_add_reg[0] - H1_H3_add_reg[0] + H3_add_reg[0] - H4_add_reg[0];
        y6k_temp2<=H2_H4_add_reg[0] + H3_add_reg[0] - H3_H5_add_reg[0] - H2_add_reg[0];
        y6k_temp3<=y6k_temp + y6k_temp2;
        y6k_temp4<=H0_add_reg[0];
        y6k_1_temp<=H2345_add_reg[0] - H2_H3_add_reg[0] + H2_add_reg[0];
        y6k_1_temp2<=H3_add_reg[0] - H2_H4_add_reg[0] - H3_H5_add_reg[0];
        y6k_1_temp3<=y6k_1_temp - y6k_3_temp + y6k_1_temp2;
        y6k_1_temp4<=H0_H1_add_reg[0] - H0_add_reg[0] - H1_add_reg[0];
        y6k_2_temp<= H3_H5_add_reg[0] - H3_add_reg[0] - H5_add_reg[0] + H4_add_reg[0];
        y6k_2_temp2<=y6k_2_temp;
        y6k_2_temp3<=H0_H2_add_reg[0] - H0_add_reg[0] - H2_add_reg[0] + H1_add_reg[0];
        y6k_3_temp<= H4_H5_add_reg[0] - H4_add_reg[0] - H5_add_reg[0];
        y6k_3_temp2<=y6k_3_temp;
        y6k_3_temp3<=H0123_add_reg[0] - H0_H1_add_reg[0] - H2_H3_add_reg[0] + H0_add_reg[0];
        y6k_3_temp4<=H2_add_reg[0] - H0_H2_add_reg[0] + H1_add_reg[0];
        y6k_3_temp5<=H3_add_reg[0] - H1_H3_add_reg[0];
        y6k_4_temp<=H5_add_reg[0];
        y6k_4_temp2<=y6k_4_temp;
        y6k_4_temp3<=H024_add_reg[0] - H0_H2_add_reg[0] - H2_H4_add_reg[0] + H2_add_reg[0];
        y6k_4_temp4<=H2_add_reg[0] + H1_H3_add_reg[0] - H1_add_reg[0] - H3_add_reg[0];
        y6k_5_temp<=H012345_add_reg[0] - H0123_add_reg[0] - H2345_add_reg[0] + H2_H3_add_reg[0];
        y6k_5_temp2<=H3_H5_add_reg[0] + H2_H4_add_reg[0] - H135_add_reg[0] - H024_add_reg[0];
        y6k_5_temp3<= H1_H3_add_reg[0] + H0_H2_add_reg[0] - H2_add_reg[0] - H3_add_reg[0];
        y6k_5_temp4<=H2_H3_add_reg[0] - H2_add_reg[0] - H3_add_reg[0];


        /*y6k_temp<=H135_add_reg[0] - H1_H3_add_reg[0] + 2*H3_add_reg[0] - H4_add_reg[0] - H3_H5_add_reg[0] - H2_add_reg[0] + H2_H4_add_reg[0];
        y6k_1_temp<=H2345_add_reg[0] - H2_H3_add_reg[0] - H4_H5_add_reg[0] + H2_add_reg[0] + H3_add_reg[0] + H4_add_reg[0] + H5_add_reg[0]
                    - H2_H4_add_reg[0] - H3_H5_add_reg[0];
        y6k_2_temp<= H3_H5_add_reg[0] - H3_add_reg[0] - H5_add_reg[0] + H4_add_reg[0];
        y6k_3_temp<= H4_H5_add_reg[0] - H4_add_reg[0] - H5_add_reg[0];
        y6k_4_temp<=H5_add_reg[0];*/
    end
end

endmodule
