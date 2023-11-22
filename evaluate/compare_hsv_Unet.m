%{
I1_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\dataset\low\25.png');
I1_out_HSV = imread('..\RetinexHSV\result\lol\25.png');
I1_out_U = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\lol\25_URetinexNet.png');
%}
I1_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\imgx4\0032x4.png');
I1_out_HSV = imread('..\RetinexHSV\result\CMNT\0032.png');
I1_out_U = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0032_5_URetinexNet.png');

figure;
subplot(3,2,1);imshow(I1_in);title("origin");
subplot(3,2,2);imhist(I1_in);title("Hist origin");
subplot(3,2,3);imshow(I1_out_HSV);title("HSV enhance");
subplot(3,2,4);imhist(I1_out_HSV);title("Hist HSV");
subplot(3,2,5);imshow(I1_out_U);title("UNet enhance");
subplot(3,2,6);imhist(I1_out_U);title("Hist Unet");