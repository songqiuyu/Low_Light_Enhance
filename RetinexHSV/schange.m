%for count = 119:789
 %for count = 71:600
 for count = 1:200
    try
        % 首先读照片
        %src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\Paper2\\our485\\low\\%d.png", count);
        %src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\input\\imgx4\\%04dx4.png", count);
        src = sprintf("..\\..\\..\\PaperReproduction\\DigitalImage\\URetinex-Net-main\\demo\\input\\mydata\\%d.png", count);
        src2 = sprintf(".\\result\\mydata\\%d.png", count);
        I = imread(src);
        hsv = rgb2hsv(I);
        I_enhance = imread(src2);
        % 将原图转换到HSV空间
        hsv_enhance = rgb2hsv(I_enhance);
        
        h0 = hsv(:,:,1);
        s0 = hsv(:,:,2);
        v0 = hsv(:,:,3);
        v1 = hsv_enhance(:,:,3);

        %s1 = adapts(s0, v0, v1, 0.4, 7);
        s1 = adapts(s0, v0, v1, 0.4, 65);
        
        %result=cat(3,imgh,shigh,vhigh);
        result = cat(3, h0, s1, v1);
        result=hsv2rgb(result);

        %dst = sprintf(".\\result\\lol\\%d.png", count);
        %dst = sprintf(".\\result\\CMNT\\%04d.png", count);
        dst = sprintf(".\\result\\mydata_color_change\\%d.png", count);
        imwrite(result, dst);
    catch
        continue;
    end
end