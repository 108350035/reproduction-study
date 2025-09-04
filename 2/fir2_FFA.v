//synopsys translate_off
`include "CSD_CSA_FFA.v"
//synopsys translate_on

module fir(
input clk,rst_n,
input signed [15:0] x2k,x2k_1,
output reg signed [15:0] y2k,y2k_1);

reg signed [15:0] x2k_reg,x2k_1_reg; // input data

// H0 BLOCK def
wire [31:0] H0_mult [11:0];
reg signed [31:0] H0_mult_reg [11:0];
reg signed [31:0] H0_add_reg [10:0]; //H0_add_reg[0] is output of H0
reg signed [31:0] H0_stage_one_temp;

// H1 BLOCK def
wire [31:0] H1_mult [11:0];
reg signed [31:0] H1_mult_reg [11:0];
reg signed [31:0] H1_add_reg [10:0]; //H1_add_reg[0] is output of H1
reg signed [31:0] H1_add_delay; //delay H1_add_reg[0]
reg signed [31:0] H1_stage_one_temp;

// H0+H1 BLOCK def
wire signed [16:0] x2k_add_x2k_1;
reg signed [16:0] x2k_add_x2k_1_reg; //x(2k) + x(2k+1)
wire [33:0] H0_H1_mult [5:0];
reg signed [33:0] H0_H1_mult_reg [5:0];
reg signed [33:0] H0_H1_stage_one_temp;
reg signed [33:0] H0_H1_add_reg [10:0]; //H0_H1_add_reg[0] is output of H0+H1


wire signed [31:0] y2k_1_temp; // output of H0+H1 - output of H1 - output of H0
wire signed [31:0] y2k_temp; // H1_add_delay + output of H0

integer j;

////////////H0 H1 seperate BLOCK ///////////////////////
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
            x2k_1_reg<=0;
            x2k_reg<=0;
    end
    else begin
        x2k_reg<=x2k;
        x2k_1_reg<=x2k_1;
    end
end

CSD_CSA0 M0(.x(x2k_reg) ,.y(H0_mult[0]));
CSD_CSA2 M1(.x(x2k_reg) ,.y(H0_mult[1]));
CSD_CSA4 M2(.x(x2k_reg) ,.y(H0_mult[2]));
CSD_CSA6 M3(.x(x2k_reg) ,.y(H0_mult[3]));
CSD_CSA8 M4(.x(x2k_reg) ,.y(H0_mult[4]));
CSD_CSA10 M5(.x(x2k_reg) ,.y(H0_mult[5]));
CSD_CSA11 M6(.x(x2k_reg) ,.y(H0_mult[6]));
CSD_CSA9 M7(.x(x2k_reg) ,.y(H0_mult[7]));
CSD_CSA7 M8(.x(x2k_reg) ,.y(H0_mult[8]));
CSD_CSA5 M9(.x(x2k_reg) ,.y(H0_mult[9]));
CSD_CSA3 M10(.x(x2k_reg) ,.y(H0_mult[10]));
CSD_CSA1 M11(.x(x2k_reg) ,.y(H0_mult[11]));


CSD_CSA1 M12(.x(x2k_1_reg) ,.y(H1_mult[0]));
CSD_CSA3 M13(.x(x2k_1_reg) ,.y(H1_mult[1]));
CSD_CSA5 M14(.x(x2k_1_reg) ,.y(H1_mult[2]));
CSD_CSA7 M15(.x(x2k_1_reg) ,.y(H1_mult[3]));
CSD_CSA9 M16(.x(x2k_1_reg) ,.y(H1_mult[4]));
CSD_CSA11 M17(.x(x2k_1_reg) ,.y(H1_mult[5]));
CSD_CSA10 M18(.x(x2k_1_reg) ,.y(H1_mult[6]));
CSD_CSA8 M19(.x(x2k_1_reg) ,.y(H1_mult[7]));
CSD_CSA6 M20(.x(x2k_1_reg) ,.y(H1_mult[8]));
CSD_CSA4 M21(.x(x2k_1_reg) ,.y(H1_mult[9]));
CSD_CSA2 M22(.x(x2k_1_reg) ,.y(H1_mult[10]));
CSD_CSA0 M23(.x(x2k_1_reg) ,.y(H1_mult[11]));



always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<12;j=j+1) begin
            H0_mult_reg[j]<=0;
            H1_mult_reg[j]<=0;
        end
    end
    else begin
        for(j=0;j<12;j=j+1) begin
            H0_mult_reg[j]<=H0_mult[j];
            H1_mult_reg[j]<=H1_mult[j];
        end
    end
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        H0_stage_one_temp<=0;
        H1_stage_one_temp<=0;
    end
    else begin
        H0_stage_one_temp<=H0_mult_reg[11];
        H1_stage_one_temp<=H1_mult_reg[11];
    end
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<11;j=j+1) begin
            H0_add_reg[j]<=0;
            H1_add_reg[j]<=0;
        end
    end
    else begin
        H0_add_reg[10] <= H0_stage_one_temp + H0_mult_reg[10];
        H1_add_reg[10] <= H1_stage_one_temp + H1_mult_reg[10];
        for(j=0;j<10;j=j+1) begin
            H0_add_reg[j]<=H0_add_reg[j+1]+H0_mult_reg[j];
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


CSD_CSA12 M24(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[0]));
CSD_CSA13 M25(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[1]));
CSD_CSA14 M26(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[2]));
CSD_CSA15 M27(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[3]));
CSD_CSA16 M28(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[4]));
CSD_CSA17 M29(.x(x2k_add_x2k_1_reg) ,.y(H0_H1_mult[5]));



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
    else H0_H1_stage_one_temp<=H0_H1_mult_reg[0];
end


always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(j=0;j<11;j=j+1)
            H0_H1_add_reg[j]<=0;
    end
    else begin
        H0_H1_add_reg[10]<=H0_H1_stage_one_temp +H0_H1_mult_reg[1];
        H0_H1_add_reg[9]<=H0_H1_mult_reg[2] + H0_H1_add_reg[10];
        H0_H1_add_reg[8]<=H0_H1_mult_reg[3] + H0_H1_add_reg[9];
        H0_H1_add_reg[7]<=H0_H1_mult_reg[4] + H0_H1_add_reg[8];
        H0_H1_add_reg[6]<=H0_H1_mult_reg[5] + H0_H1_add_reg[7];
        for(j=0;j<6;j=j+1)
           H0_H1_add_reg[j]<=H0_H1_add_reg[j+1] + H0_H1_mult_reg[j];
    end
end
///////////////////////////////////////////////////////////////////////

assign y2k_temp = H1_add_delay + H0_add_reg[0];
assign y2k_1_temp = H0_H1_add_reg[0] - H1_add_reg[0] - H0_add_reg[0];
 

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
    if(!rst_n) begin
        H1_add_delay<=0;
    end
    else begin
        H1_add_delay<=H1_add_reg[0];
    end
end

endmodule



