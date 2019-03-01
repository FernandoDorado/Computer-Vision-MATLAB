%% Ejercicio 1 Ex. Diciembre
% Escriba un programa en MATLAB que:
% A. Lea de disco la imagen en tonos de gris del archivo 'img01.png'
% acomodandola en la variable h.

h=imread('coins.png');

% Obtenga la imagen binaria de la silueta de la imagen almacenada en h y
% almacenala en b utilizando como umbral la intensidad de gris media de la
% mitad inferior h.

[n,m]=size(h);
f=double(h);
cont=0;
for i=floor(n/2):n
    for j=1:m
        cont=cont+f(i,j);
    end
end
total=floor((m*n)/2);
intmedia=cont/total;
b=f>intmedia;

figure
subplot(1,2,1)
imshow(h)
subplot(1,2,2)
imshow(b)


%% Apartado2
% Calcule la imagen binaria de contornos del objeto en h y almacenala en
% bc. Emplear el metodo de Roberts con plantilla:

qx=[0 0 -1;0 1 0; 0 0 0];
qy=[0 0 0;0 1 0; 0 0 -1];
U=70;

Gx=zeros(n,m);
Gy=zeros(n,m);

for i=2:n-1
    for j=2:m-1
        ty=f([i-1,i,i+1],[j-1,j,j+1]);
        Gx(i,j)=sum(sum(qx.*ty));
        Gy(i,j)=sum(sum(qy.*ty));
    end
end

G=sqrt(Gx.^2+Gy.^2);
bc=G>U;

figure
subplot(1,2,1)
imshow(h)
subplot(1,2,2)
imshow(bc)

%% Apartado 3
% Calcula la imagen binaria resultante de la operacion b-(b-q)

q=ones(3);
gi=zeros(n,m);

for i=2:n-1
    for j=2:m-1
        bi=b([i-1:i+1],[j-1:j+1]);
        gi(i,j)=min(min(q.*bi));
    end
end
t=zeros(n,m);
ti=(b-gi);
t(2:n-1,2:m-1)=ti(2:n-1,2:m-1);

figure
subplot(1,2,1)
imshow(h)
subplot(1,2,2)
imshow(t)
