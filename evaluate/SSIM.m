clear
close all

SSIM_1 = [];
SSIM_2 = [];

for cnt=1:600
    try
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\input\\img\\%04d.png", cnt);
        %src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\output\\CMNT\\%04d_5_URetinexNet.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        
        origin = im2double(imread(srcI));
        process = im2double(imread(src));
        SSIM_value = ssim(process, origin);
        SSIM_1 = [SSIM_1, SSIM_value];

        
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  


for cnt=1:789
    try
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\dataset\\high\\%d.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\output\\LOL\\%d_URetinexNet.png", cnt);
        
        origin = im2double(imread(srcI));
        process = im2double(imread(src));
        SSIM_value = ssim(process, origin);
        SSIM_2 = [SSIM_2, SSIM_value];

        
        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  



avg_SSIM1 = mean(SSIM_1(:));
avg_SSIM2 = mean(SSIM_2(:));
len1 = length(SSIM_1(:));
len2 = length(SSIM_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, SSIM_1, 'red', 'filled');
hold on
scatter(index2, SSIM_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_SSIM1, avg_SSIM1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_SSIM2, avg_SSIM2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('SSIM');
title('SSIM Results of URetinex-Net Algorithm Based on HSV Space in CMNT and LOL Datasets');
