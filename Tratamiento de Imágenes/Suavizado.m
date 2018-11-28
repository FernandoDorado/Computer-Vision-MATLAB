f = imread ('cameraman.tif');
imshow(f)

% Ejemplo de suavizado : Procedimiento para homogeneizar la imagen para eliminar ruido
h = double(f);
[M,N] = size(f);
%No debo hacer operaciones en uint8
%Con h se hacen las operaciones de suavizado. El resultado se convierte a
%uint8
for i=2:M-1
    for j=2:N-1
    g( i,j) = uint8( (...
    h( i-1, j-1)+ h( i-1, j)+ h( i-1, j+1) + ...
    h( i , j-1)+ h( i , j)+ h( i , j+1) + ...
    h( i+1, j-1)+ h( i+1, j)+ h( i+1, j+1) )/9 );
    end
end
imshow(g)