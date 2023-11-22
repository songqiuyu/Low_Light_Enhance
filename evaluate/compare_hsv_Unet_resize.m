I1_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\imgx4\0110x4.png');
I1_out_HSV = imread('..\RetinexHSV\result\CMNT\0110.png');
I1_out_U = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0110_5_URetinexNet.png');
[J,rect] = imcrop(I1_in);
rect
figure;
subplot(3,2,1);imshow(I1_in);title("origin");
subplot(3,2,2);imshow(imcrop(I1_in, rect));title("origin part");
subplot(3,2,3);imshow(I1_out_HSV);title("HSV enhance");
subplot(3,2,4);imshow(imcrop(I1_out_HSV, rect));title("HSV part");
subplot(3,2,5);imshow(I1_out_U);title("UNet enhance");
subplot(3,2,6);imshow(imcrop(I1_out_U, rect));title("Unet part");