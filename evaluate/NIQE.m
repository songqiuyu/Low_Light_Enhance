clear
close all

NIQE_1 = [];
NIQE_2 = [];



for cnt=1:600
    try
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\output\\CMNT\\%04d_5_URetinexNet.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        
        process = im2double(imread(src));
        NIQE_value = niqe(process);
        NIQE_1 = [NIQE_1, NIQE_value];


        
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  


for cnt=1:789
    try

        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\output\\LOL\\%d_URetinexNet.png", cnt);
        process = im2double(imread(src));
        NIQE_value = niqe(process);
        NIQE_2 = [NIQE_2, NIQE_value];

        
        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_NIQE1 = mean(NIQE_1(:));
avg_NIQE2 = mean(NIQE_2(:));
len1 = length(NIQE_1(:));
len2 = length(NIQE_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, NIQE_1, 'red', 'filled');
hold on
scatter(index2, NIQE_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_NIQE1, avg_NIQE1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_NIQE2, avg_NIQE2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('NIQE');
title('NIQE Results of URetinex-Net Algorithm Based on HSV Space in CMNT and LOL Datasets');
