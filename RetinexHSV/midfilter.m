I = imread('res_143.jpg');


%J = imgaussfilt(I, 0.8);
I(:,:,1) = medfilt2(I(:,:,1), [4, 4]);
I(:,:,2) = medfilt2(I(:,:,2), [4, 4]);
I(:,:,3) = medfilt2(I(:,:,3), [4, 4]);

figure;
imshow(I);
