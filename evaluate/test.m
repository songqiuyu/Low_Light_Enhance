%EOG(Energy Of Grad)
 N1 = 1;      %要处理的图片张数
 A = zeros(1,N1);  %存储每一幅图像清晰度评价值
 X = zeros(1,N1);  %存储做归一化处理后的评价值
tic     %计时
for L=1: N1 
 I=imread('..\RetinexHSV\result\lol\1.png'); %连续读取图片
 I=double(I); 
 [M N]=size(I); 
 FI=0; 
 for x=1:M-1 
     for y=1:N-1 
          % x方向和y方向的相邻像素灰度值只差的的平方和作为清晰度值
         FI=FI+(I(x+1,y)-I(x,y))*(I(x+1,y)-I(x,y))+(I(x,y+1)-I(x,y))*(I(x,y+1)-I(x,y));
     end 
 end 
 A(1,L) = FI
end 




time=toc
%-------------------------------- 
%对图像清晰度值做归一化处理，线性函数归一化公式
 for W = 1:N1 
     C = max(A); 
     D = min(A); 
     E = C-D; 
     R = (A(1,W) - D)/(E); 
     X(1,W) = R; 
 end 
%做曲线拟合输出函数曲线  
x1=[-20 -10 0 10 20 ]; 
y1 = [X(1,1) X(1,1) X(1,1) X(1,1) X(1,1)];
[p,S]=polyfit(x1,y1,2); 
Y=polyconf(p,x1,y1); 
plot(x1,y1,'y');
hold on;
