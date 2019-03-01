% Añada en el hueco el cogido MATLAB que se requiere para clasificar la
% forma de la region indicada por p. Se usara un clasificador de Bayes para
% decidir si la region pertenece a las clases ci=1,2,3. Se tiene que:

% Imagen f dada
f=imread('coins.png');

[n,m]=size(f);

P1=[20;0.5;2];
P2=[50;2;0.1];
P3=[30;2;1.5];

p=f>40;
Pc1=0.5;
Pc2=0.3;
Pc3=0.2;

m00=0;
m30=0;
m10=0;
m01=0;
mu20=0;
mu03=0;

for i=1:n
    for j=1:m
       m00=m00+p(i,j); 
       m10=m10+p(i,j)*i;
       m01=m01+p(i,j)*j;
       m30=m30+p(i,j)*(i^3);
    end
end

% centro de gravedad

ig=m10/m00;
jg=m01/m00;

for i=1:n
    for j=1:m
       mu20=mu20+p(i,j)*((i-ig)^2);
       mu03=mu03+p(i,j)*((j-jg)^3);
    end
end


xo=[mu20/m00^2 mu03/m00^2 m30/m00^3]';

% Probabilidades condicionales

dP1=norm(xo-P1,2);
dP2=norm(xo-P2,2);
dP3=norm(xo-P3,2);
dtotal=dP1+dP2+dP3;

[val,clase]=min([dP1 dP2 dP3])
%%

Pcond1=dP1/dtotal;
Pcond2=dP2/dtotal;
Pcond3=dP3/dtotal;

Px=Pcond1*Pc1+Pcond2*Pc2+Pcond3*Pc3;

Pcn1=Pcond1*Pc1/Px;
Pcn2=Pcond2*Pc2/Px;
Pcn3=Pcond3*Pc3/Px;

[val,clase]=max([Pcn1 Pcn2 Pcn3]);

