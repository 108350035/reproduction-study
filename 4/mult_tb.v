
module mult_tb;
    reg signed [15:0] x;
    wire signed [33:0] y;

    CSD_CSA13 tt (
        .x(x),
        .y(y)
    );

    initial begin
        $fsdbDumpfile("wave.fsdb"); 
        $fsdbDumpvars(0, tt);
        
        x = -355;    #10 $display("x = %d -> y = %d", x, y); 
        x = -100;    #10 $display("x = %d -> y = %d", x, y); 
        x = 0;     #10 $display("x = %d -> y = %d", x, y); 
        x = 23333;     #10 $display("x = %d -> y = %d", x, y); 
        x = -23333;     #10 $display("x = %d -> y = %d", x, y); 
        x = 5;     #10 $display("x = %d -> y = %d", x, y); 
        x = 1000;  #10 $display("x = %d -> y = %d", x, y); 
        x = -65536;#10 $display("x = %d -> y = %d", x, y); 
        x = 65535; #10 $display("x = %d -> y = %d", x, y); 
	  x = -32768;#10 $display("x = %d -> y = %d", x, y); 
        x = 32767; #10 $display("x = %d -> y = %d", x, y);
	  x = -131072;#10 $display("x = %d -> y = %d", x, y); 
        x = 131071; #10 $display("x = %d -> y = %d", x, y); 
        x = -262144;#10 $display("x = %d -> y = %d", x, y); 
        x = 262143; #10 $display("x = %d -> y = %d", x, y); 
 
 


        $finish;
    end
endmodule

