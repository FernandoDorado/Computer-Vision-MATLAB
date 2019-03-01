%% Problema completo de Reconstrucion por vision esterio
clear all
close all
%% Correspondencia entre puntos

Ic1=double(imread('Catedral1.JPG'));
Ic2=double(imread('Catedral2.JPG'));

Ic2=Ic2(1:size(Ic1,1),1:size(Ic1,2),:);

[Ny,Mx]=size(Ic1(:,:,1));

figure
subplot(1,2,1)
imshow(uint8(Ic1));
subplot(1,2,2)
imshow(uint8(Ic2));

% Busqueda de puntos singulares para la imagen 1

[Ixr, Iyr] = imgradientxy(Ic1(:,:,1),'sobel');
[Ixg, Iyg] = imgradientxy(Ic1(:,:,2),'sobel');
[Ixa, Iya] = imgradientxy(Ic1(:,:,3),'sobel');

Autoval1r=zeros(Ny,Mx);
Autoval2r=zeros(Ny,Mx);
Autoval1g=zeros(Ny,Mx);
Autoval2g=zeros(Ny,Mx);
Autoval1a=zeros(Ny,Mx);
Autoval2a=zeros(Ny,Mx);

for i=1:Ny
    for j=1:Mx
        % Montamos el tensor por cada punto de la imagen
        eigvalr=eig([Ixr(i,j)^2 Ixr(i,j)*Iyr(i,j);Iyr(i,j)*Ixr(i,j) Iyr(i,j)^2]);
        eigvalg=eig([Ixg(i,j)^2 Ixg(i,j)*Iyg(i,j);Iyg(i,j)*Ixg(i,j) Iyg(i,j)^2]);
        eigvala=eig([Ixa(i,j)^2 Ixa(i,j)*Iya(i,j);Iya(i,j)*Ixa(i,j) Iya(i,j)^2]);
        Autoval1r(i,j)=eigvalr(1);
        Autoval2r(i,j)=eigvalr(2);
        Autoval1g(i,j)=eigvalg(1);
        Autoval2g(i,j)=eigvalg(2);
        Autoval1a(i,j)=eigvala(1);
        Autoval2a(i,j)=eigvala(2);
    end
end

clear fila columna

% buscamos puntos singulares
for j=1:3
 
    clear fila2 columna2 fila1 columna1
 
    if j==1   
        [fila2{j},columna2{j}]=find(Autoval2r>1e5);
        [fila1{j},columna1{j}]=find(Autoval1r>1e5);
 elseif j==2
        [fila2{j},columna2{j}]=find(Autoval2g>1e5);
        [fila1{j},columna1{j}]=find(Autoval1g>1e5);     
 elseif j==3
        [fila2{j},columna2{j}]=find(Autoval2a>1e5);
        [fila1{j},columna1{j}]=find(Autoval1a>1e5);       
    end
 
if isempty(fila2{j})&&isempty(fila1{j})
    error('No existen puntos singulares');
end

fila{j}=[fila1{j};fila2{j}];
columna{j}=[columna1{j};columna2{j}];

end

filaim1=fila;
columnaim1=columna;

figure
subplot(1,3,1)
imshow(uint8(Ic1));
hold on
plot(columna{1},fila{1},'or');
title('rojo');
subplot(1,3,2)
imshow(uint8(Ic1));
hold on
plot(columna{2},fila{2},'or');
title('verde');
subplot(1,3,3)
imshow(uint8(Ic1));
hold on
plot(columna{3},fila{3},'or');
title('azul');

% Busqueda de puntos singulares para la imagen 2

[Ixr, Iyr] = imgradientxy(Ic2(:,:,1),'sobel');
[Ixg, Iyg] = imgradientxy(Ic2(:,:,2),'sobel');
[Ixa, Iya] = imgradientxy(Ic2(:,:,3),'sobel');

Autoval1r=zeros(Ny,Mx);
Autoval2r=zeros(Ny,Mx);
Autoval1g=zeros(Ny,Mx);
Autoval2g=zeros(Ny,Mx);
Autoval1a=zeros(Ny,Mx);
Autoval2a=zeros(Ny,Mx);

for i=1:Ny
    for j=1:Mx
        % Montamos el tensor por cada punto de la imagen
        eigvalr=eig([Ixr(i,j)^2 Ixr(i,j)*Iyr(i,j);Iyr(i,j)*Ixr(i,j) Iyr(i,j)^2]);
        eigvalg=eig([Ixg(i,j)^2 Ixg(i,j)*Iyg(i,j);Iyg(i,j)*Ixg(i,j) Iyg(i,j)^2]);
        eigvala=eig([Ixa(i,j)^2 Ixa(i,j)*Iya(i,j);Iya(i,j)*Ixa(i,j) Iya(i,j)^2]);
        Autoval1r(i,j)=eigvalr(1);
        Autoval2r(i,j)=eigvalr(2);
        Autoval1g(i,j)=eigvalg(1);
        Autoval2g(i,j)=eigvalg(2);
        Autoval1a(i,j)=eigvala(1);
        Autoval2a(i,j)=eigvala(2);
    end
