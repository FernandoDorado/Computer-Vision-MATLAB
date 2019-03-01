clear all
close all

%% Correspondencia entre puntos

Ic1=double(imread('Catedral1.JPG'));
Ic2=double(imread('Catedral2.JPG'));

Ic2=Ic2(1:size(Ic1,1),1:size(Ic1,2),:);

[Ny,Mx]=size(Ic1(:,:,1));

tam=floor(round([Ny,Mx]./20)/2);

Ic1bn=rgb2gray(uint8(Ic1));
Ic2bn=rgb2gray(uint8(Ic2));

figure
imshow(Ic1bn);
figure
imshow(Ic2bn);

% Detector de puntos singulares

[Ix, Iy] = imgradientxy(Ic1bn,'prewitt');

figure; 
imshowpair(Ix, Iy, 'montage');
title('Gradientes direccionales: Direccion x, Gx (Izq), Direccion y, Gy (Der), metodo Prewitt')
axis off;

Autoval1=zeros(Ny,Mx);
Autoval2=zeros(Ny,Mx);

for i=1:Ny
    for j=1:Mx
        % Montamos el tensor por cada punto de la imagen
        eigval=eig([Ix(i,j)^2 Ix(i,j)*Iy(i,j);Iy(i,j)*Ix(i,j) Iy(i,j)^2]);
        Autoval1(i,j)=eigval(1);
        Autoval2(i,j)=eigval(2);
    end
end

% buscamos puntos singulares

[fila2,columna2]=find(Autoval2>1e5);
[fila1,columna1]=find(Autoval1>1e5);

if isempty(fila2)&&isempty(fila1)
    error('No existen puntos singulares');
end

fila=[fila1;fila2];
columna=[columna1;columna2];

figure
imshow(Ic1bn);
hold on
plot(columna,fila,'or');

% Calculo de correspondencia entre imagenes
Corresp=[];
npsing=length(fila);
np=4;
for i=1:20
   % Para cada punto singular
   % Calculo SD para un entorno de np cuadrados R en la imagen Ic2 y 
   % me quedo con el minimo
  vsolmin=Inf; 
  vsolposmin=[];
  for j=fila(i)-np:fila(i)+np
      for k=columna(i)-np:columna(i)+np
        % Calculamos SD
        if (j>=1)&&(k>=1)
        vsol=CalculaSD(Ic1bn,Ic2bn,tam,[fila(i),columna(i)],[j,k]);
        if vsol<vsolmin
            vsolmin=vsol;
            vsolposmin=[j,k];
        end
        end
      end
  end
   
  Corresp=[Corresp;fila(i),columna(i),vsolposmin(1),vsolposmin(2)];
   
end

point=30;
figure(11)
subplot(1,2,1)
imshow(Ic1bn);
hold on
plot(Corresp(point,2),Corresp(point,1),'or');
subplot(1,2,2)
imshow(Ic2bn);
hold on
plot(Corresp(point,4),Corresp(point,3),'xr');

% Funcion Corner

meth2='MinimumEigenvalue';
C = corner(Ic1bn);
figure;
imshow(Ic1bn);
hold on
plot(C(:,1), C(:,2), 'r*');

C = corner(Ic1bn,meth2);
figure;
imshow(Ic1bn);
hold on
plot(C(:,1), C(:,2), 'r*');

%% Plano epipolar

for point=1:100

x_1=Corresp(point,2);
x_2=Corresp(point,3);

%Disparidad
d = x_1-x_2;

%Supongo distancia entre planos b=10;
b=100;
%Distancia focal f=3
f=3;

z(point)=(f*b)./d;

end
plot(z)
