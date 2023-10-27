I = imread('.\dorm.jpg');
J = histeq(I);
figure;imshow(I);
figure;imshow(J);