%% Separacion y caracteristicas para clasificador
% Una camara toma imagenes digitales en las que siempre existe un fondo
% oscuro homogeneo y un unico objeto de tono mas claro. Se desea clasificar
% el objeto en una de tres posibles clases. Se proporcionan los tres
% prototipos para el discriminante por distancias P!,P2,P3.
% El vector de caracteristicas es: x=(mur maxv muc)^T siendo
% mur: valor medio de rojo.
% maxv: valor maximo de verde.
% muc: valor medio de (r-a)/(a+1).
% Codifique en MATLAB el programa.

% tomamos una imagen de ejemplo

fc = imread('Catedral1.jpg');
figure;
imshow(fc);

% Prototipos

P1=[0.2 10 50]';
P2=[100 40 200]';
P3=[50 200 50]';

% calculamos el vector de caracteristicas

rojo=double(fc(:,:,1));
verde=double(fc(:,:,2));
azul=double(fc(:,:,3));
aux=(rojo-azul)./(azul+1);

mur=mean(red(:));
maxv=max(verde(:));
muc=mean(aux(:));

xo=[mur maxv muc]';

[val,clase]=min([norm(xo-P1,2),norm(xo-P2,2),norm(xo-P3)])