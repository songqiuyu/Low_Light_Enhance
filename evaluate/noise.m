for i=28:29
    src = sprintf('.\\%d.png', i);
    I = imread(src);
    J = imnoise(I,'gaussian', 0, 0.03);
    J = imnoise(J, 'salt & pepper', 0.03);
    dst = sprintf('.\\n_%d.png', i);
    imwrite(J, dst);
end
