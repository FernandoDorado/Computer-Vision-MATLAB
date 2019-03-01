clc
clear all
close all

RGB=imread('gantrycrane.png');
I=rgb2gray(RGB);
imagen=I;
subplot(2,2,1)
imshow(imagen)
title('Imagen original');

% Imagen binaria
level=graythresh(imagen);
bn=im2bw(imagen,level);
subplot(2,2,2);
imshow(bn)
title('Imagen binaria')

% Deteccion de bordes

bn=edge(bn,'sobel');
subplot(2,2,3)
imshow(bn)
title('bordes');

subplot(2,2,4)
imshow(imagen)

[H,T,R]=hough(bn);
peaks=houghpeaks(H,5);
