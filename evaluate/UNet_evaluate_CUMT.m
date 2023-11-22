I1_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0001.png');
I1_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0001_5_URetinexNet.png');

I2_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0023.png');
I2_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0023_5_URetinexNet.png');

I3_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0075.png');
I3_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0075_5_URetinexNet.png');

I4_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0111.png');
I4_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0111_5_URetinexNet.png');

I5_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0231.png');
I5_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0231_5_URetinexNet.png');

I6_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0451.png');
I6_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0451_5_URetinexNet.png');

I7_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0013.png');
I7_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0013_5_URetinexNet.png');

I8_in  = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\input\img\0087.png');
I8_out = imread('..\..\..\PaperReproduction\DigitalImage\URetinex-Net-main\demo\output\CMNT\0087_5_URetinexNet.png');

figure(1);sgtitle("evaluate image group 1");
subplot(2,4,1);imshow(I1_in);title("image_1 origin")
subplot(2,4,2);imhist(I1_in);title("image_1 origin hist")
subplot(2,4,3);imshow(I1_out);title("image_1 enhance")
subplot(2,4,4);imhist(I1_out);title("image_1 enhance hist")
subplot(2,4,5);imshow(I2_in);title("image_2 origin")
subplot(2,4,6);imhist(I2_in);title("image_2 origin hist")
subplot(2,4,7);imshow(I2_out);title("image_2 enhance")
subplot(2,4,8);imhist(I2_out);title("image_2 enhance hist")

figure(2);sgtitle("evaluate image group 2");
subplot(2,4,1);imshow(I3_in);title("image_3 origin")
subplot(2,4,2);imhist(I3_in);title("image_3 origin hist")
subplot(2,4,3);imshow(I3_out);title("image_3 enhance")
subplot(2,4,4);imhist(I3_out);title("image_3 enhance hist")
subplot(2,4,5);imshow(I4_in);title("image_4 origin")
subplot(2,4,6);imhist(I4_in);title("image_4 origin hist")
subplot(2,4,7);imshow(I4_out);title("image_4 enhance")
subplot(2,4,8);imhist(I4_out);title("image_4 enhance hist")

figure(3);sgtitle("evaluate image group 3");
subplot(2,4,1);imshow(I5_in);title("image_5 origin")
subplot(2,4,2);imhist(I5_in);title("image_5 origin hist")
subplot(2,4,3);imshow(I5_out);title("image_5 enhance")
subplot(2,4,4);imhist(I5_out);title("image_5 enhance hist")
subplot(2,4,5);imshow(I6_in);title("image_6 origin")
subplot(2,4,6);imhist(I6_in);title("image_6 origin hist")
subplot(2,4,7);imshow(I6_out);title("image_6 enhance")
subplot(2,4,8);imhist(I6_out);title("image_6 enhance hist")

figure(4);sgtitle("evaluate image group 4");
subplot(2,4,1);imshow(I7_in);title("image_7 origin")
subplot(2,4,2);imhist(I7_in);title("image_7 origin hist")
subplot(2,4,3);imshow(I7_out);title("image_7 enhance")
subplot(2,4,4);imhist(I7_out);title("image_7 enhance hist")
subplot(2,4,5);imshow(I8_in);title("image_8 origin")
subplot(2,4,6);imhist(I8_in);title("image_8 origin hist")
subplot(2,4,7);imshow(I8_out);title("image_8 enhance")
subplot(2,4,8);imhist(I8_out);title("image_8 enhance hist")