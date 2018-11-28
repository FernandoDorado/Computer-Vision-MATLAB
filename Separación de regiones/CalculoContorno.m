%% Calculo contorno
imagen = uint8(zeros(10,10));
f = double(imagen);
f(5,10) = 255; f(5,11) = 255; f(5,12) = 255; f(5,13) = 255; f(6,13) = 255;
f(6,14) = 255; f(7,14) = 255; f(8,14) = 255; f(8,14) = 255; f(8,13) = 255;
f(8,12) = 255; f(8,11) = 255; f(8,10) = 255; f(7,10) = 255; f(6,10) = 255;
[M,N] = size(f);
imshow(f);

%busqueda punto inicial
for i=1:M
    for j=1:N
        if f(i,j)>0
            i_ini = i;
            j_ini = j;
            break;
        end
    end
    if i_ini>0, break; end
end

for k=1:M
    switch (cadena(k))
        case 0
            ic = ic_ant;
            jc = jc_ant + 1;
        case 1
            ic = ic_ant - 1;
            jc = jc_ant;
        case 2
            ic = ic_ant;
            jc = jc_ant - 1;
        case 3
            ic = ic_ant + 1;
            jc = jc_ant;
    end
    cont(ic,jc) = 1;
    ic_ant = ic; %actualizo valores anteriores
    jc_ant = jc;
end 

micont = uint8(255*cont);
subplot(1,3,2)
imshow(micont)
title('Contorno realizado con cadena')