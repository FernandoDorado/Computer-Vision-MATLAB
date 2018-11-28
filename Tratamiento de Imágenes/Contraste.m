%%  Cambio de contraste
%Le quito brillo a los píxeles que menos intensidad luminosa tiene y le aumento
%brillo a los que mas intensidad tienen.
f = imread ('pout.tif');
[M,N] = size(f);
for i=1:M
    for j=1:N
    orig = double(f(i,j));
    resu = 255*(1/(1+exp(-0.045*(orig-127))));
    g(i,j) = uint8(resu);
    end
end
%Visualizacion antes y despues del cambio
close all; figure;imshow([f,g])
figure
subplot(2,1,1);imhist(f);subplot(2,1,2);imhist(g);