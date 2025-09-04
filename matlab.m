% FIR濾波器参数
fs = 50000000;  % 採樣頻率=50MHz
fc = 10000000;   % 截止頻率=10MHz
W = 16;
N = 24; 
f = [0, fc, fc + 4000000, fs/2] / (fs/2); % 歸一化頻率
a = [1, 1, 0, 0]; % 幅度
coeffs = firpm(N-1,f,a);
max_coeff = max(abs(coeffs));
normalized_coeffs = coeffs / max_coeff;
best_MAD = inf;        
best_VSF = 0;
best_PPSF = 0;
best_quant_coeffs=[];
max_nonzero_bits = 3;
step_size=2^(-W);
VSF_values = [0.4375:step_size:1.13];
for i = 1:length(VSF_values)
    PPSF = max_coeff / VSF_values(i); %0.9893 ~ 0.3847
    [csd_str, num_nonzero] = dec2csd(PPSF, W);
    if num_nonzero <= max_nonzero_bits
        quant_coeffs = SPT_allocate(normalized_coeffs, W, VSF_values(i),N);
        mad_value = calculate_MAD(coeffs, quant_coeffs*PPSF);
        if mad_value < best_MAD
            best_PPSF = PPSF;
            best_MAD = mad_value;
            best_VSF = VSF_values(i);
            best_quant_coeffs = quant_coeffs;
            fprintf('VSF=%.4f, PPSF=%.4f, Nonzero=%d, MAD=%.6f\n', ...
        VSF_values(i), PPSF, num_nonzero, mad_value);
        end
    end
end

%h0~h23
for i = 1:length(best_quant_coeffs)
    [csd_str, ~] = dec2csd(best_quant_coeffs(i), W);
end
%並行=2
%H0
% fprintf("Parallelism = 2 \n");
% fprintf("H0 \n");
% num_pairs = length(best_quant_coeffs) / 2;
% H0_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = (i-1)*2 + 1;
%     H0_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H0_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_coeffs(i),csd_str);
% end
% fprintf("H1 \n");
% H1_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = i*2;
%     H1_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_coeffs(i),csd_str);
% end
% 
% %H0+H1子濾波器塊
% H0_plus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 \n");
% for i = 1:num_pairs
%     H0_plus_H1_coeffs(i) = H0_coeffs(i) + H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H1_coeffs(i),csd_str);
% end
% 
% %H0-H1子濾波器塊
% H0_minus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 - H1 \n");
% for i = 1:num_pairs
%     H0_minus_H1_coeffs(i) = H0_coeffs(i) - H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_minus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_minus_H1_coeffs(i),csd_str);
% end


%並行=3
%H0子濾波器塊
% fprintf("Parallelism = 3 \n");
% fprintf("H0 \n");
% num_pairs = length(best_quant_coeffs) / 3;
% H0_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 3*(i - 1) + 1;
%     H0_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H0_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_coeffs(i),csd_str);
% end
% 
% %H1子濾波器塊
% fprintf("H1 \n");
% H1_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 3*(i - 1) + 2;
%     H1_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_coeffs(i),csd_str);
% end
% 
% %H2子濾波器塊
% fprintf("H2 \n");
% H2_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 3*i;
%     H2_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_coeffs(i),csd_str);
% end
% 
% %H0+H1子濾波器塊
% H0_plus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 \n");
% for i = 1:num_pairs
%     H0_plus_H1_coeffs(i) = H0_coeffs(i) + H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H1_coeffs(i),csd_str);
% end
% 
% %H1+H2子濾波器塊
% H1_plus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H1 + H2 \n");
% for i = 1:num_pairs
%     H1_plus_H2_coeffs(i) = H1_coeffs(i) + H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_plus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_plus_H2_coeffs(i),csd_str);
% end
% 
% %H0+H1+H2子濾波器塊
% H0_plus_H1_plus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 + H2 \n");
% for i = 1:num_pairs
%     H0_plus_H1_plus_H2_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H1_plus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H1_plus_H2_coeffs(i),csd_str);
% end
% 
% %H0-H1子濾波器塊
% H0_minus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 - H1 \n");
% for i = 1:num_pairs
%     H0_minus_H1_coeffs(i) = H0_coeffs(i) - H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_minus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_minus_H1_coeffs(i),csd_str);
% end
% 
% %H0+H2子濾波器塊
% H0_plus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 \n");
% for i = 1:num_pairs
%     H0_plus_H2_coeffs(i) = H0_coeffs(i) + H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H2_coeffs(i),csd_str);
% end
% 
% %H0-H2子濾波器塊
% H0_minus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H0 - H2 \n");
% for i = 1:num_pairs
%     H0_minus_H2_coeffs(i) = H0_coeffs(i) - H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_minus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_minus_H2_coeffs(i),csd_str);
% end

