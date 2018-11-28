%% Laplaciana
%paso por cero: Si L1L2<0. Cruce por 0 ahi, donde L = f*p

f = imread('coins.png');
[M,N]=size(f);
L= zeros(M,N);
U=1900; %UMBRAL DE CRUCES POR 0
h=double(f);
pL=[0 -1 0;-1 4 -1;0 -1 0];

for i=2:M-1
    for j=2:N-1
        L(i,j)=...
        pL(1,1)*h(i-1,j-1)*pL(1,2)*h(i-1,j)*pL(1,3)*h(i-1,j+1)+...
        pL(2,1)*h(i  ,j-1)*pL(2,2)*h(1  ,j)*pL(2,3)*h(i  ,j+1)+...
        pL(3,1)*h(i+1,j-1)*pL(3,2)*h(i+1,j)*pL(3,3)*h(i+1,j+1);
    end
end

b= uint8(zeros(M,N));
for i=2:M-1
    for j=2:N-1
       L1 = L(i,j); L2=L(i-1,j); L3=L(i,j-1);
       if((L1*L2<-U) | (L1*L3<-U))
         b(i,j)=255;
       end
    end
end


imshow(b);
%deteccion de cruces por 0