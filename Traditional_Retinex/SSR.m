% I = imread('..\Paper2\our485\low\2.png');
I = imread('..\Paper2\dorm_revise.jpg');

I = double(I) / 255;
[r, g, b] = imsplit(I);

sigma = 100;


r = bifilter_log(r, sigma);
g = bifilter_log(g, sigma);
b = bifilter_log(b, sigma);


J = cat(3, r, g, b);

figure;imshow(I);
figure;imshow(J);