%並行=4
%H0子濾波器塊
% fprintf("Parallelism = 4 \n");
% fprintf("H0 \n");
% num_pairs = length(best_quant_coeffs) / 4;
% H0_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 4*(i - 1) + 1;
%     H0_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H0_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_coeffs(i),csd_str);
% end
% 
% %H1子濾波器塊
% H1_coeffs = zeros(1, num_pairs);
% fprintf("H1 \n");
% for i = 1:num_pairs
%     idx = 4*(i - 1) + 2;
%     H1_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_coeffs(i),csd_str);
% end
% 
% %H2子濾波器塊
% H2_coeffs = zeros(1, num_pairs);
% fprintf("H2 \n");
% for i = 1:num_pairs
%     idx = 4*(i - 1) + 3;
%     H2_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_coeffs(i),csd_str);
% end
% 
% %H3子濾波器塊
% H3_coeffs = zeros(1, num_pairs);
% fprintf("H3 \n");
% for i = 1:num_pairs
%     idx = 4*i;
%     H3_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H3_coeffs(i),csd_str);
% end
% 
% %H0+H1子濾波器塊
% H0_plus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 \n");
% for i = 1:num_pairs
%     H0_plus_H1_coeffs(i) = H0_coeffs(i) + H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H1_coeffs(i),csd_str);
% end
% 
% %H0+H2子濾波器塊
% H0_plus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 \n");
% for i = 1:num_pairs
%     H0_plus_H2_coeffs(i) = H0_coeffs(i) + H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H2_coeffs(i),csd_str);
% end
% 
% %H1+H3子濾波器塊
% H1_plus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H1 + H3 \n");
% for i = 1:num_pairs
%     H1_plus_H3_coeffs(i) = H1_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_plus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_plus_H3_coeffs(i),csd_str);
% end
% 
% %H2+H3子濾波器塊
% H2_plus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H2 + H3 \n");
% for i = 1:num_pairs
%     H2_plus_H3_coeffs(i) = H2_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H2_plus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_plus_H3_coeffs(i),csd_str);
% end
% 
% %H2-H3子濾波器塊
% H2_minus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H2 - H3 \n");
% for i = 1:num_pairs
%     H2_minus_H3_coeffs(i) = H2_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H2_minus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_minus_H3_coeffs(i),csd_str);
% end
% 
% %H0+H1+H2+H3子濾波器塊
% H0123_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 + H2 + H3 \n");
% for i = 1:num_pairs
%     H0123_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H0123_coeffs(i), W);
%     fprintf("%.10f %s\n",H0123_coeffs(i),csd_str);
% end
% 
% %H0+H1-H2-H3子濾波器塊
% H01_minus_23_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 - H2 - H3 \n");
% for i = 1:num_pairs
%     H01_minus_23_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) - H2_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H01_minus_23_coeffs(i), W);
%     fprintf("%.10f %s\n",H01_minus_23_coeffs(i),csd_str);
% end
% 
% %H0+H2-H1-H3子濾波器塊
% H02_minus_13_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 - H1 - H3 \n");
% for i = 1:num_pairs
%     H02_minus_13_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) - H1_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H02_minus_13_coeffs(i), W);
%     fprintf("%.10f %s\n",H02_minus_13_coeffs(i),csd_str);
% end
% 
% %H0+H3-H1-H2子濾波器塊
% H03_minus_12_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H3 - H1 - H2 \n");
% for i = 1:num_pairs
%     H03_minus_12_coeffs(i) = H0_coeffs(i) + H3_coeffs(i) - H1_coeffs(i) - H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H03_minus_12_coeffs(i), W);
%     fprintf("%.10f %s\n",H03_minus_12_coeffs(i),csd_str);
% end


