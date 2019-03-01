% Ejemplo de Examen 17-18
clear all;close all;
%% Enunciado:
% El programa esta sin terminar. Añada en el hueco el codigo de matlab que
% se requiere para clasificar la forma de la region indicada por p. Para
% ello usara un clasificador de minima distancia con los prototipos P1,P2 y
% P3. El vector de caracteristicas es x=[alpha beta gamma]', siendo
% alpha=u20/m00^2, beta=u03/X y gamma=m30/Y donde [X,Y] son las dimensiones
% horizontal y vertical de la caja contenedora de la region, es decir, el
% menor paralelepipedo que contiene completamente la region.

%% Proporcionamos f
A = imread('ngc6543a.jpg');
Abn = rgb2gray(A(1:530,1:599,:));
Umbral=graythresh(Abn);
f=im2bw(Abn,Umbral);
figure
imshow(f)
%--------------------------------------------------------
% Imagen f dada
[M,N]= size(f);
P1=[20;0.5;2];
P2=[50;2;0.1];
P3=[30;2;1.5];



%% CODIGO A AÑADIR
p=f;
% Se calculan los momentos m00 y m30
% momento m30
m30=0;
m00=0;
m10=0;
m01=0;

for i=1:size(p,1)
    for j=1:size(p,2)
   
        m30=m30+(i^3)*(j^0)*p(i,j);
        m00=m00+(i^0)*(j^0)*p(i,j);
        m10=m10+(i^1)*(j^0)*p(i,j);
        m01=m01+(i^0)*(j^1)*p(i,j);
        
    end
end

% Se calculan los momentos centrales u20 u03

% Centro de gravedad

iG=m10/m00;
jG=m01/m00;

% momento u20
u20=0;
u03=0;
r=2;
s=0;
for i=1:size(p,1)
    for j=1:size(p,2)
   
        u20=u20+((i-iG)^2)*((j-jG)^0)*p(i,j);
        u03=u03+((i-iG)^0)*((j-jG)^3)*p(i,j);
        
    end
end

%% Calculamos el paralepipedo
% Calculamos X e Y
v=[];
for i=1:size(p,1)
ind=find(p(i,:)==1);
if isempty(ind)==0
v=[v;[min(ind),max(ind)]];
end

end

X=max(v(:,2))-min(v(:,1));

v=[];
for i=1:size(p,2)
ind=find(p(:,i)==1);
if isempty(ind)==0
v=[v;[min(ind),max(ind),i]];
end
end

Y=max(v(:,2))-min(v(:,1));


% Construimos la caracteristica x

Xc=[u20/m00^2, u03/X ,m30/Y]';

dist=[norm(Xc-P1,2);norm(Xc-P2,2);norm(Xc-P3,2)];

[val,claseasig]=min(dist);

%% FIN DE CODIGO A AÑADIR

disp('La clase asignada es ');
disp(claseasig);