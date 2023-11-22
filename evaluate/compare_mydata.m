I1_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\mydata\182.png');
I1_out_HSV = imread('..\RetinexHSV\result\mydata_color_change\182.png');
I1_out_U = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\mydata\182_5_URetinexNet.png');

figure;
subplot(3,2,1);imshow(I1_in);title("origin");
subplot(3,2,2);imhist(I1_in);title("Hist origin");
subplot(3,2,3);imshow(I1_out_HSV);title("HSV enhance");
subplot(3,2,4);imhist(I1_out_HSV);title("Hist HSV");
subplot(3,2,5);imshow(I1_out_U);title("UNet enhance");
subplot(3,2,6);imhist(I1_out_U);title("Hist Unet");