%並行=6
%H0子濾波器塊
% fprintf("Parallelism = 6 \n");
% fprintf("H0 \n");
% num_pairs = length(best_quant_coeffs) / 6;
% H0_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*(i - 1) +1;
%     H0_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H0_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_coeffs(i),csd_str);
% end
% 
% %H1子濾波器塊
% fprintf("H1 \n");
% H1_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*(i - 1)+2;
%     H1_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_coeffs(i),csd_str);
% end
% 
% %H2子濾波器塊
% fprintf("H2 \n");
% H2_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*(i - 1)+3;
%     H2_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_coeffs(i),csd_str);
% end
% 
% %H3子濾波器塊
% fprintf("H3 \n");
% H3_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*(i - 1)+4;
%     H3_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H3_coeffs(i),csd_str);
% end
% 
% %H4子濾波器塊
% fprintf("H4 \n");
% H4_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*(i - 1)+5;
%     H4_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H4_coeffs(i), W);
%     fprintf("%.10f %s\n",H4_coeffs(i),csd_str);
% end
% 
% %H5子濾波器塊
% fprintf("H5 \n");
% H5_coeffs = zeros(1, num_pairs);
% for i = 1:num_pairs
%     idx = 6*i;
%     H5_coeffs(i) = best_quant_coeffs(idx);
%     [csd_str, ~] = dec2csd(H5_coeffs(i), W);
%     fprintf("%.10f %s\n",H5_coeffs(i),csd_str);
% end
% 
% %H1+H3子濾波器塊
% H1_plus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H1 + H3 \n");
% for i = 1:num_pairs
%     H1_plus_H3_coeffs(i) = H1_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_plus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_plus_H3_coeffs(i),csd_str);
% end
% 
% %H1-H3子濾波器塊
% H1_minus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H1 - H3 \n");
% for i = 1:num_pairs
%     H1_minus_H3_coeffs(i) = H1_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_minus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_minus_H3_coeffs(i),csd_str);
% end
% 
% %H1+H5子濾波器塊
% H1_plus_H5_coeffs = zeros(1, num_pairs);
% fprintf("H1 + H5 \n");
% for i = 1:num_pairs
%     H1_plus_H5_coeffs(i) = H1_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_plus_H5_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_plus_H5_coeffs(i),csd_str);
% end
% 
% %H1-H5子濾波器塊
% H1_minus_H5_coeffs = zeros(1, num_pairs);
% fprintf("H1 - H5 \n");
% for i = 1:num_pairs
%     H1_minus_H5_coeffs(i) = H1_coeffs(i) - H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H1_minus_H5_coeffs(i), W);
%     fprintf("%.10f %s\n",H1_minus_H5_coeffs(i),csd_str);
% end
% 
% %H2+H4子濾波器塊
% H2_plus_H4_coeffs = zeros(1, num_pairs);
% fprintf("H2 + H4 \n");
% for i = 1:num_pairs
%     H2_plus_H4_coeffs(i) = H2_coeffs(i) + H4_coeffs(i);
%     [csd_str, ~] = dec2csd(H2_plus_H4_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_plus_H4_coeffs(i),csd_str);
% end
% 
% %H3+H5子濾波器塊
% H3_plus_H5_coeffs = zeros(1, num_pairs);
% fprintf("H3 + H5 \n");
% for i = 1:num_pairs
%     H3_plus_H5_coeffs(i) = H3_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H3_plus_H5_coeffs(i), W);
%     fprintf("%.10f %s\n",H3_plus_H5_coeffs(i),csd_str);
% end
% 
% %H1+H3+H5子濾波器塊
% H135_coeffs = zeros(1, num_pairs);
% fprintf("H1 + H3 + H5 \n");
% for i = 1:num_pairs
%     H135_coeffs(i) = H1_coeffs(i) + H3_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H135_coeffs(i), W);
%     fprintf("%.10f %s\n",H135_coeffs(i),csd_str);
% end
% 
% %H0+H1子濾波器塊
% H0_plus_H1_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 \n");
% for i = 1:num_pairs
%     H0_plus_H1_coeffs(i) = H0_coeffs(i) + H1_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H1_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H1_coeffs(i),csd_str);
% end
% 
% %H2+H3子濾波器塊
% H2_plus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H2 + H3 \n");
% for i = 1:num_pairs
%     H2_plus_H3_coeffs(i) = H2_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H2_plus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_plus_H3_coeffs(i),csd_str);
% end
% 
% %H2-H3子濾波器塊
% H2_minus_H3_coeffs = zeros(1, num_pairs);
% fprintf("H2 - H3 \n");
% for i = 1:num_pairs
%     H2_minus_H3_coeffs(i) = H2_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H2_minus_H3_coeffs(i), W);
%     fprintf("%.10f %s\n",H2_minus_H3_coeffs(i),csd_str);
% end
% 
% %H4+H5子濾波器塊
% H4_plus_H5_coeffs = zeros(1, num_pairs);
% fprintf("H4 + H5 \n");
% for i = 1:num_pairs
%     H4_plus_H5_coeffs(i) = H4_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H4_plus_H5_coeffs(i), W);
%     fprintf("%.10f %s\n",H4_plus_H5_coeffs(i),csd_str);
% end
% 
% %H0+H2子濾波器塊
% H0_plus_H2_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 \n");
% for i = 1:num_pairs
%     H0_plus_H2_coeffs(i) = H0_coeffs(i) + H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H0_plus_H2_coeffs(i), W);
%     fprintf("%.10f %s\n",H0_plus_H2_coeffs(i),csd_str);
% end
% 
% %H2+H3+H4+H5子濾波器塊
% H2345_coeffs = zeros(1, num_pairs);
% fprintf("H2 + H3 + H4 + H5 \n");
% for i = 1:num_pairs
%     H2345_coeffs(i) = H2_coeffs(i) + H3_coeffs(i) + H4_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H2345_coeffs(i), W);
%     fprintf("%.10f %s\n",H2345_coeffs(i),csd_str);
% end
% 
% %H0+H1+H2+H3子濾波器塊
% H0123_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 + H2 + H3 \n");
% for i = 1:num_pairs
%     H0123_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H0123_coeffs(i), W);
%     fprintf("%.10f %s\n",H0123_coeffs(i),csd_str);
% end
% 
% %H0+H1-H2-H3子濾波器塊
% H01_minus_23_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 - H2 - H3 \n");
% for i = 1:num_pairs
%     H01_minus_23_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) - H2_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H01_minus_23_coeffs(i), W);
%     fprintf("%.10f %s\n",H01_minus_23_coeffs(i),csd_str);
% end
% 
% %H0+H1+H4+H5子濾波器塊
% H0145_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 + H4 + H5 \n");
% for i = 1:num_pairs
%     H0145_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H4_coeffs(i) + H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H0145_coeffs(i), W);
%     fprintf("%.10f %s\n",H0145_coeffs(i),csd_str);
% end
% 
% %H0+H1-H4-H5子濾波器塊
% H01_minus_45_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 - H4 - H5 \n");
% for i = 1:num_pairs
%     H01_minus_45_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) - H4_coeffs(i) - H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H01_minus_45_coeffs(i), W);
%     fprintf("%.10f %s\n",H01_minus_45_coeffs(i),csd_str);
% end
% 
% %H0+H4-H1-H5子濾波器塊
% H04_minus_15_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H4 - H1 - H5 \n");
% for i = 1:num_pairs
%     H04_minus_15_coeffs(i) = H0_coeffs(i) + H4_coeffs(i) - H1_coeffs(i) - H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H04_minus_15_coeffs(i), W);
%     fprintf("%.10f %s\n",H04_minus_15_coeffs(i),csd_str);
% end
% 
% %H0+H5-H1-H4子濾波器塊
% H05_minus_14_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H5 - H1 - H4 \n");
% for i = 1:num_pairs
%     H05_minus_14_coeffs(i) = H0_coeffs(i) + H5_coeffs(i) - H1_coeffs(i) - H4_coeffs(i);
%     [csd_str, ~] = dec2csd(H05_minus_14_coeffs(i), W);
%     fprintf("%.10f %s\n",H05_minus_14_coeffs(i),csd_str);
% end
% 
% %H0+H2-H1-H3子濾波器塊
% H02_minus_13_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 - H1 - H3 \n");
% for i = 1:num_pairs
%     H02_minus_13_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) - H1_coeffs(i) - H3_coeffs(i);
%     [csd_str, ~] = dec2csd(H02_minus_13_coeffs(i), W);
%     fprintf("%.10f %s\n",H02_minus_13_coeffs(i),csd_str);
% end
% 
% %H0+H3-H1-H2子濾波器塊
% H03_minus_12_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H3 - H1 - H2 \n");
% for i = 1:num_pairs
%     H03_minus_12_coeffs(i) = H0_coeffs(i) + H3_coeffs(i) - H1_coeffs(i) - H2_coeffs(i);
%     [csd_str, ~] = dec2csd(H03_minus_12_coeffs(i), W);
%     fprintf("%.10f %s\n",H03_minus_12_coeffs(i),csd_str);
% end
% 
% %H0+H2+H4子濾波器塊
% H024_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 + H4 \n");
% for i = 1:num_pairs
%     H024_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) + H4_coeffs(i);
%     [csd_str, ~] = dec2csd(H024_coeffs(i), W);
%     fprintf("%.10f %s\n",H024_coeffs(i),csd_str);
% end
% 
% %H0+H1+H2+H3+H4+H5子濾波器塊
% H012345_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H1 + H2 + H3 + H4 + H5 \n");
% for i = 1:num_pairs
%     H012345_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i)+...
%         H4_coeffs(i)+H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H012345_coeffs(i), W);
%     fprintf("%.10f %s\n",H012345_coeffs(i),csd_str);
% end
% 
% %H0+H2+H4-H1-H3-H5子濾波器塊
% H024_minus_135_coeffs = zeros(1, num_pairs);
% fprintf("H0 + H2 + H4 - H1 - H3 - H5 \n");
% for i = 1:num_pairs
%     H024_minus_135_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) + H4_coeffs(i) - H1_coeffs(i) -...
%         H3_coeffs(i) - H5_coeffs(i);
%     [csd_str, ~] = dec2csd(H024_minus_135_coeffs(i), W);
%     fprintf("%.10f %s\n",H024_minus_135_coeffs(i),csd_str);
% end

