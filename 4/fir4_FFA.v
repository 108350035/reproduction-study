//synopsys translate_off
`include "CSD_CSA_FFA.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x4k,x4k_1,x4k_2,x4k_3,
output reg signed [15:0] y4k,y4k_1,y4k_2,y4k_3);

integer j;
reg signed [15:0] x4k_reg,x4k_1_reg,x4k_2_reg,x4k_3_reg; // input data
reg signed [16:0] x4k_add_x4k_1_reg,x4k_1_add_x4k_3_reg,x4k_add_x4k_2_reg,x4k_2_add_x4k_3_reg;
reg signed [17:0] x4k_0123_reg;
wire signed [16:0] x4k_add_x4k_1,x4k_1_add_x4k_3,x4k_add_x4k_2,x4k_2_add_x4k_3;
wire signed [17:0] x4k_0123;
// H0 H1 H2 H3 H0+H1 H1+H3 H0+H2 H2+H3 BLOCK def
wire [31:0] H0_mult [5:0],H1_mult [5:0],H2_mult [5:0],H3_mult [5:0];
reg signed [31:0] H0_mult_reg [5:0],H1_mult_reg [5:0],H2_mult_reg [5:0],H3_mult_reg [5:0];
reg signed [31:0] H0_add_reg [4:0],H1_add_reg [4:0],H2_add_reg [4:0],H3_add_reg [4:0]; //HX_add_reg[0] is output of HX
reg signed [31:0] H0_stage_one_temp,H1_stage_one_temp,H2_stage_one_temp,H3_stage_one_temp,H0_add_reg_delay,H1_add_reg_delay,H3_add_reg_delay;
wire [33:0] H0_H1_mult [5:0],H2_H3_mult [5:0];
reg signed [33:0] H0_H1_mult_reg [5:0],H2_H3_mult_reg [5:0];
reg signed [33:0] H0_H1_add_reg [4:0],H2_H3_add_reg [4:0];
reg signed [33:0] H0_H1_stage_one_temp,H2_H3_stage_one_temp;
wire [32:0] H0_H2_mult [5:0],H1_H3_mult [5:0];
reg signed [32:0] H0_H2_mult_reg [5:0],H1_H3_mult_reg [5:0];
reg signed [32:0] H0_H2_add_reg [4:0],H1_H3_add_reg [4:0];
reg signed [32:0] H0_H2_stage_one_temp,H1_H3_stage_one_temp;
// H0+H1+H2+H3BLOCK def
wire [33:0] H0123_mult [2:0];
reg signed [33:0] H0123_mult_reg [2:0];
reg signed [33:0] H0123_add_reg [4:0];
reg signed [33:0] H0123_stage_one_temp;

reg signed [31:0] y4k_temp,y4k_temp2,y4k_1_temp,y4k_1_temp1,y4k_1_temp2,y4k_2_temp,y4k_3_temp,y4k_3_temp2,y4k_3_temp3;
wire signed [31:0] w,x,y,z;


///************H0 H1 H2 H3 BLOCK ***************
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        x4k_reg<=0;
        x4k_1_reg<=0;
        x4k_2_reg<=0;
        x4k_3_reg<=0;
    end
    else begin
        x4k_reg<=x4k;
        x4k_1_reg<=x4k_1;
        x4k_2_reg<=x4k_2;
        x4k_3_reg<=x4k_3;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1) begin
            H0_mult_reg[j]<=0;
            H1_mult_reg[j]<=0;
            H2_mult_reg[j]<=0;
            H3_mult_reg[j]<=0;            
        end
    end
    else begin
        for(j=0;j<6;j=j+1) begin
            H0_mult_reg[j]<=H0_mult[j];
            H1_mult_reg[j]<=H1_mult[j];
            H2_mult_reg[j]<=H2_mult[j];
            H3_mult_reg[j]<=H3_mult[j];
        end
    end
end

CSD_CSA0 H00(.x(x4k_reg) ,.y(H0_mult[0]));
CSD_CSA4 H01(.x(x4k_reg) ,.y(H0_mult[1]));
CSD_CSA8 H02(.x(x4k_reg) ,.y(H0_mult[2]));
CSD_CSA11 H03(.x(x4k_reg) ,.y(H0_mult[3]));
CSD_CSA7 H04(.x(x4k_reg) ,.y(H0_mult[4]));
CSD_CSA3 H05(.x(x4k_reg) ,.y(H0_mult[5]));

CSD_CSA1 H10(.x(x4k_1_reg) ,.y(H1_mult[0]));
CSD_CSA5 H11(.x(x4k_1_reg) ,.y(H1_mult[1]));
CSD_CSA9 H12(.x(x4k_1_reg) ,.y(H1_mult[2]));
CSD_CSA10 H13(.x(x4k_1_reg) ,.y(H1_mult[3]));
CSD_CSA6 H14(.x(x4k_1_reg) ,.y(H1_mult[4]));
CSD_CSA2 H15(.x(x4k_1_reg) ,.y(H1_mult[5]));

CSD_CSA2 H20(.x(x4k_2_reg) ,.y(H2_mult[0]));
CSD_CSA6 H21(.x(x4k_2_reg) ,.y(H2_mult[1]));
CSD_CSA10 H22(.x(x4k_2_reg) ,.y(H2_mult[2]));
CSD_CSA9 H23(.x(x4k_2_reg) ,.y(H2_mult[3]));
CSD_CSA5 H24(.x(x4k_2_reg) ,.y(H2_mult[4]));
CSD_CSA1 H25(.x(x4k_2_reg) ,.y(H2_mult[5]));

CSD_CSA3 H30(.x(x4k_3_reg) ,.y(H3_mult[0]));
CSD_CSA7 H31(.x(x4k_3_reg) ,.y(H3_mult[1]));
CSD_CSA11 H32(.x(x4k_3_reg) ,.y(H3_mult[2]));
CSD_CSA8 H33(.x(x4k_3_reg) ,.y(H3_mult[3]));
CSD_CSA4 H34(.x(x4k_3_reg) ,.y(H3_mult[4]));
CSD_CSA0 H35(.x(x4k_3_reg) ,.y(H3_mult[5]));


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_stage_one_temp<=0;
        H1_stage_one_temp<=0;
        H2_stage_one_temp<=0;
        H3_stage_one_temp<=0;
    end
    else begin
        H0_stage_one_temp<=H0_mult_reg[5];
        H1_stage_one_temp<=H1_mult_reg[5];
        H2_stage_one_temp<=H2_mult_reg[5];
        H3_stage_one_temp<=H3_mult_reg[5];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1) begin
            H0_add_reg[j]<=0;
            H1_add_reg[j]<=0;
            H2_add_reg[j]<=0;
            H3_add_reg[j]<=0;
        end
    end
    else begin
        H0_add_reg[4] <= H0_stage_one_temp + H0_mult_reg[4];
        H1_add_reg[4] <= H1_stage_one_temp + H1_mult_reg[4];
        H2_add_reg[4] <= H2_stage_one_temp + H2_mult_reg[4];
        H3_add_reg[4] <= H3_stage_one_temp + H3_mult_reg[4];        
        for(j=0;j<4;j=j+1) begin
           H0_add_reg[j]<=H0_add_reg[j+1] + H0_mult_reg[j];
           H1_add_reg[j]<=H1_add_reg[j+1] + H1_mult_reg[j];
           H2_add_reg[j]<=H2_add_reg[j+1] + H2_mult_reg[j];
           H3_add_reg[j]<=H3_add_reg[j+1] + H3_mult_reg[j];
        end
    end
end

//******************H0 + H1***********************
assign x4k_add_x4k_1 = x4k + x4k_1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_add_x4k_1_reg<=0;
    else x4k_add_x4k_1_reg<=x4k_add_x4k_1;
end


CSD_CSA12 H0H1(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[0]));
CSD_CSA13 H0H1_1(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[1]));
CSD_CSA14 H0H1_2(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[2]));
CSD_CSA15 H0H1_3(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[3]));
CSD_CSA16 H0H1_4(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[4]));
CSD_CSA17 H0H1_5(.x(x4k_add_x4k_1_reg) ,.y(H0_H1_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H0_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H0_H1_mult_reg[j]<=H0_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H1_stage_one_temp<=0;
    else H0_H1_stage_one_temp<=H0_H1_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H0_H1_add_reg[j]<=0;
    end
    else begin
        H0_H1_add_reg[4] <= H0_H1_stage_one_temp + H0_H1_mult_reg[4];
        for(j=0;j<4;j=j+1)
            H0_H1_add_reg[j]<= H0_H1_mult_reg[j] + H0_H1_add_reg[j+1];
    end
end

//******************H0 + H2***********************
assign x4k_add_x4k_2 = x4k + x4k_2;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_add_x4k_2_reg<=0;
    else x4k_add_x4k_2_reg<=x4k_add_x4k_2;
end


CSD_CSA18 H0H2(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[0]));
CSD_CSA19 H0H2_1(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[1]));
CSD_CSA20 H0H2_2(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[2]));
CSD_CSA21 H0H2_3(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[3]));
CSD_CSA22 H0H2_4(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[4]));
CSD_CSA23 H0H2_5(.x(x4k_add_x4k_2_reg) ,.y(H0_H2_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H0_H2_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H0_H2_mult_reg[j]<=H0_H2_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_H2_stage_one_temp<=0;
    else H0_H2_stage_one_temp<=H0_H2_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H0_H2_add_reg[j]<=0;
    end
    else begin
        H0_H2_add_reg[4] <= H0_H2_stage_one_temp + H0_H2_mult_reg[4];
        for(j=0;j<4;j=j+1)
            H0_H2_add_reg[j]<= H0_H2_mult_reg[j] + H0_H2_add_reg[j+1];
    end
end

//******************H1 + H3***********************
assign x4k_1_add_x4k_3 = x4k_1 + x4k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_1_add_x4k_3_reg<=0;
    else x4k_1_add_x4k_3_reg<=x4k_1_add_x4k_3;
end

CSD_CSA23 H1H3(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[0]));
CSD_CSA22 H1H3_1(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[1]));
CSD_CSA21 H1H3_2(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[2]));
CSD_CSA20 H1H3_3(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[3]));
CSD_CSA19 H1H3_4(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[4]));
CSD_CSA18 H1H3_5(.x(x4k_1_add_x4k_3_reg) ,.y(H1_H3_mult[5]));

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


//******************H2 + H3***********************

assign x4k_2_add_x4k_3 = x4k_2 + x4k_3;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x4k_2_add_x4k_3_reg<=0;
    else x4k_2_add_x4k_3_reg<=x4k_2_add_x4k_3;
end


CSD_CSA17 H2H3(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[0]));
CSD_CSA16 H2H3_1(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[1]));
CSD_CSA15 H2H3_2(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[2]));
CSD_CSA14 H2H3_3(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[3]));
CSD_CSA13 H2H3_4(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[4]));
CSD_CSA12 H2H3_5(.x(x4k_2_add_x4k_3_reg) ,.y(H2_H3_mult[5]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H2_H3_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H2_H3_mult_reg[j]<=H2_H3_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H2_H3_stage_one_temp<=0;
    else H2_H3_stage_one_temp<=H2_H3_mult_reg[5];
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<5;j=j+1)
            H2_H3_add_reg[j]<=0;
    end
    else begin
        H2_H3_add_reg[4] <= H2_H3_stage_one_temp + H2_H3_mult_reg[4];
        for(j=0;j<4;j=j+1)
            H2_H3_add_reg[j]<= H2_H3_mult_reg[j] + H2_H3_add_reg[j+1];
    end
end


//******************H0 + H1 + H2 + H3***********************

wire [15:0] s1,c1;
CSA #(16) INPUT_ADD(.a(x4k) ,.b(x4k_1) ,.c(x4k_2) ,.sum(s1) ,.carry(c1));
wire [16:0] s1_ext,c1_ext;
assign s1_ext = {s1[15],s1};
assign c1_ext = {c1,1'b0};
wire signed [16:0] s2,c2;
CSA #(17) INPUT_ADD2(.a(c1_ext) ,.b(s1_ext) ,.c({x4k_3[15],x4k_3}) ,.sum(s2) ,.carry(c2));
assign x4k_0123 = s2 + (c2 << 1);

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

//***************************************

/*assign w = H0_add_reg[0] + y4k_temp + y4k_temp1;
assign x = H0_H1_add_reg[0] - H0_add_reg[0] - H1_add_reg[0] + y4k_1_temp - y4k_1_temp1;
assign y = H0_H2_add_reg[0] - H0_add_reg[0] - H2_add_reg[0] + H1_add_reg[0] + y4k_2_temp;
assign z = H0123_add_reg[0] - H0_H1_add_reg[0] - H2_H3_add_reg[0] - H0_H2_add_reg[0] - H1_H3_add_reg[0] + H0_add_reg[0] + H1_add_reg[0] + H2_add_reg[0] + H3_add_reg[0];*/

assign w = H0_add_reg_delay + y4k_temp2;
assign x = y4k_1_temp2 + y4k_1_temp1;
assign y = y4k_3_temp + H1_add_reg_delay + y4k_2_temp;
assign z = y4k_3_temp3 - y4k_3_temp2 - y4k_3_temp;

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
        y4k_3<=z[31:16];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_add_reg_delay<=0;
        H1_add_reg_delay<=0;
        H3_add_reg_delay<=0;                
    end
    else begin
        H0_add_reg_delay<=H0_add_reg[0];
        H1_add_reg_delay<=H1_add_reg[0];
        H3_add_reg_delay<=H3_add_reg[0];        
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y4k_temp<=0;
        y4k_temp2<=0;
    end
    else begin
        y4k_temp<=H1_H3_add_reg[0] + H2_add_reg[0];
        y4k_temp2<=y4k_temp - H1_add_reg_delay - H3_add_reg_delay;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y4k_1_temp<=0;
        y4k_1_temp1<=0;
        y4k_1_temp2<=0;
        y4k_2_temp<=0;
    end
    else begin
        y4k_1_temp<=H2_H3_add_reg[0] - H2_add_reg[0];
        y4k_1_temp1<=y4k_1_temp - H3_add_reg_delay;
        y4k_1_temp2<=H0_H1_add_reg[0] - H0_add_reg[0] - H1_add_reg[0];
        y4k_2_temp<=H3_add_reg_delay;
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y4k_3_temp<=0;
        y4k_3_temp2<=0;
        y4k_3_temp3<=0;
    end
    else begin
        y4k_3_temp<=H0_H2_add_reg[0] - H0_add_reg[0] - H2_add_reg[0];
        y4k_3_temp2<=H1_H3_add_reg[0] - H1_add_reg[0] - H3_add_reg[0];
        y4k_3_temp3<=H0123_add_reg[0] - H0_H1_add_reg[0] - H2_H3_add_reg[0];
    end
end


endmodule
