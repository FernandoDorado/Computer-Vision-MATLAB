%% Métodos morfológicos
close all;
%Ejemplo erosión
forig = imread('coins.png');
umbral = 115;
plant=double(forig)>umbral;
f=uint8(255*plant);  %imagen de silueta
imshow(f);title('Silueta antes de erosión');

%Erosion con pplantilla p
p=[0 1 0;1 1 1;0 1 0];
[M,N]=size(f);

%valor inicial
g=uint8(zeros(M,N));
for i=2:M-1
    for j=2:N-1
        cont=0; %contador de elementos en el vector
        for di=-1:1
            for dj=-1:1
                if(p(2+di,2+dj)>0)
                    cont=cont+1;
                    vector_de_elementos(cont)=f(i+di,j+dj);
                end
            end
        end
        g(i,j)=min(vector_de_elementos);
    end
end

figure;imshow(g);