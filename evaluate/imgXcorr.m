clear
close all

VAR_1 = [];
VAR_2 = [];


for cnt=1:114
    try

        src = sprintf("..\\RetinexHSV\\result\\CMNT\\%04d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=double(imread(src));
        coor=autocorr(I(:));
        
        VAR_1 = [VAR_1, mean(coor(:))];
        
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  

for cnt=1:142
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=double(imread(src));
        coor=autocorr(I(:));
        
        VAR_2 = [VAR_2, mean(coor(:))];

        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_VAR1 = mean(VAR_1(:));
avg_VAR2 = mean(VAR_2(:));
len1 = length(VAR_1(:));
len2 = length(VAR_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, VAR_1, 'red', 'filled');
hold on
scatter(index2, VAR_2, 'blue', 'filled');
hold on
line([1, max(index2)], [avg_VAR1, avg_VAR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index2)], [avg_VAR2, avg_VAR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('Xcoor');
title('Xcoor Results of Retinex Algorithm Based on HSV Space in CMNT and LOL Datasets');
    