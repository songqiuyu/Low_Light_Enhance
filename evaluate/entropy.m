clear
close all

%---------------------------------
%求一幅图像的熵值
%---------------------------------
index = 0;
H_1 = [];
H_2 = [];


for cnt=1:114
    try
        src = sprintf("..\\RetinexHSV\\result\\CMNT\\%04d.png", cnt);
        I=imread(src);
        %I=imread('..\RetinexHSV\result\U1.png');
        [C,L]=size(I); %求图像的规格
        Img_size=C*L; %图像像素点的总个数
        G=256; %图像的灰度级
        H_x1=0;
        nk=zeros(G,1);%产生一个G行1列的全零矩阵
        for i=1:C
            for j=1:L
                Img_level=I(i,j)+1; %获取图像的灰度级
                nk(Img_level)=nk(Img_level)+1; %统计每个灰度级像素的点数
            end
        end
        for k=1:G  %循环
            Ps(k)=nk(k)/Img_size; %计算每一个像素点的概率
            if Ps(k)~=0; %如果像素点的概率不为零
                H_x1=-Ps(k)*log2(Ps(k))+H_x1; %求熵值的公式
            end
        end
        H_1 = [H_1, H_x1];
        fprintf("CMNT: %d done \n", cnt);
    catch
        continue;
    end
end  

for cnt=1:142
    try
        src = sprintf("..\\RetinexHSV\\result\\lol\\%d.png", cnt);
        I=imread(src);
        %I=imread('..\RetinexHSV\result\U1.png');
        [C,L]=size(I); %求图像的规格
        Img_size=C*L; %图像像素点的总个数
        G=256; %图像的灰度级
        H_x1=0;
        nk=zeros(G,1);%产生一个G行1列的全零矩阵
        for i=1:C
            for j=1:L
                Img_level=I(i,j)+1; %获取图像的灰度级
                nk(Img_level)=nk(Img_level)+1; %统计每个灰度级像素的点数
            end
        end
        for k=1:G  %循环
            Ps(k)=nk(k)/Img_size; %计算每一个像素点的概率
            if Ps(k)~=0; %如果像素点的概率不为零
                H_x1=-Ps(k)*log2(Ps(k))+H_x1; %求熵值的公式
            end
        end
        H_2 = [H_2, H_x1];
        fprintf("LOL: %d done \n", cnt);
    catch
        continue;
    end
end  



avg_H1 = mean(H_1(:));
avg_H2 = mean(H_2(:));
len1 = length(H_1(:));
len2 = length(H_2(:));
index1 = linspace(1, len1, len1);
index2 = linspace(2, len2, len2);

scatter(index1, H_1, 'red', 'filled');
hold on
scatter(index2, H_2, 'blue', 'filled');
hold on
line([1, max(index1)], [avg_H1, avg_H1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index1)], [avg_H2, avg_H2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
legend('CMNT', 'LOL', 'CMNT_A_V_E', 'LOL_A_V_E')
xlabel('Samples(n)');
ylabel('Entropy');
title('Entropy Results of Retinex Algorithm Based on HSV Space in CMNT and LOL Datasets');







