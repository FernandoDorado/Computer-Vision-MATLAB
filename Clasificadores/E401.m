%% Ejemplo de Clasificacion y funcion de Bondad

close all
% Grupo training para ajuste

x1=[0.5, 2.0, 3.6, 1.2, 3.4, 3.9, 4.2, 4.9, 3.0, 9.0, 7.6, 8.5, 6.9 ];
x2=[1.5, 1.7, 1.0, 0.5, 4.3, 4.2, 4.7, 3.9, 4.1, 8.5, 7.0, 8.2, 8.5 ];
c= [ 1 , 1 , 1, 1, 2 , 2, 2, 2, 2, 3, 3, 3, 3 ];

%% Representacion de datos
figure;
title('Clasificacion Ejemplo 1')
ind1=find(c==1)
plot(x1(ind1),x2(ind1),'or');
hold on
ind2=find(c==2)
plot(x1(ind2),x2(ind2),'*b');
ind3=find(c==3)
plot(x1(ind3),x2(ind3),'sk');
grid on
axis([0 10 0 10]);

%% Calculo del discriminante

x1d=0:0.01:10;

xd1=(40-2*x1d)/5;
xd2=(8-x1d)/2;


plot(x1d,xd1,'-.r',x1d,xd2,'-.b');

%% Chequeo de puntos con Discriminantes

D1=[2 5 -40];
D2=[1 2 -8];

for i=1:length(x1)
checkv1=D1*[x1(i) x2(i) 1]'; % linea superior
checkv2=D2*[x1(i) x2(i) 1]'; % linea inferior

if checkv1<0 && checkv2<0  % clase 1
    plot(x1(i),x2(i),'.g');
elseif  checkv1<0 && checkv2>0  % clase 2
    plot(x1(i),x2(i),'.g');
elseif  checkv1>0 && checkv2>0  % clase 3
    plot(x1(i),x2(i),'.g');
end

end

%% Indice de Bondad

x1o=[6, 7, 6, 6, 2, 3, 4, 6, 5];
x2o=[2, 2, 8, 6, 8, 1, 6, 9, 5];
co =[1, 2, 3, 2, 3, 1, 2, 3, 2];
cc = ones(size(co));
CI=0;

% Calculamos la clasificacion mediante los discriminantes

for i=1:length(x1o)
checkv1=D1*[x1o(i) x2o(i) 1]'; % linea superior
checkv2=D2*[x1o(i) x2o(i) 1]'; % linea inferior

if checkv1<0 && checkv2<0       % clase 1
    plot(x1o(i),x2o(i),'om');
    cc(i)=1;
elseif  checkv1<0 && checkv2>0  % clase 2
    plot(x1o(i),x2o(i),'*m');
    cc(i)=2;
elseif  checkv1>0 && checkv2>0  % clase 3
    plot(x1o(i),x2o(i),'sm');
    cc(i)=3;
end

if cc(i)~=co(i)
    CI=CI+1;
end

end

PCI=100*(CI/length(x1o));





