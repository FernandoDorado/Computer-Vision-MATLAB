%% Rotación imagenes
f = imread ('cameraman.tif');
g = imrotate(f,30);
imshow(g);