clear
close all

%---------------------------------
%求一幅图像的熵值
%---------------------------------
index = 0;
H_1 = [];
H_2 = [];
for cnt=1:95
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
        %index = index + 1;
        %scatter(index, H_x1, 'red','filled');
        %hold on
        H_1 = [H_1, H_x1];
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\RetinexDemo\\result\\SSR\\%d.jpg", cnt);
        % src = sprintf("..\\RetinexHSV\\result\\Unet\\%d_URetinexNet.png", cnt);
        I=imread(src);
        %I=imread('..\RetinexHSV\result\U1.png');
        [C,L]=size(I); %求图像的规格
        Img_size=C*L; %图像像素点的总个数
        G=256; %图像的灰度级
        H_x2=0;
        nk=zeros(G,1);%产生一个G行1列的全零矩阵
        for i=1:C
            for j=1:L
                Img_level=I(i,j)+1; %获取图像的灰度级
                nk(Img_level)=nk(Img_level)+1; %统计每个灰度级像素的点数
            end
        end
        for k=1:G  %循环
            Ps(k)=nk(k)/Img_size; %计算每一个像素点的概率
            if Ps(k)~=0 %如果像素点的概率不为零
                H_x2=-Ps(k)*log2(Ps(k))+H_x2; %求熵值的公式
            end
        end
        %scatter(index, H_x2, 'blue','filled');
        %hold on;
        %if H_x1 > H_x2
            %line([index, index], [H_x1 ,H_x2], Color='red');
            %hold on;
        %else
            %line([index, index], [H_x1 ,H_x2], Color='blue');
            %hold on;
        %end
        H_2 = [H_2, H_x2];
        fprintf("%d done \n", cnt);
    catch
        continue;
    end
end


avg_H1 = mean(H_1(:));
avg_H2 = mean(H_2(:));
len = length(H_1(:));
index = linspace(1, len, len);

scatter(index, H_1, 'red', 'filled');
hold on
scatter(index, H_2, 'blue', 'filled');
hold on
line([1, max(index)], [avg_H1, avg_H1], 'Color', 'red', 'LineWidth', 1.5);
hold on
line([1, max(index)], [avg_H2, avg_H2], 'Color', 'blue', 'LineWidth', 1.5);
hold on
for i = 1:max(index)
    if(H_1(i) > H_2(i))
        line([i, i], [H_1(i), H_2(i)], 'Color', 'red', 'LineStyle', '--');
        hold on;
    else
        line([i, i], [H_1(i), H_2(i)], 'Color', 'blue', 'LineStyle', '--');
        hold on;
    end
end
legend('HSVR', 'MSR', 'HSVR_A_V_E', 'MSR_A_V_E')
    







