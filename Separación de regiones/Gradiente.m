%% Ejemplo Gradiente 

% Lectura de la imagen
forig = imread('coins.png');
f = double(forig);
[M,N] = size (f);

%Valores inciiales
Gx = zeros(M,N);
Gy = zeros(M,N);

%Calculo de la aproximacion discreta del gradiente
for i=2:M
    for j=2:N
        Gx(i,j) = f(i,j) - f(i,j-1);
        Gy(i,j) = f(i,j) - f(i-1,j);
    end
end
imshow(forig)
figure(2);
mesh(Gx);
figure(3);
mesh(Gy);

%% Módulo del gradiente 
close all;
GM = sqrt(Gx.^2 + Gy.^2);
mesh(GM)

%% Imagen binaria de contornos mediante uso de umbral para el modulo del grdiente 
close all;
U = 56;
b = uint8 ( 255*( GM > U ) );
imshow(b);

%% Ejemplo
%doc edge
I = imread('circuit.tif');
imshow(I)
SW1 = edge(I, 'prewitt');
figure;imshow(SW1);title('contornos');
%Estas funciones hace una busqueda de los umbrales mas adecuados.
%Para averiguar el umbral (está escalado);
[BW,U] = edge(I,'Prewitt')

%% doc imgradient
[ModuloGradiente,DireccGradiente] = imgradient(I);
imshowpair(ModuloGradiente, DireccGradiente, 'montage');