end

clear fila columna

% buscamos puntos singulares
for j=1:3
 
    clear fila2 columna2 fila1 columna1
 
    if j==1   
        [fila2{j},columna2{j}]=find(Autoval2r>1e5);
        [fila1{j},columna1{j}]=find(Autoval1r>1e5);
 elseif j==2
        [fila2{j},columna2{j}]=find(Autoval2g>1e5);
        [fila1{j},columna1{j}]=find(Autoval1g>1e5);     
 elseif j==3
        [fila2{j},columna2{j}]=find(Autoval2a>1e5);
        [fila1{j},columna1{j}]=find(Autoval1a>1e5);       
    end
 
if isempty(fila2{j})&&isempty(fila1{j})
    error('No existen puntos singulares');
end

fila{j}=[fila1{j};fila2{j}];
columna{j}=[columna1{j};columna2{j}];

end

figure
subplot(1,3,1)
imshow(uint8(Ic2));
hold on
plot(columna{1},fila{1},'or');
title('rojo');
subplot(1,3,2)
imshow(uint8(Ic2));
hold on
plot(columna{2},fila{2},'or');
title('verde');
subplot(1,3,3)
imshow(uint8(Ic2));
hold on
plot(columna{3},fila{3},'or');
title('azul');

filaim2=fila;
columnaim2=columna;

%% Eliminamos puntos singulares con valor igual a la unidad

for i=1:3
   filaim1ind{i}=find(filaim1{i}>1);
   columnaim1ind{i}=find(columnaim1{i}>1);
   filaim2ind{i}=find(filaim2{i}>1);
   columnaim2ind{i}=find(columnaim2{i}>1);  
   
   filaim1{i}=filaim1{i}(filaim1ind{i});
   filaim2{i}=filaim2{i}(filaim2ind{i});
   columnaim1{i}=columnaim1{i}(columnaim1ind{i});
   columnaim2{i}=columnaim2{i}(columnaim2ind{i});
   
end

for i=1:3
   filaim1ind{i}=find(filaim1{i}<Mx);
   columnaim1ind{i}=find(columnaim1{i}<Ny);
   filaim2ind{i}=find(filaim2{i}<Mx);
   columnaim2ind{i}=find(columnaim2{i}<Ny);  
   
   filaim1{i}=filaim1{i}(filaim1ind{i});
   filaim2{i}=filaim2{i}(filaim2ind{i});
   columnaim1{i}=columnaim1{i}(columnaim1ind{i});
   columnaim2{i}=columnaim2{i}(columnaim2ind{i});
   
end


%% correspondencia
Corresp=[];
k=1;

for i=1:length(filaim1{k})
       
        % Por cada punto singular de la imagen 1
        R=Ic1(columnaim1{k}(i)-1:columnaim1{k}(i)+1,filaim1{k}(i)-1:filaim1{k}(i)+1,k);
        c1=R(:);
        c1=c1/norm(c1,2);
        indj=[];
        
        for j=1:length(filaim2{k})
            
            
                % buscamos un punto singular de la imagen 2 correspondiente
                S=Ic2(columnaim2{k}(j)-1:columnaim2{k}(j)+1,filaim2{k}(j)-1:filaim2{k}(j)+1,k);
                c2=S(:);c2=c2/norm(c2,2);
                
                if c1'*c2>=0.8
                    indj=[indj;[j c1'*c2]];
                end
                
           
        end
        
        [val,inddj]=max(indj(:,2));
        Corresp=[Corresp;[filaim1{k}(i) columnaim1{k}(i) filaim2{k}(indj(inddj,1)) columnaim2{k}(indj(inddj,1))]];
        
        % chequeo de correspondencia
        
%         figure
%         subplot(1,2,1)
%         imshow(uint8(Ic1));
%         hold on
%         plot(columnaim1{k}(i),filaim1{k}(i),'or');
%         subplot(1,2,2)
%         imshow(uint8(Ic2));
%         hold on
%         plot(columnaim2{k}(indj(inddj,1)),filaim2{k}(indj(inddj,1)),'or');
        
end


%% Etapa de validacion de puntos conjugados




%% Reconstruccion 3-D simplificada (solo calculo de profundidad)

f=0.03;     % Distancia focal
b=0.25;     % distancia entre centros.
dpix=3e-3;
% Calculamos la disparidad por puntos conjugados

disparidad=double(Corresp(:,2))-double(Corresp(:,4));

profund=f*b./(disparidad.*dpix);