%並行=8
%H0子濾波器塊
fprintf("Parallelism = 8 \n");
fprintf("H0 \n");
num_pairs = length(best_quant_coeffs) / 8;
H0_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 1;
    H0_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H0_coeffs(i), W);
    fprintf("%.10f %s\n",H0_coeffs(i),csd_str);
end

%H1子濾波器塊
fprintf("H1 \n");
H1_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 2;
    H1_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H1_coeffs(i), W);
    fprintf("%.10f %s\n",H1_coeffs(i),csd_str);
end

%H2子濾波器塊
fprintf("H2 \n");
H2_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 3;
    H2_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H2_coeffs(i), W);
    fprintf("%.10f %s\n",H2_coeffs(i),csd_str);
end

%H3子濾波器塊
fprintf("H3 \n");
H3_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 4;
    H3_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H3_coeffs(i), W);
    fprintf("%.10f %s\n",H3_coeffs(i),csd_str);
end

%H4子濾波器塊
fprintf("H4 \n");
H4_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 5;
    H4_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H4_coeffs(i), W);
    fprintf("%.10f %s\n",H4_coeffs(i),csd_str);
end

%H5子濾波器塊
fprintf("H5 \n");
H5_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 6;
    H5_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H5_coeffs(i), W);
    fprintf("%.10f %s\n",H5_coeffs(i),csd_str);
end

%H6子濾波器塊
fprintf("H6 \n");
H6_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*(i - 1) + 7;
    H6_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H6_coeffs(i), W);
    fprintf("%.10f %s\n",H6_coeffs(i),csd_str);
end

%H7子濾波器塊
fprintf("H7 \n");
H7_coeffs = zeros(1, num_pairs);
for i = 1:num_pairs
    idx = 8*i;
    H7_coeffs(i) = best_quant_coeffs(idx);
    [csd_str, ~] = dec2csd(H7_coeffs(i), W);
    fprintf("%.10f %s\n",H7_coeffs(i),csd_str);
end

%H0+H2子濾波器塊
H0_plus_H2_coeffs = zeros(1, num_pairs);
fprintf("H0 + H2 \n");
for i = 1:num_pairs
    H0_plus_H2_coeffs(i) = H0_coeffs(i) + H2_coeffs(i);
    [csd_str, ~] = dec2csd(H0_plus_H2_coeffs(i), W);
    fprintf("%.10f %s\n",H0_plus_H2_coeffs(i),csd_str);
end

%H1+H3子濾波器塊
H1_plus_H3_coeffs = zeros(1, num_pairs);
fprintf("H1 + H3 \n");
for i = 1:num_pairs
    H1_plus_H3_coeffs(i) = H1_coeffs(i) + H3_coeffs(i);
    [csd_str, ~] = dec2csd(H1_plus_H3_coeffs(i), W);
    fprintf("%.10f %s\n",H1_plus_H3_coeffs(i),csd_str);
end

%H1+H5子濾波器塊
H1_plus_H5_coeffs = zeros(1, num_pairs);
fprintf("H1 + H5 \n");
for i = 1:num_pairs
    H1_plus_H5_coeffs(i) = H1_coeffs(i) + H5_coeffs(i);
    [csd_str, ~] = dec2csd(H1_plus_H5_coeffs(i), W);
    fprintf("%.10f %s\n",H1_plus_H5_coeffs(i),csd_str);
