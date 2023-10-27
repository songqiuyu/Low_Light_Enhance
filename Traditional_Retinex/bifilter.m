function J = bifilter(I, kernalsize, sigmac, sigmas);
% 三个参数分别指定kernel size、空间域的标准差、值域的标准差和原始图像
    [h, w] = size(I);
    J = zeros(h, w);
    [X, Y] = meshgrid(1:kernalsize, 1:kernalsize);
    dist = (X-ceil(kernalsize/2)).^2 + (Y-ceil(kernalsize/2)).^2;
    Gc = exp(-dist/2/sigmac^2);

    padim = padarray(I, [floor(kernalsize/2), floor(kernalsize/2)], 0, 'both');

    for i=1:h
        for j=1:w
            t = double(padim(i:i+kernalsize-1,j:j+kernalsize-1));
            Gs = exp(-(t - t(ceil(kernalsize/2), ceil(kernalsize/2))).^2/2/sigmas^2);
            Wp = sum(sum(Gc .* Gs));
            J(i, j) = sum(sum(Gc.*Gs.*t))/Wp;
        end
    end

end