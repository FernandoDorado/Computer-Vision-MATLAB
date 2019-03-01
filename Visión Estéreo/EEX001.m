%% Ejercicio de examen
% Suavizado selectivo:
% Es sabido que el suavizado mediante la media emborrona la imagen, lo cual
% es un inconveniente. Una posible solucion es aplicar el suavizado
% solamente en los puntos sospechosos de ser ruido. Un punto sera
% sospechoso si el gradiente sobrepasa un umbral UMG y la intensidad se
% mueve dentro del rango UII<I<UIS.
% Escribir un programa en Matlab que realice el suavizado selectivo de una
% imagen f segun lo expuesto.
% f es monocrona, UII,UIS,UMG dado y suavizado usando V4.

% Tomamos una imagen f de ejemplo

f = imread('coins.png');

UII=46;
UIS=150;
UMG=30;


fobj=(f>UII).*(f<UIS);
ffond=not(fobj);
figure
subplot(1,2,1)
imshow(f)
subplot(1,2,2)
imshow(not(fobj));

[Gx, Gy] = imgradientxy(f,'prewitt');

figure; 
imshowpair(Gx, Gy, 'montage');
title('Directional Gradients: x-direction, Gx (left), y-direction, Gy (right), using Prewitt method')
axis off;

[Gmag, Gdir] = imgradient(Gx, Gy);

fgsel=Gmag>UMG;
figure
imshow(fgsel)

fsel=fgsel.*fobj;


gfinal=SuavizaV4(f);
g=uint8(fsel).*gfinal+uint8(not(fsel)).*f;

figure
subplot(1,2,1)
imshow(f)
subplot(1,2,2)
imshow(g);


