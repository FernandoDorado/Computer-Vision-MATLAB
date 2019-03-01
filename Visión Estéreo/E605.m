XC=imread('Rectcirculo.jpg');
BW=rgb2gray(XC);
figure
imshow(BW)

mBW=BW<100;
figure
imshow(mBW);

pA=[mBW(1:200,:);zeros(size(mBW,1)-200,size(mBW,2))];
pB=[zeros(200,size(mBW,2));mBW(201:end,:)];

figure
subplot(1,2,1)
imshow(pA);
title('pA');
subplot(1,2,2)
imshow(pB);
title('pB');

%% Calculamos cual es un cuadrado y cual es una circunferencia
%  Identificar el rectangulo y el circulo de cada plantilla de pertenencia

% Calculamos mu02 para plantilla A
p=pA;
[n,m]=size(p);

m00A=0;
m10A=0;
m01A=0;
mu20A=0;
mu02A=0;

for i=1:n
    for j=1:m
       m00A=m00A+p(i,j); 
       m10A=m10A+p(i,j)*i;
       m01A=m01A+p(i,j)*j;
    end
end

% centro de gravedad

igA=m10A/m00A;
jgA=m01A/m00A;

for i=1:n
    for j=1:m
       mu20A=mu20A+p(i,j)*((i-igA)^2);
       mu02A=mu02A+p(i,j)*((j-jgA)^2);
    end
end

% Calculamos mu02 para plantilla B
p=pB;
m00B=0;
m10B=0;
m01B=0;
mu20B=0;
mu02B=0;

for i=1:n
    for j=1:m
       m00B=m00B+p(i,j); 
       m10B=m10B+p(i,j)*i;
       m01B=m01B+p(i,j)*j;
    end
end

% centro de gravedad

igB=m10B/m00B;
jgB=m01B/m00B;

for i=1:n
    for j=1:m
       mu20B=mu20B+p(i,j)*((i-igB)^2);
       mu02B=mu02B+p(i,j)*((j-jgB)^2);
    end
end


dA=abs(mu02A-mu20A);
dB=abs(mu02B-mu20B);

figure
subplot(1,2,1)
imshow(pA);
hold on
plot(jgA,igA,'*r');
title(['pA mu02=',num2str(mu02A/1e6),' mu20=',num2str(mu20A/1e6)]);
subplot(1,2,2)
imshow(pB);
hold on
plot(jgB,igB,'*r');
title(['pB mu02=',num2str(mu02B/1e6),' mu20=',num2str(mu20B/1e6)]);


if dA>dB 
    disp('pA es un rectangulo');
else
    disp('pA es un circulo');
end


    

