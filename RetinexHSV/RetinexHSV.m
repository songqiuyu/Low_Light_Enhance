I = imread(".\0013.png");
hsv = rgb2hsv(I);
imgh = hsv(:,:,1);
imgs = hsv(:,:,2);
imgv = hsv(:,:,3);
s0 = hsv(:,:,2);
v0 = hsv(:,:,3);

[height, width] = size(imgv);
vhigh = zeros(height, width);
vlow = zeros(height, width);
w = 3;
sigma_s = [15 70 110];
sigma_r = [0.05 0.10 0.15];
[X, Y] = meshgrid(-w:w, -w:w);

for g=1:3
    % 欧氏距离卷积核，每次都是一样的
    Gs = exp(-(X.^2+Y.^2)/(2*sigma_s(g)^2));
    % 进行三次MSR
    for i=1:height
        for j=1:width
            % 卷积核范围
            temp=imgv(max(i-w,1):min(i+w,height),max(j-w,1):min(j+w,width));
            %求Gr是灰度值卷积核
            Gr = exp(-(temp-imgv(i,j)).^2/(2*sigma_r(g)^2));
            %两核相乘，这里要调整一下Gs核
            W = Gr.*Gs((max(i-w,1):min(i+w,height))-i+w+1,(max(j-w,1):min(j+w,width))-j+w+1);
            %求出卷积后的图像
            vlow(i,j)=sum(W(:).*temp(:))/sum(W(:));
        end
    end
    %C =0.77;
    %Gamma =[0.05 0.1 0.3];
    %vlow = C*(vlow.^Gamma(g));
    vhigh=1/3*(exp(log(imgv) - log(vlow)) + vhigh);
end

shigh = adapts(s0, v0, vhigh, 0.4, 7);

result=cat(3,imgh,shigh,vhigh);
result=hsv2rgb(result);
figure(2);
subplot(121);imshow(I);title('原图');
subplot(122);imshow(result);title('基于双边滤波的MSR');