end

%H0+H1子濾波器塊
H0_plus_H1_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 \n");
for i = 1:num_pairs
    H0_plus_H1_coeffs(i) = H0_coeffs(i) + H1_coeffs(i);
    [csd_str, ~] = dec2csd(H0_plus_H1_coeffs(i), W);
    fprintf("%.10f %s\n",H0_plus_H1_coeffs(i),csd_str);
end

%H0+H4子濾波器塊
H0_plus_H4_coeffs = zeros(1, num_pairs);
fprintf("H0 + H4 \n");
for i = 1:num_pairs
    H0_plus_H4_coeffs(i) = H0_coeffs(i) + H4_coeffs(i);
    [csd_str, ~] = dec2csd(H0_plus_H4_coeffs(i), W);
    fprintf("%.10f %s\n",H0_plus_H4_coeffs(i),csd_str);
end

%H2+H3子濾波器塊
H2_plus_H3_coeffs = zeros(1, num_pairs);
fprintf("H2 + H3 \n");
for i = 1:num_pairs
    H2_plus_H3_coeffs(i) = H2_coeffs(i) + H3_coeffs(i);
    [csd_str, ~] = dec2csd(H2_plus_H3_coeffs(i), W);
    fprintf("%.10f %s\n",H2_plus_H3_coeffs(i),csd_str);
end

%H4+H5子濾波器塊
H4_plus_H5_coeffs = zeros(1, num_pairs);
fprintf("H4 + H5 \n");
for i = 1:num_pairs
    H4_plus_H5_coeffs(i) = H4_coeffs(i) + H5_coeffs(i);
    [csd_str, ~] = dec2csd(H4_plus_H5_coeffs(i), W);
    fprintf("%.10f %s\n",H4_plus_H5_coeffs(i),csd_str);
end

%H4+H6子濾波器塊
H4_plus_H6_coeffs = zeros(1, num_pairs);
fprintf("H4 + H6 \n");
for i = 1:num_pairs
    H4_plus_H6_coeffs(i) = H4_coeffs(i) + H6_coeffs(i);
    [csd_str, ~] = dec2csd(H4_plus_H6_coeffs(i), W);
    fprintf("%.10f %s\n",H4_plus_H6_coeffs(i),csd_str);
end

%H2+H6子濾波器塊
H2_plus_H6_coeffs = zeros(1, num_pairs);
fprintf("H2 + H6 \n");
for i = 1:num_pairs
    H2_plus_H6_coeffs(i) = H2_coeffs(i) + H6_coeffs(i);
    [csd_str, ~] = dec2csd(H2_plus_H6_coeffs(i), W);
    fprintf("%.10f %s\n",H2_plus_H6_coeffs(i),csd_str);
end

%H5+H7子濾波器塊
H5_plus_H7_coeffs = zeros(1, num_pairs);
fprintf("H5 + H7 \n");
for i = 1:num_pairs
    H5_plus_H7_coeffs(i) = H5_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H5_plus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H5_plus_H7_coeffs(i),csd_str);
end

%H5-H7子濾波器塊
H5_minus_H7_coeffs = zeros(1, num_pairs);
fprintf("H5 - H7 \n");
for i = 1:num_pairs
    H5_minus_H7_coeffs(i) = H5_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H5_minus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H5_minus_H7_coeffs(i),csd_str);
end

%H3+H7子濾波器塊
H3_plus_H7_coeffs = zeros(1, num_pairs);
fprintf("H3 + H7 \n");
for i = 1:num_pairs
    H3_plus_H7_coeffs(i) = H3_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H3_plus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H3_plus_H7_coeffs(i),csd_str);
end

%H3-H7子濾波器塊
H3_minus_H7_coeffs = zeros(1, num_pairs);
fprintf("H3 - H7 \n");
for i = 1:num_pairs
    H3_minus_H7_coeffs(i) = H3_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H3_minus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H3_minus_H7_coeffs(i),csd_str);
end


%H6+H7子濾波器塊
H6_plus_H7_coeffs = zeros(1, num_pairs);
fprintf("H6 + H7 \n");
for i = 1:num_pairs
    H6_plus_H7_coeffs(i) = H6_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H6_plus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H6_plus_H7_coeffs(i),csd_str);
end

%H6-H7子濾波器塊
H6_minus_H7_coeffs = zeros(1, num_pairs);
fprintf("H6 - H7 \n");
for i = 1:num_pairs
    H6_minus_H7_coeffs(i) = H6_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H6_minus_H7_coeffs(i), W);
    fprintf("%.10f %s\n",H6_minus_H7_coeffs(i),csd_str);
end

%H0+H1+H2+H3子濾波器塊
H0123_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H2 + H3 \n");
for i = 1:num_pairs
    H0123_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i);
    [csd_str, ~] = dec2csd(H0123_coeffs(i), W);
    fprintf("%.10f %s\n",H0123_coeffs(i),csd_str);
end

%H0+H1+H4+H5子濾波器塊
H0145_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H4 + H5 \n");
for i = 1:num_pairs
    H0145_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H4_coeffs(i) + H5_coeffs(i);
    [csd_str, ~] = dec2csd(H0145_coeffs(i), W);
    fprintf("%.10f %s\n",H0145_coeffs(i),csd_str);
end

