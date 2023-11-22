

# Low_Light_Enhance

[TOC]

## 环境配置

### 基于HSV空间改进融合Retinex算法的井下图像增强方法

```matlab
clear
close all

% 首先读照片

I = imread(".\143.jpg");

% 将原图转换到HSV空间
hsv = rgb2hsv(I);

% 分别将h, s, v的分量提取出来
imgh = hsv(:,:,1);
imgs = hsv(:,:,2);
imgv = hsv(:,:,3);

% 备份一份原s0，原v0作为对比度调整
s0 = hsv(:,:,2);
v0 = hsv(:,:,3);

% 建立vhigh 和 vlow矩阵
[height, width] = size(imgv);
vhigh = zeros(height, width);
vlow = zeros(height, width);

%w为双边滤波的窗口宽度
w = 64;

%sigma_r为空间域标准差
%sigma_d为灰度值标准差
   
sigma_r = [100 150 200];
sigma_d = [0.3 0.45 0.6];

%{
sigma_r = [15 70 110];
sigma_d = [0.05 0.10 0.15];
%}
% 修正函数值
k = 1;

% MSR的过程，最佳状态一般取3次
for g=1:3
    % 对每个像素开始求解
    for i=1:height
        for j=1:width
            iMin = max(i-w, 1);
            iMax = min(i+w, height);
            jMin = max(j-w, 1);
            jMax = min(j+w, width);
            temp = double(imgv(iMin:iMax, jMin:jMax));
	        [row, col] = size(temp);
	        i0 = floor((row+1)/2);
	        j0 = floor((col+1)/2);
	        Gs = zeros(row, col);
	        Gr = zeros(row, col);
	        for p=1:row
		                for q=1:col
			                diss = temp(p, q) - temp(i0, j0);
			                if diss <= sigma_r / 4
				                Gs(p, q) = exp(-((p-i0)^2 + (q-j0)^2)*(k/sqrt((p-i0)^2 + (q-j0)^2)) / (2 * sigma_r(g) * sigma_r(g)));
                            else                    
				                Gs(p, q) = exp(-((p-i0)^2 + (q-j0)^2) / (2 * sigma_r(g) * sigma_r(g)));
                    end
                            if isnan(Gs(p, q))
                                Gs(p, q) = 0;
                            end
			                Gr(p, q) = exp(-(diss ^ 2) / (2 * sigma_d(g) * sigma_d(g)));
		                end
                    end        
	                W = Gr .* Gs;
	                vlow(i, j) = sum(W(:).*temp(:))/sum(W(:));	                    
        end
        fprintf("MSR_%d %f%%\n", g, (i-1) / height * 100);
            end;
            vhigh=1/3*(exp(log(imgv) - log(vlow)) + vhigh);            
        end

        % 这里不使用伽马矫正等，使用自定义的算法去调整对比度
        shigh = adapts(s0, v0, vhigh, 0.4, 7);

        %转为RGB输出即可
        result=cat(3,imgh,shigh,vhigh);
result=hsv2rgb(result);
imwrite(result,'res_143.jpg');
figure(2);
subplot(121);imshow(I);title('原图');
subplot(122);imshow(result);title('基于双边滤波的MSR');
```



```matlab
function s = adapts(s0, v0, v, t, n)
    [ih, iw] = size(v0);
    s = zeros(ih, iw);
    w = (n-1)/2;
    for i=1:ih
        for j=1:iw
            %{
            改进
            if s0(i, j) == 0
                s(i, j) = 0;
                continue;
            end
            %}
            iMin = max(i-w, 1);
            iMax = min(i+w, ih);
            jMin = max(j-w, 1);
            jMax = min(j+w, iw);
            
            v_W = v0(iMin:iMax, jMin:jMax);
            v_bar = mean(v_W(:));
            s_W = s0(iMin:iMax, jMin:jMax);
            s_bar = mean(s_W(:));

            v_res = v_W - v_bar;
            s_res = s_W - s_bar;
            
            v_s = v_res .* s_res;
            v_s = abs(v_s);

            v_sigma = (v_W - v_bar).^2;
            v_sigma = sum(v_sigma(:));

            s_sigma = (s_W - s_bar).^2;
            s_sigma = sum(s_sigma(:));

            v_s_sigma = sqrt(v_sigma * s_sigma);
            lamda = sum(v_s(:)) / v_s_sigma;
            %--
            t = s0(i, j) + t * (v(i, j) - v0(i, j)) * lamda;
            if(isnan(s(i, j)))
                s(i, j) = s0(i, j);
            else
                s(i, j) = t;
            end
        end
    end

end
```

### Uretinex-net

### 环境

![image-20231122102156952](README.assets/image-20231122102156952.png)

![image-20231122102207788](README.assets/image-20231122102207788.png)

![image-20231122102218650](README.assets/image-20231122102218650.png)

| 包          | 版本         |
| ----------- | ------------ |
| python      | 3.8.18       |
| torch       | 1.9.0+cu111  |
| torchvision | 0.10.0+cu111 |

详情可见requirements.txt

## 数据集对比

### HSV

#### LOL

