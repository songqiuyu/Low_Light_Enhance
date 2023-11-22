clear
close all

HCR_1 = [];
HCR_2 = [];

for cnt=1:95
    try
        srcI = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\Paper2\\our485\\low\\%d.png", cnt);
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        origin = double(imread(srcI));
        I=double(imread(src));
        origin = rgb2hsv(origin);
        J=rgb2hsv(I);
        hcr = abs(origin(:,:,1) - J(:,:,1)) / I(:,:,1);
        hcr = mean(hcr(:));
        HCR_1 = [HCR_1, hcr];

        % src = sprintf("..\\RetinexHSV\\result\\Unet\\%d_URetinexNet.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=double(imread(src));
        J=rgb2hsv(I);
        hcr = abs(origin(:,:,1) - J(:,:,1)) / I(:,:,1);
        hcr = mean(hcr(:));
        HCR_2 = [HCR_2, hcr];
        
        fprintf("%d done \n", cnt);
    catch
        continue;
    end
end  

avg_HCR1 = mean(HCR_1(:));
avg_HCR2 = mean(HCR_2(:));
len = length(HCR_1(:));
index = linspace(1, len, len);

scatter(index, HCR_1, 'red', 'filled');
hold on
scatter(index, HCR_2, 'blue', 'filled');
hold on
line([1, max(index)], [avg_HCR1, avg_HCR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index)], [avg_HCR2, avg_HCR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
for i = 1:max(index)
    if(HCR_1(i) > HCR_2(i))
        line([i, i], [HCR_1(i), HCR_2(i)], 'Color', 'red', 'LineStyle', '--');
        hold on;
    else
        line([i, i], [HCR_1(i), HCR_2(i)], 'Color', 'blue', 'LineStyle', '--');
        hold on;
    end
end
legend('HSVR', 'MSR', 'HSVR_A_V_E', 'MSR_A_V_E')
    
