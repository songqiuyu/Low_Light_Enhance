for count = 1:789
    try
        % 首先读照片
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\Paper2\\our485\\low\\%d.png", count);
        I = imread(src);

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
                fprintf("pic:%d MSR_%d %f%%\n", count, g, (i-1) / height * 100);
            end
    % vhigh=1/3*(log(imgv./vlow+1)+vhigh);
            vhigh=1/3*(exp(log(imgv) - log(vlow)) + vhigh);            
        end

        % 这里不使用伽马矫正等，使用自定义的算法去调整对比度
        shigh = adapts(s0, v0, vhigh, 0.4, 7);

        %转为RGB输出即可
        result=cat(3,imgh,shigh,vhigh);
        result=hsv2rgb(result);
        dst = sprintf(".\\result\\lol\\%d.png", count);
        imwrite(result, dst);
    catch
        continue;
    end
end