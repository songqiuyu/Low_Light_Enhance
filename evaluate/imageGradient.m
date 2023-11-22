clear
close all

IMG_1 = [];
IMG_2 = [];


for cnt=1:114
    try
        src = sprintf("..\\RetinexHSV\\result\\CMNT\\%04d.png", cnt);
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
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  

for cnt=1:142
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
        IMG_2 = [IMG_2, FI];

        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  


avg_IMG1 = mean(IMG_1(:));
avg_IMG2 = mean(IMG_2(:));
len1 = length(IMG_1(:));
len2 = length(IMG_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, IMG_1, 'red', 'filled');
hold on
scatter(index2, IMG_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_IMG1, avg_IMG1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_IMG2, avg_IMG2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('Gradient');
title('Gradient Results of Retinex Algorithm Based on HSV Space in CMNT and LOL Datasets');
    