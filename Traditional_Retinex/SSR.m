% I = imread('..\Paper2\our485\low\2.png');
I = imread('.\lowcampus.png');

I = double(I) / 255;
[r, g, b] = imsplit(I);

sigma = 100;


r = conv_log(r, sigma);
g = conv_log(g, sigma);
b = conv_log(b, sigma);


J = cat(3, r, g, b);
imwrite(J, "res_campus.png");

figure;imshow(I);
figure;imshow(J);
