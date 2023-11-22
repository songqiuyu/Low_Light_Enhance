clear
close all

HCR_1 = [];
HCR_2 = [];


for cnt=1:114
    try
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\input\\imgx4\\%04dx4.png", cnt);
        src = sprintf("..\\RetinexHSV\\result\\CMNT\\%04d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        origin = double(imread(srcI));
        I=double(imread(src));
        origin = rgb2hsv(origin);
        J=rgb2hsv(I);
        hcr = abs(origin(:,:,1) - J(:,:,1)) / I(:,:,1);
        hcr = mean(hcr(:));
        HCR_1 = [HCR_1, hcr];
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  

for cnt=1:142
    try
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\dataset\\low\\%d.png", cnt);
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        origin = double(imread(srcI));
        I=double(imread(src));
        origin = rgb2hsv(origin);
        J=rgb2hsv(I);
        hcr = abs(origin(:,:,1) - J(:,:,1)) / I(:,:,1);
        hcr = mean(hcr(:));
        HCR_2 = [HCR_2, hcr];
        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_HCR1 = mean(HCR_1(:));
avg_HCR2 = mean(HCR_2(:));
len1 = length(HCR_1(:));
len2 = length(HCR_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, HCR_1, 'red', 'filled');
hold on
scatter(index2, HCR_2, 'blue', 'filled');
hold on
line([1, max(index2)], [avg_HCR1, avg_HCR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index2)], [avg_HCR2, avg_HCR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('HCR');
title('HCR Results of Retinex Algorithm Based on HSV Space in CMNT and LOL Datasets');
    