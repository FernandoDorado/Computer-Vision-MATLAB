close all
clear all

%% Calculo de la Radiancia espectral

h = 6.626068e-34;                   % Units are m^2 kg / s
c=299792458;                        % velocidad de la luz (m/s) 
k=1.3806488e-23;                    % constante de boltzman   


Ird = @(T,delta) (2.*h.*c^2./(delta.^5)).*(1./(-1+exp(h.*c./(delta.*k.*T))));

%plot(273:10:2000,Ird(273:10:2000,1000e-9))


%% Tabla para radiancia entre [10,200]
T1=30;
T2=60;

IRIm=imread('Catedral1.JPG');
imshow(IRIm)

[N,M]=size(IRIm(:,:,1));
IRIT=zeros(N,M);
for i=1:N
    for j=1:M
       IRIT(i,j)=ColorVirtual(IRIm(i,j,1),IRIm(i,j,2),IRIm(i,j,3));
    end 
end
figure(2)
imshow(IRIT)

% calculamos las zonas que no cumplen

f1=IRIT<T1;
f2=IRIT>T2;

%% Caso 3
IRIg=rgb2gray(IRIm);
Isc=IRIg>100;
figure()
imshow(Isc)



