%H0+H2+H4+H6子濾波器塊
H0246_coeffs = zeros(1, num_pairs);
fprintf("H0 + H2 + H4 + H6 \n");
for i = 1:num_pairs
    H0246_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) + H4_coeffs(i) + H6_coeffs(i);
    [csd_str, ~] = dec2csd(H0246_coeffs(i), W);
    fprintf("%.10f %s\n",H0246_coeffs(i),csd_str);
end

%H1+H3+H5+H7子濾波器塊
H1357_coeffs = zeros(1, num_pairs);
fprintf("H1 + H3 + H5 + H7 \n");
for i = 1:num_pairs
    H1357_coeffs(i) = H1_coeffs(i) + H3_coeffs(i) + H5_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H1357_coeffs(i), W);
    fprintf("%.10f %s\n",H1357_coeffs(i),csd_str);
end

%H1+H3-H5-H7子濾波器塊
H13_minus_57_coeffs = zeros(1, num_pairs);
fprintf("H1 + H3 - H5 - H7 \n");
for i = 1:num_pairs
    H13_minus_57_coeffs(i) = H1_coeffs(i) + H3_coeffs(i) - H5_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H13_minus_57_coeffs(i), W);
    fprintf("%.10f %s\n",H13_minus_57_coeffs(i),csd_str);
end

%H1+H5-H3-H7子濾波器塊
H15_minus_37_coeffs = zeros(1, num_pairs);
fprintf("H1 + H5 - H3 - H7 \n");
for i = 1:num_pairs
    H15_minus_37_coeffs(i) = H1_coeffs(i) + H5_coeffs(i) - H3_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H15_minus_37_coeffs(i), W);
    fprintf("%.10f %s\n",H15_minus_37_coeffs(i),csd_str);
end

%H1+H7-H3-H5子濾波器塊
H17_minus_35_coeffs = zeros(1, num_pairs);
fprintf("H1 + H7 - H3 - H5 \n");
for i = 1:num_pairs
    H17_minus_35_coeffs(i) = H1_coeffs(i) + H7_coeffs(i) - H3_coeffs(i) - H5_coeffs(i);
    [csd_str, ~] = dec2csd(H17_minus_35_coeffs(i), W);
    fprintf("%.10f %s\n",H17_minus_35_coeffs(i),csd_str);
end

%H2+H3+H6+H7子濾波器塊
H2367_coeffs = zeros(1, num_pairs);
fprintf("H2 + H3 + H6 + H7 \n");
for i = 1:num_pairs
    H2367_coeffs(i) = H2_coeffs(i) + H3_coeffs(i) + H6_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H2367_coeffs(i), W);
    fprintf("%.10f %s\n",H2367_coeffs(i),csd_str);
end

%H2+H3-H6-H7子濾波器塊
H23_minus_67_coeffs = zeros(1, num_pairs);
fprintf("H2 + H3 - H6 - H7 \n");
for i = 1:num_pairs
    H23_minus_67_coeffs(i) = H2_coeffs(i) + H3_coeffs(i) - H6_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H23_minus_67_coeffs(i), W);
    fprintf("%.10f %s\n",H23_minus_67_coeffs(i),csd_str);
end

%H2+H6-H3-H7子濾波器塊
H26_minus_37_coeffs = zeros(1, num_pairs);
fprintf("H2 + H6 - H3 - H7 \n");
for i = 1:num_pairs
    H26_minus_37_coeffs(i) = H2_coeffs(i) + H6_coeffs(i) - H3_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H26_minus_37_coeffs(i), W);
    fprintf("%.10f %s\n",H26_minus_37_coeffs(i),csd_str);
end

%H2+H7-H3-H6子濾波器塊
H27_minus_36_coeffs = zeros(1, num_pairs);
fprintf("H2 + H7 - H3 - H6 \n");
for i = 1:num_pairs
    H27_minus_36_coeffs(i) = H2_coeffs(i) + H7_coeffs(i) - H3_coeffs(i) - H6_coeffs(i);
    [csd_str, ~] = dec2csd(H27_minus_36_coeffs(i), W);
    fprintf("%.10f %s\n",H27_minus_36_coeffs(i),csd_str);
end

%H4+H5+H6+H7子濾波器塊
H4567_coeffs = zeros(1, num_pairs);
fprintf("H4 + H5 + H6 + H7 \n");
for i = 1:num_pairs
    H4567_coeffs(i) = H4_coeffs(i) + H5_coeffs(i) + H6_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H4567_coeffs(i), W);
    fprintf("%.10f %s\n",H4567_coeffs(i),csd_str);
end

%H4+H5-H6-H7子濾波器塊
H45_minus_67_coeffs = zeros(1, num_pairs);
fprintf("H4 + H5 - H6 - H7 \n");
for i = 1:num_pairs
    H45_minus_67_coeffs(i) = H4_coeffs(i) + H5_coeffs(i) - H6_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H45_minus_67_coeffs(i), W);
    fprintf("%.10f %s\n",H45_minus_67_coeffs(i),csd_str);
end

%H4+H6-H5-H7子濾波器塊
H46_minus_57_coeffs = zeros(1, num_pairs);
fprintf("H4 + H6 - H5 - H7 \n");
for i = 1:num_pairs
    H46_minus_57_coeffs(i) = H4_coeffs(i) + H6_coeffs(i) - H5_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H46_minus_57_coeffs(i), W);
    fprintf("%.10f %s\n",H46_minus_57_coeffs(i),csd_str);
end