![image-20231122102612292](README.assets/image-20231122102612292.png)



![image-20231122102614980](README.assets/image-20231122102614980.png)

![image-20231122102618135](README.assets/image-20231122102618135.png)

![image-20231122102622655](README.assets/image-20231122102622655.png)

#### CUMT

![image-20231122102654695](README.assets/image-20231122102654695.png)

![image-20231122102658329](README.assets/image-20231122102658329.png)

![image-20231122102701528](README.assets/image-20231122102701528.png)

#### 客观评价指标

##### 图像熵

![image-20231122160216431](README.assets/image-20231122160216431.png)



##### 对比度变化率

![image-20231122160117495](README.assets/image-20231122160117495.png)

##### 色调变化率

![image-20231122160813676](README.assets/image-20231122160813676.png)

##### 能量梯度函数

![image-20231122163126148](README.assets/image-20231122163126148.png)

##### 方差函数

![image-20231122163515658](README.assets/image-20231122163515658.png)

##### 自相关函数

![image-20231122163808686](README.assets/image-20231122163808686.png)



### Uretinex-net

#### LOL

![image-20231122102957414](README.assets/image-20231122102957414.png)

![image-20231122103000109](README.assets/image-20231122103000109.png)

![image-20231122103002450](README.assets/image-20231122103002450.png)

![image-20231122103004286](README.assets/image-20231122103004286.png)

#### CUMT

![image-20231122103011430](README.assets/image-20231122103011430.png)

![image-20231122103013512](README.assets/image-20231122103013512.png)

![image-20231122103020367](README.assets/image-20231122103020367.png)

![image-20231122103030558](README.assets/image-20231122103030558.png)

#### 客观评价指标

##### PSNR

![image-20231122164037104](README.assets/image-20231122164037104.png)

##### SSIM

![image-20231122164010477](README.assets/image-20231122164010477.png)



##### NIQE

![image-20231122163940361](README.assets/image-20231122163940361.png)



### 两种增强方法对比

#### LOL

![image-20231122164424086](README.assets/image-20231122164424086.png)

![image-20231122164518981](README.assets/image-20231122164518981.png)

![image-20231122164542729](README.assets/image-20231122164542729.png)

#### CUMT

![image-20231122164712997](README.assets/image-20231122164712997.png)

![image-20231122164747567](README.assets/image-20231122164747567.png)

![image-20231122164824063](README.assets/image-20231122164824063.png)

### 细节对比

![image-20231122165014126](README.assets/image-20231122165014126.png)

![image-20231122165106424](README.assets/image-20231122165106424.png)

![image-20231122165327951](README.assets/image-20231122165327951.png)

## 自制数据集

![image-20231122103239551](README.assets/image-20231122103239551.png)

![image-20231122103242382](README.assets/image-20231122103242382.png)

## 自制数据集增强效果

### HSV

![image-20231122103342390](README.assets/image-20231122103342390.png)

![image-20231122103346093](README.assets/image-20231122103346093.png)

![image-20231122103349710](README.assets/image-20231122103349710.png)

![image-20231122103353276](README.assets/image-20231122103353276.png)

### Uretinex_net

![image-20231122103356474](README.assets/image-20231122103356474.png)

![image-20231122103359206](README.assets/image-20231122103359206.png)

![image-20231122103407222](README.assets/image-20231122103407222.png)

![image-20231122103411396](README.assets/image-20231122103411396.png)

### 对比

![image-20231122103913425](README.assets/image-20231122103913425.png)

![image-20231122105654391](README.assets/image-20231122105654391.png)

![image-20231122105750899](README.assets/image-20231122105750899.png)

![image-20231122104008041](README.assets/image-20231122104008041.png)

![image-20231122105529674](README.assets/image-20231122105529674.png)



![image-20231122105918458](README.assets/image-20231122105918458.png)

![image-20231122110134457](README.assets/image-20231122110134457.png)

![image-20231122110405712](README.assets/image-20231122110405712.png)

![image-20231122110703805](README.assets/image-20231122110703805.png)

### 细节对比

![image-20231122105413098](README.assets/image-20231122105413098.png)

![image-20231122110041279](README.assets/image-20231122110041279.png)

![image-20231122110256693](README.assets/image-20231122110256693.png)

![image-20231122110736524](README.assets/image-20231122110736524.png)

## 参考文献

[1]  张立亚,郝博南,孟庆勇等.基于HSV空间改进融合Retinex算法的井下图像增强方法[J].煤炭学报,2020,45(S1):532-540.

[2]  王洪栋,郭伟东,朱美强等.一种煤矿井下低照度图像增强算法[J].工矿自动化,2019,45(11):81-85.

[3] W. Wu, et al.“Uretinex-net: retinex-based deep unfolding network for low-light image enhancement” Proc. of the IEEE Comput. Soc. Conf. Comput. Vis. Pattern Recognit., pp. 5901-5910, 2022.

[4] Lu Y, Jung S W. Progressive joint low-light enhancement and noise removal for raw images[J]. IEEE Transactions on Image Processing, 2022, 31: 2390-2404.

[5] HSV色彩空间的Retinex结构光图像增强算法