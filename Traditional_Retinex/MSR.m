for i=1:789
    try
        %src = sprintf("..\\Paper2\\result\\lol\\%d.jpg", i);
        src = sprintf("..\\Paper2\\our485\\low\\%d.png", i);
        I = imread(src);

        I = double(I) / 255;
        [r, g, b] = imsplit(I);

        sigma1 = 100;
        sigma2 = 150;
        sigma3 = 200;

        r_1 = conv_log(r, sigma1);
        r_2 = conv_log(r, sigma2);
        r_3 = conv_log(r, sigma3);

        g_1 = conv_log(g, sigma1);
        g_2 = conv_log(g, sigma2);
        g_3 = conv_log(g, sigma3);

        b_1 = conv_log(b, sigma1);
        b_2 = conv_log(b, sigma2);
        b_3 = conv_log(b, sigma3);

        r = (r_1 + r_2 + r_3) ./ 3;
        g = (g_1 + g_2 + g_3) ./ 3;
        b = (b_1 + b_2 + b_3) ./ 3;

        J = cat(3, r, g, b);
        % dst = sprintf(".\\result\\lol\\%d.jpg", i);
        dst = sprintf(".\\result\\SSR\\%d.jpg", i);
        imwrite(J, dst);
        % figure;imshow(I);
        % figure;imshow(J);
    catch
        continue
    end
end