%H4+H7-H5-H6子濾波器塊
H47_minus_56_coeffs = zeros(1, num_pairs);
fprintf("H4 + H7 - H5 - H6 \n");
for i = 1:num_pairs
    H47_minus_56_coeffs(i) = H4_coeffs(i) + H7_coeffs(i) - H5_coeffs(i) - H6_coeffs(i);
    [csd_str, ~] = dec2csd(H47_minus_56_coeffs(i), W);
    fprintf("%.10f %s\n",H47_minus_56_coeffs(i),csd_str);
end

%H0+H1+H2+H3+H4+H5+H6+H7子濾波器塊
H01234567_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H2 + H3 + H4 + H5 + H6 + H7 \n");
for i = 1:num_pairs
    H01234567_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i)+...
        H4_coeffs(i) + H5_coeffs(i) + H6_coeffs(i) + H7_coeffs(i);
    [csd_str, ~] = dec2csd(H01234567_coeffs(i), W);
    fprintf("%.10f %s\n",H01234567_coeffs(i),csd_str);
end

%H0+H1+H2+H3-H4-H5-H6-H7子濾波器塊
H0123_minus_4567_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H2 + H3 - H4 - H5 - H6 - H7 \n");
for i = 1:num_pairs
    H0123_minus_4567_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H2_coeffs(i) + H3_coeffs(i)-...
        H4_coeffs(i) - H5_coeffs(i) - H6_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H0123_minus_4567_coeffs(i), W);
    fprintf("%.10f %s\n",H0123_minus_4567_coeffs(i),csd_str);
end

%H0+H1+H4+H5-H2-H3-H6-H7子濾波器塊
H0145_minus_2367_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H4 + H5 - H2 - H3 - H6 - H7 \n");
for i = 1:num_pairs
    H0145_minus_2367_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H4_coeffs(i) + H5_coeffs(i)-...
        H2_coeffs(i) - H3_coeffs(i) - H6_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H0145_minus_2367_coeffs(i), W);
    fprintf("%.10f %s\n",H0145_minus_2367_coeffs(i),csd_str);
end

%H0+H1+H6+H7-H2-H3-H4-H5子濾波器塊
H0167_minus_2345_coeffs = zeros(1, num_pairs);
fprintf("H0 + H1 + H6 + H7 - H2 - H3 - H4 - H5 \n");
for i = 1:num_pairs
    H0167_minus_2345_coeffs(i) = H0_coeffs(i) + H1_coeffs(i) + H6_coeffs(i) + H7_coeffs(i)-...
        H2_coeffs(i) - H3_coeffs(i) - H4_coeffs(i) - H5_coeffs(i);
    [csd_str, ~] = dec2csd(H0167_minus_2345_coeffs(i), W);
    fprintf("%.10f %s\n",H0167_minus_2345_coeffs(i),csd_str);
end

%H0+H2+H4+H6-H1-H3-H5-H7子濾波器塊
H0246_minus_1357_coeffs = zeros(1, num_pairs);
fprintf("H0 + H2 + H4 + H6 - H1 - H3 - H5 - H7 \n");
for i = 1:num_pairs
    H0246_minus_1357_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) + H4_coeffs(i) + H6_coeffs(i)-...
        H1_coeffs(i) - H3_coeffs(i) - H5_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H0246_minus_1357_coeffs(i), W);
    fprintf("%.10f %s\n",H0246_minus_1357_coeffs(i),csd_str);
end

%H0+H2+H5+H7-H1-H3-H4-H6子濾波器塊
H0257_minus_1346_coeffs = zeros(1, num_pairs);
fprintf("H0 + H2 + H5 + H7 - H1 - H3 - H4 - H6 \n");
for i = 1:num_pairs
    H0257_minus_1346_coeffs(i) = H0_coeffs(i) + H2_coeffs(i) + H5_coeffs(i) + H7_coeffs(i)-...
        H1_coeffs(i) - H3_coeffs(i) - H4_coeffs(i) - H6_coeffs(i);
    [csd_str, ~] = dec2csd(H0257_minus_1346_coeffs(i), W);
    fprintf("%.10f %s\n",H0257_minus_1346_coeffs(i),csd_str);
end

%H0+H3+H4+H7-H1-H2-H5-H6子濾波器塊
H0347_minus_1256_coeffs = zeros(1, num_pairs);
fprintf("H0 + H3 + H4 + H7 - H1 - H2 - H5 - H6 \n");
for i = 1:num_pairs
    H0347_minus_1256_coeffs(i) = H0_coeffs(i) + H3_coeffs(i) + H4_coeffs(i) + H7_coeffs(i)-...
        H1_coeffs(i) - H2_coeffs(i) - H5_coeffs(i) - H6_coeffs(i);
    [csd_str, ~] = dec2csd(H0347_minus_1256_coeffs(i), W);
    fprintf("%.10f %s\n",H0347_minus_1256_coeffs(i),csd_str);
end

%H0+H3+H5+H6-H1-H2-H4-H7子濾波器塊
H0356_minus_1247_coeffs = zeros(1, num_pairs);
fprintf("H0 + H3 + H5 + H6 - H1 - H2 - H4 - H7 \n");
for i = 1:num_pairs
    H0356_minus_1247_coeffs(i) = H0_coeffs(i) + H3_coeffs(i) + H5_coeffs(i) + H6_coeffs(i)-...
        H1_coeffs(i) - H2_coeffs(i) - H4_coeffs(i) - H7_coeffs(i);
    [csd_str, ~] = dec2csd(H0356_minus_1247_coeffs(i), W);
    fprintf("%.10f %s\n",H0356_minus_1247_coeffs(i),csd_str);
end

