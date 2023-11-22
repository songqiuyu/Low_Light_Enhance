clear
close all

CCR_1 = [];
CCR_2 = [];

for cnt=1:95
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=imread(src);
        CCR_1 = [CCR_1, max(I(:)) - min(I(:))];

        % src = sprintf("..\\RetinexHSV\\result\\Unet\\%d_URetinexNet.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=imread(src);
        CCR_2 = [CCR_2, max(I(:)) - min(I(:))];
        
        fprintf("%d done \n", cnt);
    catch
        continue;
    end
end  

avg_CCR1 = mean(CCR_1(:));
avg_CCR2 = mean(CCR_2(:));
len = length(CCR_1(:));
index = linspace(1, len, len);

scatter(index, CCR_1, 'red', 'filled');
hold on
scatter(index, CCR_2, 'blue', 'filled');
hold on
line([1, max(index)], [avg_CCR1, avg_CCR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index)], [avg_CCR2, avg_CCR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
for i = 1:max(index)
    if(CCR_1(i) > CCR_2(i))
        line([i, i], [CCR_1(i), CCR_2(i)], 'Color', 'red', 'LineStyle', '--');
        hold on;
    else
        line([i, i], [CCR_1(i), CCR_2(i)], 'Color', 'blue', 'LineStyle', '--');
        hold on;
    end
end
legend('HSVR', 'MSR', 'HSVR_A_V_E', 'MSR_A_V_E')
    