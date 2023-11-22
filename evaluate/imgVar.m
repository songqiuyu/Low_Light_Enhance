clear
close all

VAR_1 = [];
VAR_2 = [];

for cnt=1:95
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        % src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=double(imread(src));
        VAR_1 = [VAR_1, var(I(:))];

        % src = sprintf("..\\RetinexHSV\\result\\Unet\\%d_URetinexNet.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=double(imread(src));
        VAR_2 = [VAR_2, var(I(:))];
        
        fprintf("%d done \n", cnt);
    catch
        continue;
    end
end  

len = length(VAR_1(:));
for W = 1:len 
     C = max(VAR_1(:)); 
     D = min(VAR_1(:)); 
     E = C-D; 
     R = (VAR_1(W) - D)/(E); 
     VAR_1(W) = R; 
end 

for W = 1:len 
     C = max(VAR_2(:)); 
     D = min(VAR_2(:)); 
     E = C-D; 
     R = (VAR_2(W) - D)/(E); 
     VAR_2(W) = R; 
end 

avg_VAR1 = mean(VAR_1(:));
avg_VAR2 = mean(VAR_2(:));

index = linspace(1, len, len);

scatter(index, VAR_1, 'red', 'filled');
hold on
scatter(index, VAR_2, 'blue', 'filled');
hold on
line([1, max(index)], [avg_VAR1, avg_VAR1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index)], [avg_VAR2, avg_VAR2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
for i = 1:max(index)
    if(VAR_1(i) > VAR_2(i))
        line([i, i], [VAR_1(i), VAR_2(i)], 'Color', 'red', 'LineStyle', '--');
        hold on;
    else
        line([i, i], [VAR_1(i), VAR_2(i)], 'Color', 'blue', 'LineStyle', '--');
        hold on;
    end
end
legend('HSVR', 'MSR', 'HSVR_A_V_E', 'MSR_A_V_E')
    