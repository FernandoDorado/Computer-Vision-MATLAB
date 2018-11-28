%%  Cambio de brillo en una imagen
f = imread ('tire.tif');

h = double(f);
g = uint8 (h + 100);
close all; figure;imshow([f,g])

%Lo que ocurre en el histograma es que se desplzada hacia la derecha. Si
%sobrepasa el limite de 255 (uint) todos los puntos se quedan en 255.Todos
%los puntos que pasen pierden información
figure
subplot(2,1,1);imhist(f);subplot(2,1,2);imhist(g);