//synopsys translate_off
`include "CSD_CSA_proposed.v"
//synopsys translate_on
module fir(
input clk,rst_n,
input signed [15:0] x2k,x2k_1,
output reg signed [15:0] y2k,y2k_1);

reg signed [15:0] x2k_1_reg; // input data

// H1 BLOCK def
wire [31:0] H1_mult [11:0];
reg signed [31:0] H1_mult_reg [11:0];
reg signed [31:0] H1_add_reg [10:0]; //H1_add_reg[0] is output of H1
reg signed [31:0] H1_add_delay; //delay H1_add_reg[0]
reg signed [31:0] H1_stage_one_temp;

// H0+H1 BLOCK def
wire signed [16:0] x2k_add_x2k_1;
reg signed [16:0] x2k_add_x2k_1_reg; //x(2k) + x(2k+1)
wire [31:0] H0_plus_H1_mult [5:0];
reg signed [31:0] H0_plus_H1_mult_reg [5:0];
reg signed [31:0] H0_plus_H1_stage_one_temp;
reg signed [31:0] H0_plus_H1_add_reg [10:0]; //H0_plus_H1_add_reg[0] is output of 0.5*(H0+H1)

// H0-H1 BLOCK def
wire signed [16:0] x2k_sub_x2k_1;
reg signed [16:0] x2k_sub_x2k_1_reg; //x(2k) - x(2k+1)
wire [31:0] H0_minus_H1_mult [5:0];
reg signed [31:0] H0_minus_H1_mult_reg [5:0];
reg signed [31:0] H0_minus_H1_stage_one_temp;
reg signed [31:0] H0_minus_H1_add_reg [10:0]; //H0_minus_H1_add_reg[0] is output of 0.5*(H0-H1)



wire signed [31:0] y2k_1_temp; // output of 0.5*(H0+H1) + output of 0.5*(H0-H1)
wire signed [31:0] y2k_temp; //output of 0.5*(H0+H1) - output of 0.5*(H0-H1)

integer j;

////////////H1 BLOCK ///////////////////////
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x2k_1_reg<=0;
    else x2k_1_reg<=x2k_1;
end

CSD_CSA13 M12(.x(x2k_1_reg) ,.y(H1_mult[0]));
CSD_CSA15 M13(.x(x2k_1_reg) ,.y(H1_mult[1]));
CSD_CSA17 M14(.x(x2k_1_reg) ,.y(H1_mult[2]));
CSD_CSA19 M15(.x(x2k_1_reg) ,.y(H1_mult[3]));
CSD_CSA21 M16(.x(x2k_1_reg) ,.y(H1_mult[4]));
CSD_CSA23 M17(.x(x2k_1_reg) ,.y(H1_mult[5]));
CSD_CSA22 M18(.x(x2k_1_reg) ,.y(H1_mult[6]));
CSD_CSA20 M19(.x(x2k_1_reg) ,.y(H1_mult[7]));
CSD_CSA18 M20(.x(x2k_1_reg) ,.y(H1_mult[8]));
CSD_CSA16 M21(.x(x2k_1_reg) ,.y(H1_mult[9]));
CSD_CSA14 M22(.x(x2k_1_reg) ,.y(H1_mult[10]));
CSD_CSA12 M23(.x(x2k_1_reg) ,.y(H1_mult[11]));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<12;j=j+1) begin
            H1_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<12;j=j+1) begin
            H1_mult_reg[j]<=H1_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_stage_one_temp<=0;
    else H1_stage_one_temp<=H1_mult[11];
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<11;j=j+1) begin
            H1_add_reg[j]<=0;
        end
    end
    else begin
        H1_add_reg[10] <= H1_stage_one_temp + H1_mult_reg[10];
        for(j=0;j<10;j=j+1) begin
            H1_add_reg[j]<=H1_add_reg[j+1]+H1_mult_reg[j];
        end
    end
end
/////////////////////////////////////////////////////////////////

///////////////////////////H0+H1 BLOCK//////////////////////////
assign x2k_add_x2k_1 = x2k + x2k_1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x2k_add_x2k_1_reg<=0;
    else x2k_add_x2k_1_reg<=x2k_add_x2k_1;
end


CSD_CSA0 M34(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[0]));
CSD_CSA1 M35(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[1]));
CSD_CSA2 M36(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[2]));
CSD_CSA3 M37(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[3]));
CSD_CSA4 M38(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[4]));
CSD_CSA5 M39(.x(x2k_add_x2k_1_reg) ,.y(H0_plus_H1_mult[5]));



always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H0_plus_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H0_plus_H1_mult_reg[j]<=H0_plus_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_plus_H1_stage_one_temp<=0;
    else H0_plus_H1_stage_one_temp<=H0_plus_H1_mult_reg[0];
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<11;j=j+1)
            H0_plus_H1_add_reg[j]<=0;
    end
    else begin
        H0_plus_H1_add_reg[10]<=H0_plus_H1_stage_one_temp +H0_plus_H1_mult_reg[1];
        H0_plus_H1_add_reg[9]<=H0_plus_H1_mult_reg[2] + H0_plus_H1_add_reg[10];
        H0_plus_H1_add_reg[8]<=H0_plus_H1_mult_reg[3] + H0_plus_H1_add_reg[9];
        H0_plus_H1_add_reg[7]<=H0_plus_H1_mult_reg[4] + H0_plus_H1_add_reg[8];
        H0_plus_H1_add_reg[6]<=H0_plus_H1_mult_reg[5] + H0_plus_H1_add_reg[7];
        for(j=0;j<6;j=j+1)
           H0_plus_H1_add_reg[j]<=H0_plus_H1_add_reg[j+1] + H0_plus_H1_mult_reg[j];
    end
end
///////////////////////H0 - H1 BLOCK/////////////////////////////////////
assign x2k_sub_x2k_1 = x2k - x2k_1;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) x2k_sub_x2k_1_reg<=0;
    else x2k_sub_x2k_1_reg<=x2k_sub_x2k_1;
end


CSD_CSA6 M24(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[0]));
CSD_CSA7 M25(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[1]));
CSD_CSA8 M26(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[2]));
CSD_CSA9 M27(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[3]));
CSD_CSA10 M28(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[4]));
CSD_CSA11 M29(.x(x2k_sub_x2k_1_reg) ,.y(H0_minus_H1_mult[5]));



always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<6;j=j+1)
            H0_minus_H1_mult_reg[j]<=0;
    end
    else begin
        for(j=0;j<6;j=j+1)
            H0_minus_H1_mult_reg[j]<=H0_minus_H1_mult[j];
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H0_minus_H1_stage_one_temp<=0;
    else H0_minus_H1_stage_one_temp<=H0_minus_H1_mult_reg[0];
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<11;j=j+1)
            H0_minus_H1_add_reg[j]<=0;
    end
    else begin
        H0_minus_H1_add_reg[10]<=H0_minus_H1_stage_one_temp +H0_minus_H1_mult_reg[1];
        H0_minus_H1_add_reg[9]<=H0_minus_H1_mult_reg[2] + H0_minus_H1_add_reg[10];
        H0_minus_H1_add_reg[8]<=H0_minus_H1_mult_reg[3] + H0_minus_H1_add_reg[9];
        H0_minus_H1_add_reg[7]<=H0_minus_H1_mult_reg[4] + H0_minus_H1_add_reg[8];
        H0_minus_H1_add_reg[6]<=H0_minus_H1_mult_reg[5] + H0_minus_H1_add_reg[7];
        for(j=0;j<6;j=j+1)
           H0_minus_H1_add_reg[j]<=H0_minus_H1_add_reg[j+1] - H0_minus_H1_mult_reg[j];
    end
end


assign y2k_1_temp = H0_plus_H1_add_reg[0] + H0_minus_H1_add_reg[0] - H1_add_reg[0] + H1_add_delay;
assign y2k_temp = H0_plus_H1_add_reg[0] - H0_minus_H1_add_reg[0];

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        y2k<=0;
        y2k_1<=0;
    end
    else begin
        y2k<={y2k_temp[31:16]};
        y2k_1<={y2k_1_temp[31:16]};
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) H1_add_delay<=0;
    else begin
        H1_add_delay<=H1_add_reg[0];
    end
end

endmodule