function [csd_str, num_nonzero] = dec2csd(x, n_bits)
    if x < 0
        sign_factor = -1;
        x_val = -x;
    else
        sign_factor = 1;
        x_val = x;
    end
    int_val = round(x_val * 2^(n_bits-1));
    csd = zeros(1, n_bits+1);
    carry = 0;
    bin_str = dec2bin(int_val, n_bits+1);

    for i = n_bits+1:-1:1
        bit_val = bin_str(i) - '0';
        total = bit_val + carry;
        
        if total == 0
            csd(i) = 0;
            carry = 0;
        elseif total == 1
            if i > 1 && bin_str(i-1) == '1'
                csd(i) = -1;
                carry = 1;
            else
                csd(i) = 1;
                carry = 0;
            end
        elseif total == 2
            csd(i) = 0;
            carry = 1;
        end
    end

    %加回符號
    if carry == 1
        csd = [1, csd];
    end
    csd = sign_factor * csd;

    %字串
    csd_str = repmat('0', 1, length(csd));
    num_nonzero = 0;
    for i = 1:length(csd)
        if csd(i) == 1
            csd_str(i) = '1';
            num_nonzero = num_nonzero + 1;
        elseif csd(i) == -1
            csd_str(i) = '-';
            num_nonzero = num_nonzero + 1;
        else
            csd_str(i) = '0';
        end
    end
end

function quant_coeffs = SPT_allocate(coeffs, n_bits,VSF,N)
    quant_coeffs = zeros(size(coeffs));
    diff = zeros(size(coeffs));
    ideal_coeffs = coeffs * VSF;
    spt_terms = zeros(1, n_bits);
    for i = 0:n_bits
        spt_terms(i+1) = 2^(-i);
    end

    i = 0;
    idx = 1;
    while  i < 1000
        i = i + 1;
        if idx == N + 1
            break;
        else
            for j=0:n_bits
                remaining = ideal_coeffs(idx) - quant_coeffs(idx);

                if ideal_coeffs(idx) >= 0
                    candidate_terms = spt_terms(spt_terms <= remaining);
                    if isempty(candidate_terms)                    
                        break;
                    else
                        best_term = max(candidate_terms);
                    end
                    quant_coeffs(idx) = quant_coeffs(idx) + best_term;
                else 
                    if remaining < 0
                        quant_coeffs(idx) = quant_coeffs(idx) - spt_terms(end);
                    end
                    candidate_terms = spt_terms(spt_terms <= abs(remaining));
                    if isempty(candidate_terms)                 
                        break;
                    else
                        best_term = max(candidate_terms);
                    end
                    quant_coeffs(idx) = quant_coeffs(idx) - best_term;
                end
            end
        end
        idx = idx + 1;
    end
end

function mad_value = calculate_MAD(ideal_coeffs, quant_coeffs)
    n_points = 1024;  
    [H_ideal, w] = freqz(ideal_coeffs, 1, n_points);
    [H_quant, ~] = freqz(quant_coeffs, 1, n_points);

    mag_diff = abs(abs(H_ideal) - abs(H_quant));
    mad_value = max(mag_diff);
end

N = 65536; %數據量
t = 0:1/fs:(N-1)/fs;        
f1 = 16e6;  % 16MHz
f2 = 250e3; % 250kHz

%輸入訊號
input_signal = sin(2*pi*f1*t) + sin(2*pi*f2*t); 

%訊號轉為16bit定點數
bits = 16;                    
max_val = max(abs(input_signal));
scale_factor = 2^(bits-1);  
quantized_value = round(input_signal * scale_factor/max_val); % 添加归一化
quantized_value(quantized_value > 32767) = 32767;


% 轉為二進位數據並寫入txt檔
fidb = fopen('E:\vm\input_data_binary.txt', 'wt');
for x = 1:N
    value = quantized_value(x);

    if value >= 0
        bin_str = dec2bin(value, 16);
    else
        pos_bin = dec2bin(abs(value), 16);
        inverted_bin = char(1 - (pos_bin - '0') + '0');
        carry = 1;
        bin_str = char(zeros(1, 16));
        for k = 16:-1:1
            bit_val = inverted_bin(k) - '0' + carry;
            if bit_val == 2
                bin_str(k) = '0';
                carry = 1;
            else
                bin_str(k) = num2str(bit_val);
                carry = 0;
            end
        end
    end

    fprintf(fidb, '%s\n', bin_str);
end

fclose(fidb);
%濾波結果
output_signal = filter(best_quant_coeffs, 1, input_signal);
% 繪圖
figure('Position', [100, 100, 1000, 800]);

% 計算顯示點數 - 基於低頻f2
display_cycles = 10;
points_per_cycle = fs / f2; % 一個週期之顯示點數
display_points = min(ceil(display_cycles * points_per_cycle), N);

% 輸入波形 
subplot(2,1,1);
plot(t(1:display_points)*1000, input_signal(1:display_points), 'b', 'LineWidth', 1.5);
title(['輸入波形 (', num2str(f1/1e6), 'MHz + ', num2str(f2/1e3), 'kHz)']);
xlabel('時間 (ms)');
ylabel('幅度');
xlim([0, t(display_points)*1000]);
grid on;
legend('輸入訊號');

% 輸出波形
subplot(2,1,2);
plot(t(1:display_points)*1000, output_signal(1:display_points), 'r', 'LineWidth', 1.5);
title('濾波後輸出波形');
xlabel('時間 (ms)');
ylabel('幅度');
xlim([0, t(display_points)*1000]);
grid on;
legend('輸出訊號');
