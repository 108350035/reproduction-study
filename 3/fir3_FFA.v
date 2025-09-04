//synopsys translate_off
`include "CSD_CSA_FFA.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x3k,x3k_1,x3k_2,
output reg signed [15:0] y3k,y3k_1,y3k_2);

integer j;
reg signed [15:0] x3k_reg,x3k_1_reg,x3k_2_reg; // input data
reg signed [16:0] x3k_add_x3k_1_reg,x3k_1_add_x3k_2_reg;
reg signed [17:0] x3k_add_x3k_1_add_x3k_2_reg;
wire signed [16:0] x3k_add_x3k_1,x3k_1_add_x3k_2;
wire signed [17:0] x3k_add_x3k_1_add_x3k_2;
// H0 H1 H2 H0+H1 H1+H2 BLOCK def
wire [31:0] H0_mult [7:0],H2_mult [7:0];
wire [31:0] H1_mult [3:0];
wire [33:0] H0_H1_mult [7:0],H1_H2_mult [7:0];
reg signed [31:0] H0_mult_reg [7:0],H2_mult_reg [7:0];
reg signed [31:0] H1_mult_reg [3:0];
reg signed [33:0] H0_H1_mult_reg [7:0],H1_H2_mult_reg [7:0];
reg signed [31:0] H0_add_reg [6:0],H1_add_reg [6:0],H2_add_reg [6:0]; //HX_add_reg[0] is output of HX
reg signed [33:0] H0_H1_add_reg [6:0],H1_H2_add_reg [6:0]; //HX_add_reg[0] is output of HX
reg signed [31:0] H0_stage_one_temp,H1_stage_one_temp,H2_stage_one_temp;
reg signed [33:0] H0_H1_stage_one_temp,H1_H2_stage_one_temp;
reg signed [31:0] H2_add_delay; //delay H2_add_reg[0]

//H0+H1+H2 BLOCK def
wire [33:0] H0_H1_H2_mult [3:0];
reg signed [33:0] H0_H1_H2_mult_reg [3:0];
reg signed [33:0] H0_H1_H2_add_reg [6:0];
reg signed [33:0] H0_H1_H2_stage_one_temp;
wire signed [31:0] x;
reg signed [31:0] H1_H2_sub_H1;//output of H1+H2 - output of H1
reg signed [31:0] y3k_temp,z,y3k_1_temp;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
            x3k_2_reg<=0;
            x3k_1_reg<=0;
            x3k_reg<=0;
    end
    else begin
        x3k_reg<=x3k;
        x3k_1_reg<=x3k_1;
        x3k_2_reg<=x3k_2;
    end
end

////////////H0 H1 H2 seperate BLOCK ///////////////////////
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<8;j=j+1) begin
            H0_mult_reg[j]<=0;
            H2_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<8;j=j+1) begin
            H0_mult_reg[j]<=H0_mult[j];
            H2_mult_reg[j]<=H2_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H1_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H1_mult_reg[j]<=H1_mult[j];
        end
    end
end


CSD_CSA0 H00(.x(x3k_reg) ,.y(H0_mult[0]));
CSD_CSA3 H01(.x(x3k_reg) ,.y(H0_mult[1]));
CSD_CSA6 H02(.x(x3k_reg) ,.y(H0_mult[2]));
CSD_CSA9 H03(.x(x3k_reg) ,.y(H0_mult[3]));
CSD_CSA11 H04(.x(x3k_reg) ,.y(H0_mult[4]));
CSD_CSA8 H05(.x(x3k_reg) ,.y(H0_mult[5]));
CSD_CSA5 H06(.x(x3k_reg) ,.y(H0_mult[6]));
CSD_CSA2 H07(.x(x3k_reg) ,.y(H0_mult[7]));

CSD_CSA1 H10(.x(x3k_1_reg) ,.y(H1_mult[0]));
CSD_CSA4 H11(.x(x3k_1_reg) ,.y(H1_mult[1]));
CSD_CSA7 H12(.x(x3k_1_reg) ,.y(H1_mult[2]));
CSD_CSA10 H13(.x(x3k_1_reg) ,.y(H1_mult[3]));

CSD_CSA2 H20(.x(x3k_2_reg) ,.y(H2_mult[0]));
CSD_CSA5 H21(.x(x3k_2_reg) ,.y(H2_mult[1]));
CSD_CSA8 H22(.x(x3k_2_reg) ,.y(H2_mult[2]));
CSD_CSA11 H23(.x(x3k_2_reg) ,.y(H2_mult[3]));
CSD_CSA9 H24(.x(x3k_2_reg) ,.y(H2_mult[4]));
CSD_CSA6 H25(.x(x3k_2_reg) ,.y(H2_mult[5]));
CSD_CSA3 H26(.x(x3k_2_reg) ,.y(H2_mult[6]));
CSD_CSA0 H27(.x(x3k_2_reg) ,.y(H2_mult[7]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_stage_one_temp<=0;
        H1_stage_one_temp<=0;
        H2_stage_one_temp<=0;
    end
    else begin
        H0_stage_one_temp<=H0_mult_reg[7];
        H1_stage_one_temp<=H1_mult_reg[0];
        H2_stage_one_temp<=H2_mult_reg[7];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<7;j=j+1) begin
            H0_add_reg[j]<=0;
            H2_add_reg[j]<=0;
        end
    end
    else begin
        H0_add_reg[6] <= H0_stage_one_temp + H0_mult_reg[6];
        H2_add_reg[6] <= H2_stage_one_temp + H2_mult_reg[6];
        for(j=0;j<6;j=j+1) begin
            H0_add_reg[j]<=H0_add_reg[j+1]+H0_mult_reg[j];
            H2_add_reg[j]<=H2_add_reg[j+1]+H2_mult_reg[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<7;j=j+1)
            H1_add_reg[j]<=0;
    end
    else begin
        H1_add_reg[6]<=H1_stage_one_temp +H1_mult_reg[1];
        H1_add_reg[5]<=H1_mult_reg[2] + H1_add_reg[6];
        H1_add_reg[4]<=H1_mult_reg[3] + H1_add_reg[5];
        for(j=0;j<4;j=j+1)
           H1_add_reg[j]<=H1_add_reg[j+1] + H1_mult_reg[j];
    end
end

///////////////////////////////////////////////////////////////////
//******************H0 + H1***********************
assign x3k_add_x3k_1 = x3k + x3k_1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x3k_add_x3k_1_reg<=0;
    else x3k_add_x3k_1_reg<=x3k_add_x3k_1;
end


CSD_CSA12 H0H1_0(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[0]));
CSD_CSA13 H0H1_1(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[1]));
CSD_CSA14 H0H1_2(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[2]));
CSD_CSA15 H0H1_3(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[3]));
CSD_CSA16 H0H1_4(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[4]));
CSD_CSA17 H0H1_5(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[5]));
CSD_CSA18 H0H1_6(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[6]));
CSD_CSA19 H0H1_7(.x(x3k_add_x3k_1_reg) ,.y(H0_H1_mult[7]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<8;j=j+1)
            H0_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<8;j=j+1)
            H0_H1_mult_reg[j]<=H0_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H1_stage_one_temp<=0;
    else H0_H1_stage_one_temp<=H0_H1_mult_reg[7];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<7;j=j+1)
            H0_H1_add_reg[j]<=0;
    end
    else begin
        H0_H1_add_reg[6] <= H0_H1_stage_one_temp + H0_H1_mult_reg[6];
        for(j=0;j<6;j=j+1)
            H0_H1_add_reg[j]<= H0_H1_mult_reg[j] + H0_H1_add_reg[j+1];
    end
end

///////////////////////////////////////////////////////////////////
//******************H1 + H2***********************
assign x3k_1_add_x3k_2 = x3k_1 + x3k_2;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x3k_1_add_x3k_2_reg<=0;
    else x3k_1_add_x3k_2_reg<=x3k_1_add_x3k_2;
end


CSD_CSA19 H1H2_0(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[0]));
CSD_CSA18 H1H2_1(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[1]));
CSD_CSA17 H1H2_2(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[2]));
CSD_CSA16 H1H2_3(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[3]));
CSD_CSA15 H1H2_4(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[4]));
CSD_CSA14 H1H2_5(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[5]));
CSD_CSA13 H1H2_6(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[6]));
CSD_CSA12 H1H2_7(.x(x3k_1_add_x3k_2_reg) ,.y(H1_H2_mult[7]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<8;j=j+1)
            H1_H2_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<8;j=j+1)
            H1_H2_mult_reg[j]<=H1_H2_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H2_stage_one_temp<=0;
    else H1_H2_stage_one_temp<=H1_H2_mult_reg[7];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<7;j=j+1)
            H1_H2_add_reg[j]<=0;
    end
    else begin
        H1_H2_add_reg[6] <= H1_H2_stage_one_temp + H1_H2_mult_reg[6];
        for(j=0;j<6;j=j+1)
            H1_H2_add_reg[j]<= H1_H2_mult_reg[j] + H1_H2_add_reg[j+1];
    end
end


///////////////////////////////////////////////////////////////////
//******************H0 + H1 + H2***********************
assign x3k_add_x3k_1_add_x3k_2 = x3k + x3k_1 + x3k_2;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x3k_add_x3k_1_add_x3k_2_reg<=0;
    else x3k_add_x3k_1_add_x3k_2_reg<=x3k_add_x3k_1_add_x3k_2;
end


CSD_CSA20 H0H1H2_0(.x(x3k_add_x3k_1_add_x3k_2_reg) ,.y(H0_H1_H2_mult[0]));
CSD_CSA21 H0H1H2_1(.x(x3k_add_x3k_1_add_x3k_2_reg) ,.y(H0_H1_H2_mult[1]));
CSD_CSA22 H0H1H2_2(.x(x3k_add_x3k_1_add_x3k_2_reg) ,.y(H0_H1_H2_mult[2]));
CSD_CSA23 H0H1H2_3(.x(x3k_add_x3k_1_add_x3k_2_reg) ,.y(H0_H1_H2_mult[3]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<4;j=j+1) begin
            H0_H1_H2_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<4;j=j+1) begin
            H0_H1_H2_mult_reg[j]<=H0_H1_H2_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_H1_H2_stage_one_temp<=0;
    end
    else begin
        H0_H1_H2_stage_one_temp<=H0_H1_H2_mult_reg[0];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<7;j=j+1)
            H0_H1_H2_add_reg[j]<=0;
    end
    else begin
        H0_H1_H2_add_reg[6]<=H0_H1_H2_stage_one_temp + H0_H1_H2_mult_reg[1];
        H0_H1_H2_add_reg[5]<=H0_H1_H2_mult_reg[2] + H0_H1_H2_add_reg[6];
        H0_H1_H2_add_reg[4]<=H0_H1_H2_mult_reg[3] + H0_H1_H2_add_reg[5];
        for(j=0;j<4;j=j+1)
           H0_H1_H2_add_reg[j]<=H0_H1_H2_add_reg[j+1] + H0_H1_H2_mult_reg[j];
    end
end

//***************************************

assign x = z - H1_H2_sub_H1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y3k<=0;
        y3k_1<=0;
        y3k_2<=0;
    end
    else begin
        y3k<=y3k_temp[31:16];
        y3k_1<=y3k_1_temp[31:16];
        y3k_2<=x[31:16];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_add_delay<=0;
    else H2_add_delay<=H2_add_reg[0];
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_H2_sub_H1<=0;
    else H1_H2_sub_H1<=H1_H2_add_reg[0] - H1_add_reg[0];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) y3k_temp<=0;
    else begin
        y3k_temp<=H0_add_reg[0] - H2_add_delay + H1_H2_sub_H1;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) y3k_1_temp<=0;
    else begin
        y3k_1_temp<=(H0_H1_add_reg[0] - H1_add_reg[0]) - (H0_add_reg[0] - H2_add_delay);
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) z<=0;
    else begin
        z<=H0_H1_H2_add_reg[0]  - (H0_H1_add_reg[0] - H1_add_reg[0]);
    end
end


endmodule
