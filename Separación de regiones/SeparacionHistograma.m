%% Separación por histograma. 
%Intentamos aprovechar la diferencia en instensidad de un bojeto frente al
%fondo. Seleccionamos un umbral con la función graythresh. 

f = imread('coins.png');
umbral = graythresh(f);    %Umbral optimo de Otsu
%Es importante saber que la función graythresh devuelve un umbral escalado,
%es decir, este valor habrá que mutiplicarlo por 255

%plant = im2bw( f,umbral);   %plantilla de pertenencia
plant = f>umbral*255;   %plantilla de pertenencia sin usar im2bw
%mira valor a valor la imagen f y la compara con el umbral, devolviendo un
%1 en caso de que f sea mayor y un 0 en caso contrario

g = uint8(255*plant);  %imagen de silueta

h = uint8(double(f).*plant); %la imagen se multiplica por la plantilla, 
%por tanto, aquellos pixeles que en la plantilla tengan un 1 conservan su
%intensidad luminica, mientras que los que tengan un 0 la pierden.
imshow([f, g, h])