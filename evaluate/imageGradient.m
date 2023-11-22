clear
close all

IMG_1 = [];
IMG_2 = [];
% 
for cnt=1:50
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        I=imread(src); %读取图片
        I=double(I); 
        [M, N]=size(I); 
        FI=0; 
        for x=1:M-1 
            for y=1:N-1 
                % x方向和y方向的相邻像素灰度值只差的的平方和作为清晰度值
                FI=FI+(I(x+1,y)-I(x,y))*(I(x+1,y)-I(x,y))+(I(x,y+1)-I(x,y))*(I(x,y+1)-I(x,y));
            end 
         end 
        IMG_1 = [IMG_1, FI];

        % src = sprintf("..\\RetinexHSV\\result\\Unet\\%d_URetinexNet.png", cnt);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        I=imread(src); %读取图片
        I=double(I); 
        [M, N]=size(I); 
        FI=0; 
        for x=1:M-1 
            for y=1:N-1 
                % x方向和y方向的相邻像素灰度值只差的的平方和作为清晰度值
                FI=FI+(I(x+1,y)-I(x,y))*(I(x+1,y)-I(x,y))+(I(x,y+1)-I(x,y))*(I(x,y+1)-I(x,y));
            end 
         end 
        IMG_2 = [IMG_2, FI];
        
        fprintf("%d done \n", cnt);
    catch
        continue;
    end
end  


len = length(IMG_1(:));

for W = 1:len 
     C = max(IMG_1(:)); 
     D = min(IMG_1(:)); 
     E = C-D; 
     R = (IMG_1(W) - D)/(E); 
     IMG_1(W) = R; 
end 

for W = 1:len 
     C = max(IMG_2(:)); 
     D = min(IMG_2(:)); 
     E = C-D; 
     R = (IMG_2(W) - D)/(E); 
     IMG_2(W) = R; 
end 

index = linspace(1, len, len);
avg_IMG1 = mean(IMG_1(:));
avg_IMG2 = mean(IMG_2(:));

scatter(index, IMG_1, 'red', 'filled');
hold on
scatter(index, IMG_2, 'blue', 'filled');
hold on
line([1, max(index)], [avg_IMG1, avg_IMG1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index)], [avg_IMG2, avg_IMG2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
for i = 1:max(index)
    if(IMG_1(i) > IMG_2(i))
        line([i, i], [IMG_1(i), IMG_2(i)], 'Color', 'red', 'LineStyle', '--');
        hold on;
    else
        line([i, i], [IMG_1(i), IMG_2(i)], 'Color', 'blue', 'LineStyle', '--');
        hold on;
    end
end
legend('HSVR', 'MSR', 'HSVR_A_V_E', 'MSR_A_V_E')
    