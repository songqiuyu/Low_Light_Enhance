clear
close all

CCR_1 = [];
CCR_2 = [];


for cnt=1:114
    try
        src = sprintf("..\\RetinexHSV\\result\\CMNT\\%04d.png", cnt);
        I=imread(src);
        CCR_1 = [CCR_1, max(I(:)) - min(I(:))];
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  

for cnt=1:142
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        I=imread(src);
        CCR_2 = [CCR_2, max(I(:)) - min(I(:))];
        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_CCR1 = mean(CCR_1(:));
avg_CCR2 = mean(CCR_2(:));
len1 = length(CCR_1(:));
len2 = length(CCR_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, CCR_1, 'red', 'filled');
hold on
scatter(index2, CCR_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_CCR1, avg_CCR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_CCR2, avg_CCR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('ContrastChangeRate');
title('ContrastChangeRate Results of Retinex Algorithm Based on HSV Space in CMNT and LOL Datasets');
    