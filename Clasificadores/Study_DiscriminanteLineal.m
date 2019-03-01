%% Ejemplo de Clasificacion y funcion de Bondad

close all

% Grupo training para ajuste
x1=[0.5, 2.0, 3.6, 1.2, 3.4, 3.9, 4.2, 4.9, 3.0, 9.0, 7.6, 8.5, 6.9 ];
x2=[1.5, 1.7, 1.0, 0.5, 4.3, 4.2, 4.7, 3.9, 4.1, 8.5, 7.0, 8.2, 8.5 ];
c= [ 1 , 1 , 1, 1, 2 , 2, 2, 2, 2, 3, 3, 3, 3 ];

%% Representación datos
i1 = find(c==1);
i2 = find(c==2);
i3 = find(c==3);

plot(x1(i1),x2(i1),'or');
hold on;
plot(x1(i2),x2(i2),'*b');
hold on;
plot(x1(i3),x2(i3),'sk');
hold on;grid on;
axis([0 10 0 10]);

%% Calculo discriminante
% fd(x) = vx - w

x1d = 0:0.01:10;
fd2 = -1/2*x1d + 4;                    % xd1=(40-2*x1d)/5;
fd1 = -2/5*x1d + 8;                    % xd2=(8-x1d)/2;

plot(x1d,fd1,'-.r',x1d,fd2,'-.b');

%% Chequeo 
D1=[2 5 -40];
D2=[1 2 -8];

cont=0;

for i=1:length(x1)
    checkv1 = D1 * [x1(i);x2(i);1];
    checkv2 = D1 * [x1(i);x2(i);1];

if checkv1<0 && checkv2<0 % Clase1
    plot(x1(i),x2(i),'.g');
    
elseif checkv1>0 && checkv2<0 % Clase 2
    plot(x1(i),x2(i),'.b');
    
elseif checkv1>0 && checkv2>0 % Clase 3
    
    plot(x1(i),x2(i),'.r');
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



