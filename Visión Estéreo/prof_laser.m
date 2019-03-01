clear all;
close all;
clc;
%capturamos una imagen de la webcam y la guardamos en im_rgb
imorig = imread('83cm.jpg');
figure(1);
imshow(imorig);
im_rgb=imorig; 
%Tamaño imagen.
[M,N] = size(im_rgb(:,:,3));
%Tamaño sensor CCD de la cámara. (mm)
Dx = 36;
Dy = 48;
tCCD = Dx*Dy;

% separamos las 3 componentes de la señal original en color
im_r=im_rgb(:,:,1);
im_g=im_rgb(:,:,2);
im_b=im_rgb(:,:,3);

% analizamos la componente de color rojo y buscamos el valor maximo que
%correspondera con el centro del laser en la imagen
max_row=0;
max_col=0;
imax=0;
max_r=max(im_r(1,:));
for i=2:M-1
    for j=2:N-1
        if (im_r(i,j)> max_r)
            max_r=double(im_r(i,j));
            max_row=i;
            max_col=j;
        end
    end
end

%representamos la imagen original en color para comprobar que aparece el
%laser en la imagen

figure(1),imshow(im_rgb)       

for i=2:M-1
    for j=2:N-1
        if (i == max_row)||(j == max_col)
            im_rgb(i,j)=255;
        end
    end
end
figure(2);imshow(im_rgb);
%calculamos el numero de pixeles de los que difiere el centro del laser
%desde el centro de la imagen
cent_img =floor( M/2);
pfc=abs(cent_img-max_row);

%calculamos con valores reales y con simulaciones los valores de ganancia y
%desfase mediante la expresion distancia = h/tan(pfc*ganancia+desfase)*2 de
%forma que conociendo la distancia real y la altura h en cm a la que se
%encuentra la camara respecto del laser podemos calcular los parametros
%ganancia y desfase.
ganancia = 0.0024301218;
desfase = -0.056638255;

%Distancia laser-camara (mm)
dist = 5.4;%en centimetros
%aplicamos la formula con la que obtenemos la distancia
distancia = dist/tan(pfc*ganancia+desfase);
fprintf('Profundidad de la imagen = %f.\n',distancia);



