tic
close all;clear all;
f=imread('I1.JPG');
g=imread('I2.png');

imshow(f);
figure;
imshow(g);

%% Correspondencia entre puntos

Ic1 = double(imread('I1.JPG'));
Ic2 = double(imread('I2.png')); %%lectura y carga de las imagenes

Ic2=Ic2(1:size(Ic1,1), 1:size(Ic1,2),:); % ajustar tamañas de ambas imagenes

[Ny,Mx]=size(Ic1(:,:,1));

tam=floor(round([Ny,Mx]./20)/2); 
% Con round redondeamos el número al entero más proximo
% Con floor lo redondeamos al entero  menor o igual más cercano

%Se pasa a gris para manejar una matriz solamente
Ic1bn=rgb2gray(uint8(Ic1));
Ic2bn=rgb2gray(uint8(Ic2));

figure;
imshow(Ic1bn);
figure;
imshow(Ic2bn);

%% Detector de puntos singulares

% Se calculan los gradientes
[Ix,Iy] = imgradientxy(Ic1bn,'prewitt');

figure;imshowpair(Ix,Iy,'montage');
title('Gradiente direccional: direccion x, Ix(Izq), direccion y, Iy(dcha), Prewitt');
axis off;

Autoval1=zeros(Ny,Mx);
Autoval2=zeros(Ny,Mx);

for i=1:Ny
  for  j=1:Mx
    %Montamos el tensor T para cada i j
    
    T = [Ix(i,j)^2 Ix(i,j)*Iy(i,j); Ix(i,j)*Iy(i,j) Iy(i,j)^2];
    eigval = eig(T);    %Produce los eigenvalores de la matriz T
    Autoval1(i,j)=eigval(1);
    Autoval1(i,j)=eigval(2);
   end
end

% Buscar puntos singulares

[fila1,columna1]=find(Autoval1 > 1e5);
[fila2,columna2]=find(Autoval2 > 1e5);

% Para asegurarnos de que no sale ningun elemento vacio en el find
if isempty(fila1)&&isempty(fila2)
    error('No existen puntos singulares que cumplan con el umbral dado');
end

fila = [fila1;fila2];
columna = [columna1;columna2];

figure
imshow(Ic1bn);
hold on;
plot(columna,fila,'ro');

%% Usando la funcion Corner

meth2 = 'MinimumEigenvalue';

% Por defecto usa el metodo de harris

C = corner(Ic1bn); 
figure;
imshow(Ic1bn);
hold on;
plot (C(:,1),C(:,2),'r*');

% Metodo minimo eigenvalor

C = corner(Ic1bn,meth2); 
figure;
imshow(Ic1bn);
hold on;
plot (C(:,1),C(:,2),'b*');


%% Calculo de correspondencia entre imagenes

Corresp=[];
npsing=length(fila);
np=4; %Decidir cuantos puntos alrededor del pto singular para localizar
      %al otro pto singular en la otra imagen
vsol=[];
vsolmin=[];
vsolposmin=[];

for j=fila(i)-np:fila(i)+np
    for k=columna(i)-np:columna(i)+np
        % calculo de sd
        if (j>=1)&&(k>=1)
            vsol=CalculaSD(Ic1bn,Ic2bn,tam,[fila(i),columna(i)],[j,k]);
        if vsol < vsolmin
            vsolmin=vsol;
            vsolposmin=[j,k];
        end
        end
    end
end

toc