clear
close all

PSNR_1 = [];
PSNR_2 = [];

for cnt=1:600
    try
        %srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\Paper2\\our485\\low\\%d.png", cnt);
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\input\\img\\%04d.png", cnt);
        %src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\output\\CMNT\\%04d_5_URetinexNet.png", cnt);
        
        origin = im2double(imread(srcI));
        process = im2double(imread(src));
        psnr_value = psnr(process, origin);
        
        PSNR_1 = [PSNR_1, psnr_value];

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
        psnr_value = psnr(process, origin);
        PSNR_2 = [PSNR_2, psnr_value];

        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_PSNR1 = mean(PSNR_1(:));
avg_PSNR2 = mean(PSNR_2(:));
len1 = length(PSNR_1(:));
len2 = length(PSNR_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, PSNR_1, 'red', 'filled');
hold on
scatter(index2, PSNR_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_PSNR1, avg_PSNR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_PSNR2, avg_PSNR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('PSNR');
title('PSNR Results of URetinex-Net in CMNT and LOL Datasets');

    
