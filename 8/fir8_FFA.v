//synopsys translate_off
`include "CSD_CSA_FFA.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x8k,x8k_1,x8k_2,x8k_3,x8k_4,x8k_5,x8k_6,x8k_7,
output reg signed [15:0] y8k,y8k_1,y8k_2,y8k_3,y8k_4,y8k_5,y8k_6,y8k_7);

integer j;
reg signed [15:0] x8k_reg,x8k_reg2,x8k_1_reg,x8k_1_reg2,x8k_2_reg,x8k_2_reg2,x8k_3_reg,x8k_3_reg2,x8k_4_reg,x8k_4_reg2,x8k_5_reg,x8k_5_reg2,x8k_6_reg,x8k_6_reg2,x8k_7_reg,x8k_7_reg2;
reg signed [16:0] x8k_add_x8k_2_reg,x8k_5_add_x8k_7_reg,x8k_1_add_x8k_3_reg,x8k_4_add_x8k_6_reg,x8k_1_add_x8k_5_reg,x8k_3_add_x8k_7_reg,
                  x8k_2_add_x8k_6_reg,x8k_add_x8k_1_reg,x8k_6_add_x8k_7_reg,x8k_2_add_x8k_3_reg,x8k_4_add_x8k_5_reg,x8k_add_x8k_4_reg;
reg signed [16:0] x8k_add_x8k_2_reg2,x8k_5_add_x8k_7_reg2,x8k_1_add_x8k_3_reg2,x8k_4_add_x8k_6_reg2,x8k_1_add_x8k_5_reg2,x8k_3_add_x8k_7_reg2,
                  x8k_2_add_x8k_6_reg2,x8k_add_x8k_1_reg2,x8k_6_add_x8k_7_reg2,x8k_2_add_x8k_3_reg2,x8k_4_add_x8k_5_reg2,x8k_add_x8k_4_reg2;
reg signed [17:0] x8k_0123_reg,x8k_4567_reg,x8k_1357_reg,x8k_0246_reg,x8k_2367_reg,x8k_0145_reg;
reg signed [17:0] x8k_0123_reg2,x8k_4567_reg2,x8k_1357_reg2,x8k_0246_reg2,x8k_2367_reg2,x8k_0145_reg2;
reg signed [18:0] x8k_01234567_reg;
// H0 H1 H2 H3 H4 H5 H6 H7 H0+H2 H5+H7 H1+H3 H4+H6 H1+H5 H2+H6 H0+H1 H6+H7 H2+H3 H4+H5 BLOCK def
wire [31:0] H0_mult [2:0],H1_mult [2:0],H2_mult [2:0],H3_mult [2:0],H4_mult [2:0],H5_mult [2:0],H6_mult [2:0],H7_mult [2:0];
reg signed [31:0] H0_mult_reg [2:0],H1_mult_reg [2:0],H2_mult_reg [2:0],H3_mult_reg [2:0],H4_mult_reg [2:0],H5_mult_reg [2:0],H6_mult_reg [2:0],H7_mult_reg [2:0];
reg signed [31:0] H0_add_reg [1:0],H1_add_reg [1:0],H2_add_reg [1:0],H3_add_reg [1:0],H4_add_reg [1:0],H5_add_reg [1:0],
                  H6_add_reg [1:0],H7_add_reg [1:0]; //HX_add_reg[0] is output of HX
reg signed [31:0] H0_stage_one_temp,H1_stage_one_temp,H2_stage_one_temp,H3_stage_one_temp,H4_stage_one_temp,H5_stage_one_temp,H6_stage_one_temp,H7_stage_one_temp;
wire [32:0] H0_H2_mult [2:0],H5_H7_mult [2:0],H1_H3_mult [2:0],H4_H6_mult [2:0],H1_H5_mult [2:0],H2_H6_mult [2:0],H3_H7_mult [2:0],H0_H4_mult [2:0],H6_H7_mult [2:0],H0_H1_mult [2:0];
reg signed [32:0] H0_H2_mult_reg [2:0],H5_H7_mult_reg [2:0],H1_H3_mult_reg [2:0],H4_H6_mult_reg [2:0],H1_H5_mult_reg [2:0],H2_H6_mult_reg [2:0],
                  H0_H1_mult_reg [2:0],H6_H7_mult_reg [2:0],H0_H4_mult_reg [2:0],H3_H7_mult_reg [2:0];
reg signed [32:0] H0_H2_add_reg [1:0],H5_H7_add_reg [1:0],H1_H3_add_reg [1:0],H4_H6_add_reg [1:0],H1_H5_add_reg [1:0],H2_H6_add_reg [1:0],
                  H0_H1_add_reg [1:0],H6_H7_add_reg [1:0],H0_H4_add_reg [1:0],H3_H7_add_reg [1:0];
reg signed [32:0] H0_H2_stage_one_temp,H5_H7_stage_one_temp,H1_H3_stage_one_temp,H4_H6_stage_one_temp,H1_H5_stage_one_temp,H2_H6_stage_one_temp,
                  H0_H1_stage_one_temp,H6_H7_stage_one_temp,H0_H4_stage_one_temp,H3_H7_stage_one_temp;
wire [33:0] H2_H3_mult [2:0],H4_H5_mult [2:0];
reg signed [33:0] H2_H3_mult_reg [2:0],H4_H5_mult_reg [2:0];
reg signed [33:0] H2_H3_add_reg [1:0],H4_H5_add_reg [1:0];
reg signed [33:0] H2_H3_stage_one_temp,H4_H5_stage_one_temp;

// H0+H1+H2+H3 H4+H5+H6+H7 H0+H1+H4+H5 H2+H3+H6+H7 H0+H2+H4+H6 H1+H3+H5+H7 H0+..+H7  BLOCK def
wire [33:0] H0123_mult [2:0],H4567_mult [2:0],H0145_mult [2:0],H2367_mult [2:0],H0246_mult [2:0],H1357_mult [2:0];
reg signed [33:0] H0123_mult_reg [2:0],H4567_mult_reg [2:0],H0145_mult_reg [2:0],H2367_mult_reg [2:0],H0246_mult_reg [2:0],H1357_mult_reg [2:0];
reg signed [33:0] H0123_add_reg [1:0],H4567_add_reg [1:0],H0145_add_reg [1:0],H2367_add_reg [1:0],H0246_add_reg [1:0],H1357_add_reg [1:0];
reg signed [33:0] H0123_stage_one_temp,H4567_stage_one_temp,H0145_stage_one_temp,H2367_stage_one_temp,H0246_stage_one_temp,H1357_stage_one_temp;
wire [35:0] H01234567_mult [1:0];
reg signed [35:0] H01234567_mult_reg [1:0];
reg signed [35:0] H01234567_add_reg [1:0];
reg signed [35:0] H01234567_stage_one_temp;

reg signed [32:0] y8k_temp,y8k_temp2,y8k_temp3,y8k_temp4,y8k_temp5,y8k_1_temp,y8k_1_temp2,y8k_1_temp3,y8k_1_temp4,y8k_1_temp5;
reg signed [32:0] y8k_2_temp,y8k_2_temp2,y8k_2_temp3,y8k_2_temp4,y8k_3_temp,y8k_3_temp2,y8k_3_temp3,y8k_3_temp4,y8k_3_temp5;
reg signed [32:0] y8k_4_temp,y8k_4_temp2,y8k_4_temp3,y8k_4_temp4,y8k_5_temp,y8k_5_temp2,y8k_5_temp3,y8k_5_temp4,y8k_5_temp5;
reg signed [32:0] y8k_6_temp,y8k_6_temp2,y8k_6_temp3,y8k_6_temp4,y8k_6_temp5,y8k_7_temp,y8k_7_temp2,y8k_7_temp3,y8k_7_temp4,y8k_7_temp5;

wire signed [31:0] s,t,u,v,w,x,y,z;


///************H0 H1 H2 H3 H4 H5 H6 H7 BLOCK ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_reg<=0;
        x8k_reg2<=0;        
        x8k_1_reg<=0;
        x8k_1_reg2<=0;        
        x8k_2_reg<=0;
        x8k_2_reg2<=0;                
        x8k_3_reg<=0;
        x8k_3_reg2<=0;                
        x8k_4_reg<=0;
        x8k_4_reg2<=0;                
        x8k_5_reg<=0;
        x8k_5_reg2<=0;        
        x8k_6_reg<=0;
        x8k_6_reg2<=0;                
        x8k_7_reg<=0;
        x8k_7_reg2<=0;                
    end
    else begin
        x8k_reg<=x8k;
        x8k_reg2<=x8k_reg;        
        x8k_1_reg<=x8k_1;
        x8k_1_reg2<=x8k_1_reg;        
        x8k_2_reg<=x8k_2;
        x8k_2_reg2<=x8k_2_reg;                
        x8k_3_reg<=x8k_3;
        x8k_3_reg2<=x8k_3_reg;                
        x8k_4_reg<=x8k_4;
        x8k_4_reg2<=x8k_4_reg;                
        x8k_5_reg<=x8k_5;
        x8k_5_reg2<=x8k_5_reg;                
        x8k_6_reg<=x8k_6;
        x8k_6_reg2<=x8k_6_reg;                
        x8k_7_reg<=x8k_7;
        x8k_7_reg2<=x8k_7_reg;                
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H0_mult_reg[j]<=0;
            H1_mult_reg[j]<=0;
            H2_mult_reg[j]<=0;
            H3_mult_reg[j]<=0;  
            H4_mult_reg[j]<=0;
            H5_mult_reg[j]<=0;
            H6_mult_reg[j]<=0;
            H7_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H0_mult_reg[j]<=H0_mult[j];
            H1_mult_reg[j]<=H1_mult[j];
            H2_mult_reg[j]<=H2_mult[j];
            H3_mult_reg[j]<=H3_mult[j];
            H4_mult_reg[j]<=H4_mult[j];
            H5_mult_reg[j]<=H5_mult[j];
            H6_mult_reg[j]<=H6_mult[j];
            H7_mult_reg[j]<=H7_mult[j];
        end
    end
end

CSD_CSA0 H00(.x(x8k_reg2) ,.y(H0_mult[0]));
CSD_CSA8 H01(.x(x8k_reg2) ,.y(H0_mult[1]));
CSD_CSA7 H02(.x(x8k_reg2) ,.y(H0_mult[2]));

CSD_CSA1 H10(.x(x8k_1_reg2) ,.y(H1_mult[0]));
CSD_CSA9 H11(.x(x8k_1_reg2) ,.y(H1_mult[1]));
CSD_CSA6 H12(.x(x8k_1_reg2) ,.y(H1_mult[2]));

CSD_CSA2 H20(.x(x8k_2_reg2) ,.y(H2_mult[0]));
CSD_CSA10 H21(.x(x8k_2_reg2) ,.y(H2_mult[1]));
CSD_CSA5 H22(.x(x8k_2_reg2) ,.y(H2_mult[2]));

CSD_CSA3 H30(.x(x8k_3_reg2) ,.y(H3_mult[0]));
CSD_CSA11 H31(.x(x8k_3_reg2) ,.y(H3_mult[1]));
CSD_CSA4 H32(.x(x8k_3_reg2) ,.y(H3_mult[2]));

CSD_CSA4 H40(.x(x8k_4_reg2) ,.y(H4_mult[0]));
CSD_CSA11 H41(.x(x8k_4_reg2) ,.y(H4_mult[1]));
CSD_CSA3 H42(.x(x8k_4_reg2) ,.y(H4_mult[2]));

CSD_CSA5 H50(.x(x8k_5_reg2) ,.y(H5_mult[0]));
CSD_CSA10 H51(.x(x8k_5_reg2) ,.y(H5_mult[1]));
CSD_CSA2 H52(.x(x8k_5_reg2) ,.y(H5_mult[2]));

CSD_CSA6 H60(.x(x8k_6_reg2) ,.y(H6_mult[0]));
CSD_CSA9 H61(.x(x8k_6_reg2) ,.y(H6_mult[1]));
CSD_CSA1 H62(.x(x8k_6_reg2) ,.y(H6_mult[2]));

CSD_CSA7 H70(.x(x8k_7_reg2) ,.y(H7_mult[0]));
CSD_CSA8 H71(.x(x8k_7_reg2) ,.y(H7_mult[1]));
CSD_CSA0 H72(.x(x8k_7_reg2) ,.y(H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_stage_one_temp<=0;
        H1_stage_one_temp<=0;
        H2_stage_one_temp<=0;
        H3_stage_one_temp<=0;
        H4_stage_one_temp<=0;
        H5_stage_one_temp<=0;
        H6_stage_one_temp<=0;
        H7_stage_one_temp<=0;
    end
    else begin
        H0_stage_one_temp<=H0_mult_reg[2];
        H1_stage_one_temp<=H1_mult_reg[2];
        H2_stage_one_temp<=H2_mult_reg[2];
        H3_stage_one_temp<=H3_mult_reg[2];
        H4_stage_one_temp<=H4_mult_reg[2];
        H5_stage_one_temp<=H5_mult_reg[2];
        H6_stage_one_temp<=H6_mult_reg[2];
        H7_stage_one_temp<=H7_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H0_add_reg[j]<=0;
            H1_add_reg[j]<=0;
            H2_add_reg[j]<=0;
            H3_add_reg[j]<=0;
            H4_add_reg[j]<=0;
            H5_add_reg[j]<=0;
            H6_add_reg[j]<=0;
            H7_add_reg[j]<=0;
        end
    end
    else begin
        H0_add_reg[1] <= H0_stage_one_temp + H0_mult_reg[1];
        H1_add_reg[1] <= H1_stage_one_temp + H1_mult_reg[1];
        H2_add_reg[1] <= H2_stage_one_temp + H2_mult_reg[1];
        H3_add_reg[1] <= H3_stage_one_temp + H3_mult_reg[1];
        H4_add_reg[1] <= H4_stage_one_temp + H4_mult_reg[1];
        H5_add_reg[1] <= H5_stage_one_temp + H5_mult_reg[1];
        H6_add_reg[1] <= H6_stage_one_temp + H6_mult_reg[1];
        H7_add_reg[1] <= H7_stage_one_temp + H7_mult_reg[1];        
        H0_add_reg[0]<=H0_add_reg[1] + H0_mult_reg[0];
        H1_add_reg[0]<=H1_add_reg[1] + H1_mult_reg[0];
        H2_add_reg[0]<=H2_add_reg[1] + H2_mult_reg[0];
        H3_add_reg[0]<=H3_add_reg[1] + H3_mult_reg[0];
        H4_add_reg[0]<=H4_add_reg[1] + H4_mult_reg[0];
        H5_add_reg[0]<=H5_add_reg[1] + H5_mult_reg[0];
        H6_add_reg[0]<=H6_add_reg[1] + H6_mult_reg[0];
        H7_add_reg[0]<=H7_add_reg[1] + H7_mult_reg[0];
    end
end

//******************H0 + H2***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_add_x8k_2_reg<=0;
        x8k_add_x8k_2_reg2<=0;
    end
    else begin
        x8k_add_x8k_2_reg<=x8k + x8k_2;
        x8k_add_x8k_2_reg2<=x8k_add_x8k_2_reg;
    end
end


CSD_CSA12 H0H2(.x(x8k_add_x8k_2_reg2) ,.y(H0_H2_mult[0]));
CSD_CSA13 H0H2_1(.x(x8k_add_x8k_2_reg2) ,.y(H0_H2_mult[1]));
CSD_CSA14 H0H2_2(.x(x8k_add_x8k_2_reg2) ,.y(H0_H2_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0_H2_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H0_H2_mult_reg[j]<=H0_H2_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H2_stage_one_temp<=0;
    else H0_H2_stage_one_temp<=H0_H2_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0_H2_add_reg[j]<=0;
    end
    else begin
        H0_H2_add_reg[1] <= H0_H2_stage_one_temp + H0_H2_mult_reg[1];
        H0_H2_add_reg[0]<= H0_H2_mult_reg[0] + H0_H2_add_reg[1];
    end
end

//******************H5 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_5_add_x8k_7_reg<=0;
        x8k_5_add_x8k_7_reg2<=0; 
    end
    else begin
        x8k_5_add_x8k_7_reg<=x8k_5 + x8k_7;
        x8k_5_add_x8k_7_reg2<=x8k_5_add_x8k_7_reg;
    end
end


CSD_CSA14 H5H7(.x(x8k_5_add_x8k_7_reg2) ,.y(H5_H7_mult[0]));
CSD_CSA13 H5H7_1(.x(x8k_5_add_x8k_7_reg2) ,.y(H5_H7_mult[1]));
CSD_CSA12 H5H7_2(.x(x8k_5_add_x8k_7_reg2) ,.y(H5_H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H5_H7_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H5_H7_mult_reg[j]<=H5_H7_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H5_H7_stage_one_temp<=0;
    else H5_H7_stage_one_temp<=H5_H7_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H5_H7_add_reg[j]<=0;
    end
    else begin
        H5_H7_add_reg[1] <= H5_H7_stage_one_temp + H5_H7_mult_reg[1];
        H5_H7_add_reg[0]<= H5_H7_mult_reg[0] + H5_H7_add_reg[1];
    end
end


//******************H1 + H3***********************

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_1_add_x8k_3_reg<=0;
        x8k_1_add_x8k_3_reg2<=0;
    end
    else begin
        x8k_1_add_x8k_3_reg<=x8k_1 + x8k_3;
        x8k_1_add_x8k_3_reg2<=x8k_1_add_x8k_3_reg;
    end
end

CSD_CSA15 H1H3(.x(x8k_1_add_x8k_3_reg2) ,.y(H1_H3_mult[0]));
CSD_CSA16 H1H3_1(.x(x8k_1_add_x8k_3_reg2) ,.y(H1_H3_mult[1]));
CSD_CSA17 H1H3_2(.x(x8k_1_add_x8k_3_reg2) ,.y(H1_H3_mult[2]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H1_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H1_H3_mult_reg[j]<=H1_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H3_stage_one_temp<=0;
    else H1_H3_stage_one_temp<=H1_H3_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H1_H3_add_reg[j]<=0;
    end
    else begin
        H1_H3_add_reg[1] <= H1_H3_stage_one_temp + H1_H3_mult_reg[1];
        H1_H3_add_reg[0]<= H1_H3_mult_reg[0] + H1_H3_add_reg[1];
    end
end

//******************H4 + H6***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_4_add_x8k_6_reg<=0;
        x8k_4_add_x8k_6_reg2<=0;  
    end
    else begin
        x8k_4_add_x8k_6_reg<=x8k_4 + x8k_6;
        x8k_4_add_x8k_6_reg2<=x8k_4_add_x8k_6_reg;
    end
end

CSD_CSA17 H4H6(.x(x8k_4_add_x8k_6_reg2) ,.y(H4_H6_mult[0]));
CSD_CSA16 H4H6_1(.x(x8k_4_add_x8k_6_reg2) ,.y(H4_H6_mult[1]));
CSD_CSA15 H4H6_2(.x(x8k_4_add_x8k_6_reg2) ,.y(H4_H6_mult[2]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H4_H6_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H4_H6_mult_reg[j]<=H4_H6_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H4_H6_stage_one_temp<=0;
    else H4_H6_stage_one_temp<=H4_H6_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H4_H6_add_reg[j]<=0;
    end
    else begin
        H4_H6_add_reg[1] <= H4_H6_stage_one_temp + H4_H6_mult_reg[1];
        H4_H6_add_reg[0]<= H4_H6_mult_reg[0] + H4_H6_add_reg[1];
    end
end



//******************H1 + H5***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_1_add_x8k_5_reg<=0;
        x8k_1_add_x8k_5_reg2<=0;
    end 
    else begin
        x8k_1_add_x8k_5_reg<=x8k_1 + x8k_5;
        x8k_1_add_x8k_5_reg2<=x8k_1_add_x8k_5_reg;
    end
end


CSD_CSA18 H1H5(.x(x8k_1_add_x8k_5_reg2) ,.y(H1_H5_mult[0]));
CSD_CSA19 H1H5_1(.x(x8k_1_add_x8k_5_reg2) ,.y(H1_H5_mult[1]));
CSD_CSA20 H1H5_2(.x(x8k_1_add_x8k_5_reg2) ,.y(H1_H5_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H1_H5_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H1_H5_mult_reg[j]<=H1_H5_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H5_stage_one_temp<=0;
    else H1_H5_stage_one_temp<=H1_H5_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H1_H5_add_reg[j]<=0;
    end
    else begin
        H1_H5_add_reg[1] <= H1_H5_stage_one_temp + H1_H5_mult_reg[1];
        H1_H5_add_reg[0]<= H1_H5_mult_reg[0] + H1_H5_add_reg[1];
    end
end

//******************H2 + H6***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_2_add_x8k_6_reg<=0;
        x8k_2_add_x8k_6_reg2<=0;
    end
    else begin
        x8k_2_add_x8k_6_reg<=x8k_2 + x8k_6;
        x8k_2_add_x8k_6_reg2<=x8k_2_add_x8k_6_reg;
    end
end


CSD_CSA20 H2H6(.x(x8k_2_add_x8k_6_reg2) ,.y(H2_H6_mult[0]));
CSD_CSA19 H2H6_1(.x(x8k_2_add_x8k_6_reg2) ,.y(H2_H6_mult[1]));
CSD_CSA18 H2H6_2(.x(x8k_2_add_x8k_6_reg2) ,.y(H2_H6_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H2_H6_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H2_H6_mult_reg[j]<=H2_H6_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_H6_stage_one_temp<=0;
    else H2_H6_stage_one_temp<=H2_H6_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H2_H6_add_reg[j]<=0;
    end
    else begin
        H2_H6_add_reg[1] <= H2_H6_stage_one_temp + H2_H6_mult_reg[1];
        H2_H6_add_reg[0]<= H2_H6_mult_reg[0] + H2_H6_add_reg[1];
    end
end


//******************H0 + H1***********************

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_add_x8k_1_reg<=0;
        x8k_add_x8k_1_reg2<=0; 
    end
    else begin
        x8k_add_x8k_1_reg<=x8k + x8k_1;
        x8k_add_x8k_1_reg2<=x8k_add_x8k_1_reg;
    end
end


CSD_CSA21 H0H1(.x(x8k_add_x8k_1_reg2) ,.y(H0_H1_mult[0]));
CSD_CSA22 H0H1_1(.x(x8k_add_x8k_1_reg2) ,.y(H0_H1_mult[1]));
CSD_CSA23 H0H1_2(.x(x8k_add_x8k_1_reg2) ,.y(H0_H1_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H0_H1_mult_reg[j]<=H0_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H1_stage_one_temp<=0;
    else H0_H1_stage_one_temp<=H0_H1_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0_H1_add_reg[j]<=0;
    end
    else begin
        H0_H1_add_reg[1] <= H0_H1_stage_one_temp + H0_H1_mult_reg[1];
        H0_H1_add_reg[0]<= H0_H1_mult_reg[0] + H0_H1_add_reg[1];
    end
end

//******************H6 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_6_add_x8k_7_reg<=0;
        x8k_6_add_x8k_7_reg2<=0;
    end
    else begin
        x8k_6_add_x8k_7_reg<=x8k_6 + x8k_7;
        x8k_6_add_x8k_7_reg2<=x8k_6_add_x8k_7_reg;
    end
end


CSD_CSA23 H6H7(.x(x8k_6_add_x8k_7_reg2) ,.y(H6_H7_mult[0]));
CSD_CSA22 H6H7_1(.x(x8k_6_add_x8k_7_reg2) ,.y(H6_H7_mult[1]));
CSD_CSA21 H6H7_2(.x(x8k_6_add_x8k_7_reg2) ,.y(H6_H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H6_H7_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H6_H7_mult_reg[j]<=H6_H7_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H6_H7_stage_one_temp<=0;
    else H6_H7_stage_one_temp<=H6_H7_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H6_H7_add_reg[j]<=0;
    end
    else begin
        H6_H7_add_reg[1] <= H6_H7_stage_one_temp + H6_H7_mult_reg[1];
        H6_H7_add_reg[0]<= H6_H7_mult_reg[0] + H6_H7_add_reg[1];
    end
end

//******************H0 + H4***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_add_x8k_4_reg<=0;
        x8k_add_x8k_4_reg2<=0;
    end
    else begin
        x8k_add_x8k_4_reg<=x8k + x8k_4;
        x8k_add_x8k_4_reg2<=x8k_add_x8k_4_reg;
    end
end


CSD_CSA24 H0H4(.x(x8k_add_x8k_4_reg2) ,.y(H0_H4_mult[0]));
CSD_CSA25 H0H4_1(.x(x8k_add_x8k_4_reg2) ,.y(H0_H4_mult[1]));
CSD_CSA26 H0H4_2(.x(x8k_add_x8k_4_reg2) ,.y(H0_H4_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H0_H4_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H0_H4_mult_reg[j]<=H0_H4_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H4_stage_one_temp<=0;
    else H0_H4_stage_one_temp<=H0_H4_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0_H4_add_reg[j]<=0;
    end
    else begin
        H0_H4_add_reg[1] <= H0_H4_stage_one_temp + H0_H4_mult_reg[1];
        H0_H4_add_reg[0]<= H0_H4_mult_reg[0] + H0_H4_add_reg[1];
    end
end

//******************H3 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_3_add_x8k_7_reg<=0;
        x8k_3_add_x8k_7_reg2<=0;
    end
    else begin
        x8k_3_add_x8k_7_reg<=x8k_3 + x8k_7;
        x8k_3_add_x8k_7_reg2<=x8k_3_add_x8k_7_reg;
    end
end


CSD_CSA26 H3H7(.x(x8k_3_add_x8k_7_reg2) ,.y(H3_H7_mult[0]));
CSD_CSA25 H3H7_1(.x(x8k_3_add_x8k_7_reg2) ,.y(H3_H7_mult[1]));
CSD_CSA24 H3H7_2(.x(x8k_3_add_x8k_7_reg2) ,.y(H3_H7_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H3_H7_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H3_H7_mult_reg[j]<=H3_H7_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H3_H7_stage_one_temp<=0;
    else H3_H7_stage_one_temp<=H3_H7_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H3_H7_add_reg[j]<=0;
    end
    else begin
        H3_H7_add_reg[1] <= H3_H7_stage_one_temp + H3_H7_mult_reg[1];
        H3_H7_add_reg[0]<= H3_H7_mult_reg[0] + H3_H7_add_reg[1];
    end
end


//******************H4 + H5***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_4_add_x8k_5_reg<=0;
        x8k_4_add_x8k_5_reg2<=0;
    end  
    else begin
        x8k_4_add_x8k_5_reg<=x8k_4 + x8k_5;
        x8k_4_add_x8k_5_reg2<=x8k_4_add_x8k_5_reg;
    end
end


CSD_CSA29 H4H5(.x(x8k_4_add_x8k_5_reg2) ,.y(H4_H5_mult[0]));
CSD_CSA28 H4H5_1(.x(x8k_4_add_x8k_5_reg2) ,.y(H4_H5_mult[1]));
CSD_CSA27 H4H5_2(.x(x8k_4_add_x8k_5_reg2) ,.y(H4_H5_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H4_H5_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H4_H5_mult_reg[j]<=H4_H5_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H4_H5_stage_one_temp<=0;
    else H4_H5_stage_one_temp<=H4_H5_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H4_H5_add_reg[j]<=0;
    end
    else begin
        H4_H5_add_reg[1] <= H4_H5_stage_one_temp + H4_H5_mult_reg[1];
        H4_H5_add_reg[0]<= H4_H5_mult_reg[0] + H4_H5_add_reg[1];
    end
end

//******************H2 + H3***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_2_add_x8k_3_reg<=0;
        x8k_2_add_x8k_3_reg2<=0;
    end
    else begin
        x8k_2_add_x8k_3_reg<=x8k_2 + x8k_3;
        x8k_2_add_x8k_3_reg2<=x8k_2_add_x8k_3_reg;
    end
end


CSD_CSA27 H2H3(.x(x8k_2_add_x8k_3_reg2) ,.y(H2_H3_mult[0]));
CSD_CSA28 H2H3_1(.x(x8k_2_add_x8k_3_reg2) ,.y(H2_H3_mult[1]));
CSD_CSA29 H2H3_2(.x(x8k_2_add_x8k_3_reg2) ,.y(H2_H3_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1)
            H2_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<3;j=j+1)
            H2_H3_mult_reg[j]<=H2_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_H3_stage_one_temp<=0;
    else H2_H3_stage_one_temp<=H2_H3_mult_reg[2];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H2_H3_add_reg[j]<=0;
    end
    else begin
        H2_H3_add_reg[1] <= H2_H3_stage_one_temp + H2_H3_mult_reg[1];
        H2_H3_add_reg[0]<= H2_H3_mult_reg[0] + H2_H3_add_reg[1];
    end
end

//******************H0 + H1 + H2 + H3***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0123_reg<=0;
        x8k_0123_reg2<=0;
    end
    else begin
        x8k_0123_reg<=x8k + x8k_1 + x8k_2 + x8k_3;
        x8k_0123_reg2<=x8k_0123_reg;
    end
end


CSD_CSA30 H0123_0(.x(x8k_0123_reg2) ,.y(H0123_mult[0]));
CSD_CSA31 H0123_1(.x(x8k_0123_reg2) ,.y(H0123_mult[1]));
CSD_CSA32 H0123_2(.x(x8k_0123_reg2) ,.y(H0123_mult[2]));

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
        H0123_stage_one_temp<=H0123_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0123_add_reg[j]<=0;
    end
    else begin
        H0123_add_reg[1]<=H0123_stage_one_temp + H0123_mult_reg[1];
        H0123_add_reg[0]<=H0123_add_reg[1] + H0123_mult_reg[0];
    end
end

//******************H4 + H5 + H6 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_4567_reg<=0;
        x8k_4567_reg2<=0;
    end 
    else begin
        x8k_4567_reg<=x8k_4 + x8k_5 + x8k_6 + x8k_7;
        x8k_4567_reg2<=x8k_4567_reg;
    end
end


CSD_CSA32 H4567_0(.x(x8k_4567_reg2) ,.y(H4567_mult[0]));
CSD_CSA31 H4567_1(.x(x8k_4567_reg2) ,.y(H4567_mult[1]));
CSD_CSA30 H4567_2(.x(x8k_4567_reg2) ,.y(H4567_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H4567_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H4567_mult_reg[j]<=H4567_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H4567_stage_one_temp<=0;
    end
    else begin
        H4567_stage_one_temp<=H4567_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H4567_add_reg[j]<=0;
    end
    else begin
        H4567_add_reg[1]<=H4567_stage_one_temp + H4567_mult_reg[1];
        H4567_add_reg[0]<=H4567_add_reg[1] + H4567_mult_reg[0];
    end
end

//******************H0 + H1 + H4 + H5***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0145_reg<=0;
        x8k_0145_reg2<=0;  
    end
    else begin
        x8k_0145_reg<=x8k + x8k_1 + x8k_4 + x8k_5;
        x8k_0145_reg2<=x8k_0145_reg;
    end
end


CSD_CSA33 H0145_0(.x(x8k_0145_reg2) ,.y(H0145_mult[0]));
CSD_CSA31 H0145_1(.x(x8k_0145_reg2) ,.y(H0145_mult[1]));
CSD_CSA34 H0145_2(.x(x8k_0145_reg2) ,.y(H0145_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0145_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H0145_mult_reg[j]<=H0145_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0145_stage_one_temp<=0;
    end
    else begin
        H0145_stage_one_temp<=H0145_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0145_add_reg[j]<=0;
    end
    else begin
        H0145_add_reg[1]<=H0145_stage_one_temp + H0145_mult_reg[1];
        H0145_add_reg[0]<=H0145_add_reg[1] + H0145_mult_reg[0];
    end
end

//******************H2 + H3 + H6 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_2367_reg<=0;
        x8k_2367_reg2<=0;
    end
    else begin
        x8k_2367_reg<=x8k_2 + x8k_3 + x8k_6 + x8k_7;
        x8k_2367_reg2<=x8k_2367_reg;
    end
end

CSD_CSA34 H2367_0(.x(x8k_2367_reg2) ,.y(H2367_mult[0]));
CSD_CSA31 H2367_1(.x(x8k_2367_reg2) ,.y(H2367_mult[1]));
CSD_CSA33 H2367_2(.x(x8k_2367_reg2) ,.y(H2367_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H2367_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H2367_mult_reg[j]<=H2367_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H2367_stage_one_temp<=0;
    end
    else begin
        H2367_stage_one_temp<=H2367_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H2367_add_reg[j]<=0;
    end
    else begin
        H2367_add_reg[1]<=H2367_stage_one_temp + H2367_mult_reg[1];
        H2367_add_reg[0]<=H2367_add_reg[1] + H2367_mult_reg[0];
    end
end

//******************H0 + H2 + H4 + H6***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_0246_reg<=0;
        x8k_0246_reg2<=0; 
    end
    else begin
        x8k_0246_reg<=x8k + x8k_2 + x8k_4 + x8k_6;
        x8k_0246_reg2<=x8k_0246_reg;
    end
end


CSD_CSA35 H0246_0(.x(x8k_0246_reg2) ,.y(H0246_mult[0]));
CSD_CSA31 H0246_1(.x(x8k_0246_reg2) ,.y(H0246_mult[1]));
CSD_CSA36 H0246_2(.x(x8k_0246_reg2) ,.y(H0246_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0246_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H0246_mult_reg[j]<=H0246_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0246_stage_one_temp<=0;
    end
    else begin
        H0246_stage_one_temp<=H0246_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H0246_add_reg[j]<=0;
    end
    else begin
        H0246_add_reg[1]<=H0246_stage_one_temp + H0246_mult_reg[1];
        H0246_add_reg[0]<=H0246_add_reg[1] + H0246_mult_reg[0];
    end
end

//******************H1 + H3 + H5 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x8k_1357_reg<=0;
        x8k_1357_reg2<=0; 
    end
    else begin
        x8k_1357_reg<=x8k_1 + x8k_3 + x8k_5 + x8k_7;
        x8k_1357_reg2<=x8k_1357_reg;
    end
end


CSD_CSA36 H1357_0(.x(x8k_1357_reg2) ,.y(H1357_mult[0]));
CSD_CSA31 H1357_1(.x(x8k_1357_reg2) ,.y(H1357_mult[1]));
CSD_CSA35 H1357_2(.x(x8k_1357_reg2) ,.y(H1357_mult[2]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<3;j=j+1) begin
            H1357_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<3;j=j+1) begin
            H1357_mult_reg[j]<=H1357_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H1357_stage_one_temp<=0;
    end
    else begin
        H1357_stage_one_temp<=H1357_mult_reg[2];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H1357_add_reg[j]<=0;
    end
    else begin
        H1357_add_reg[1]<=H1357_stage_one_temp + H1357_mult_reg[1];
        H1357_add_reg[0]<=H1357_add_reg[1] + H1357_mult_reg[0];
    end
end

//******************H0 + H1 + H2 + H3 + H4 + H5 + H6 + H7***********************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x8k_01234567_reg<=0;
    else x8k_01234567_reg<=x8k_0123_reg + x8k_4567_reg;
end


CSD_CSA37 H01234567_0(.x(x8k_01234567_reg) ,.y(H01234567_mult[0]));
CSD_CSA38 H01234567_1(.x(x8k_01234567_reg) ,.y(H01234567_mult[1]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1) begin
            H01234567_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<2;j=j+1) begin
            H01234567_mult_reg[j]<=H01234567_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H01234567_stage_one_temp<=0;
    end
    else begin
        H01234567_stage_one_temp<=H01234567_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<2;j=j+1)
            H01234567_add_reg[j]<=0;
    end
    else begin
        H01234567_add_reg[1]<=H01234567_stage_one_temp + H01234567_mult_reg[1];
        H01234567_add_reg[0]<=H01234567_add_reg[1] + H01234567_mult_reg[0];
    end
end


//***************************************
assign w = y8k_temp4 + y8k_temp5;
assign x = y8k_1_temp4 + y8k_1_temp5;
assign y = y8k_2_temp4 + y8k_2_temp3;
assign z = y8k_3_temp3 + y8k_3_temp4 + y8k_3_temp5;
assign u = y8k_4_temp2 + y8k_4_temp3 + y8k_4_temp4;
assign v = y8k_5_temp2 + y8k_5_temp3 + y8k_5_temp4 + y8k_5_temp5;
assign t = y8k_6_temp2 + y8k_6_temp3 + y8k_6_temp4 + y8k_6_temp5;
assign s = y8k_7_temp + y8k_7_temp2 + y8k_7_temp3 + y8k_7_temp4 + y8k_7_temp5;

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
        y8k_6<=t[31:16];  
        y8k_7<=s[31:16];                                                
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
        y8k_1_temp<=0;
        y8k_1_temp2<=0;
        y8k_1_temp3<=0;
        y8k_1_temp4<=0;
        y8k_1_temp5<=0;        
        y8k_2_temp<=0;
        y8k_2_temp2<=0;
        y8k_2_temp3<=0;
        y8k_2_temp4<=0;        
        y8k_3_temp<=0;
        y8k_3_temp2<=0;
        y8k_3_temp3<=0;
        y8k_3_temp4<=0;
        y8k_3_temp5<=0;        
        y8k_4_temp<=0;
        y8k_4_temp2<=0;
        y8k_4_temp3<=0;
        y8k_4_temp4<=0;        
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
        y8k_7_temp<=0; 
        y8k_7_temp2<=0;        
        y8k_7_temp3<=0;        
        y8k_7_temp4<=0;        
        y8k_7_temp5<=0;                
    end
    else begin
        y8k_temp<=H5_add_reg[0] + H7_add_reg[0] - H5_H7_add_reg[0] - H6_add_reg[0];
        y8k_temp2<=H1357_add_reg[0] - H3_H7_add_reg[0] - H1_H5_add_reg[0] + H2_H6_add_reg[0] - H2_add_reg[0];
        y8k_temp3<=H4_add_reg[0] - H1_H3_add_reg[0] + H1_add_reg[0] + H3_add_reg[0];
        y8k_temp4<=y8k_temp + y8k_temp2 + y8k_temp3;
        y8k_temp5<=H0_add_reg[0];
        y8k_1_temp<=H4_H5_add_reg[0] - H6_H7_add_reg[0] - H2_H3_add_reg[0] - H4_add_reg[0];
        y8k_1_temp2<=H2_add_reg[0] + H6_add_reg[0] - H2_H6_add_reg[0] + H2367_add_reg[0];
        y8k_1_temp3<=H3_add_reg[0] + H7_add_reg[0] - H3_H7_add_reg[0] - H5_add_reg[0];
        y8k_1_temp4<=y8k_1_temp + y8k_1_temp2 + y8k_1_temp3;
        y8k_1_temp5<=H0_H1_add_reg[0] - H0_add_reg[0] - H1_add_reg[0];
        y8k_2_temp<=H5_add_reg[0] + H3_H7_add_reg[0] - H3_add_reg[0] - H7_add_reg[0];
        y8k_2_temp2<=H4_H6_add_reg[0] - H4_add_reg[0] - H6_add_reg[0];
        y8k_2_temp3<=y8k_2_temp + y8k_2_temp2;
        y8k_2_temp4<=H0_H2_add_reg[0] - H0_add_reg[0] - H2_add_reg[0] + H1_add_reg[0];
        y8k_3_temp<=H4_add_reg[0] + H6_add_reg[0] - H5_H7_add_reg[0] + H5_add_reg[0] + H7_add_reg[0];
        y8k_3_temp2<=H4567_add_reg[0] - H4_H5_add_reg[0] - H6_H7_add_reg[0] - H4_H6_add_reg[0];
        y8k_3_temp3<=y8k_3_temp + y8k_3_temp2;
        y8k_3_temp4<=H0123_add_reg[0] - H0_H1_add_reg[0] - H2_H3_add_reg[0] - H0_H2_add_reg[0] + H0_add_reg[0];
        y8k_3_temp5<=H2_add_reg[0] - H1_H3_add_reg[0] + H1_add_reg[0] + H3_add_reg[0];
        y8k_4_temp<=H6_add_reg[0] + H5_H7_add_reg[0] - H5_add_reg[0] - H7_add_reg[0];
        y8k_4_temp2<=y8k_4_temp;
        y8k_4_temp3<=H2_add_reg[0] + H0_H4_add_reg[0] - H0_add_reg[0] - H4_add_reg[0];
        y8k_4_temp4<=H1_H3_add_reg[0] - H1_add_reg[0] - H3_add_reg[0];
        y8k_5_temp<=H6_H7_add_reg[0] - H6_add_reg[0] - H7_add_reg[0];
        y8k_5_temp2<=y8k_5_temp;
        y8k_5_temp3<=H0145_add_reg[0] - H0_H1_add_reg[0] - H4_H5_add_reg[0] - H2_add_reg[0] - H0_H4_add_reg[0];
        y8k_5_temp4<=H4_add_reg[0] - H3_add_reg[0] - H1_H5_add_reg[0] + H1_add_reg[0];
        y8k_5_temp5<=H2_H3_add_reg[0] + H0_add_reg[0] + H5_add_reg[0];
        y8k_6_temp<=H7_add_reg[0];
        y8k_6_temp2<=y8k_6_temp;
        y8k_6_temp3<=H0246_add_reg[0] - H0_H4_add_reg[0] - H2_H6_add_reg[0] + H0_add_reg[0] + H2_add_reg[0];
        y8k_6_temp4<=H4_add_reg[0] + H6_add_reg[0] - H4_H6_add_reg[0] + H3_add_reg[0];
        y8k_6_temp5<=H1_H5_add_reg[0] - H1_add_reg[0] - H5_add_reg[0] -  H0_H2_add_reg[0];
        y8k_7_temp<=H01234567_add_reg[0] - H0145_add_reg[0] - H2367_add_reg[0] - H0123_add_reg[0] + H0_H1_add_reg[0];
        y8k_7_temp2<=H6_H7_add_reg[0] - H0246_add_reg[0] + H0_H4_add_reg[0] + H2_H6_add_reg[0] - H4567_add_reg[0];
        y8k_7_temp3<=H4_H5_add_reg[0] - H0_add_reg[0] - H2_add_reg[0] + H0_H2_add_reg[0] - H4_add_reg[0];
        y8k_7_temp4<=H2_H3_add_reg[0] - H6_add_reg[0] + H4_H6_add_reg[0] + H1_H5_add_reg[0] + H3_H7_add_reg[0];
        y8k_7_temp5<=H1_H3_add_reg[0] + H5_H7_add_reg[0] - H1_add_reg[0] - H3_add_reg[0] - H5_add_reg[0] - H7_add_reg[0] - H1357_add_reg[0];
    end
end

endmodule
