clear all; close all;
tic
%% Obtención puntos conjugados 
Ic1=double(imread('Catedral1.JPG'));
Ic2=double(imread('Catedral2.JPG'));

Ic2=Ic2(1:size(Ic1,1),1:size(Ic1,2),:);

[Ny,Mx]=size(Ic1(:,:,1));

tam = floor(round([Ny,Mx]./20)./2);

Ic1bn=rgb2gray(uint8(Ic1));
Ic2bn=rgb2gray(uint8(Ic2));


        
%% 

[Ix,Iy]=imgradientxy(Ic1bn,'prewitt');

Autoval1=zeros(Ny,Mx);
Autoval2=zeros(Ny,Mx);

for i=1:Ny
    for j=1:Mx
        %Montamos el tensor
        eigval=eig([Ix(i,j)^2 Ix(i,j)*Iy(i,j);Iy(i,j)*Ix(i,j) Iy(i,j)^2]);
        Autoval1(i,j)=eigval(1);
        Autoval2(i,j)=eigval(2);
    end
end

[fil1,col1]=find(Autoval1>1e5);
[fil2,col2]=find(Autoval2>1e5);

fil = [fil1;fil2]; col = [col1;col2];

% Ya tenemos puntos singulares

%% Corresp
np=4;
Corresp=[];

for i=1:20
    vsolmin=Inf;
    vsolposmin=[];
    
    for j=fil(i)-np:fil(i)+np
        for k=col(i)-np:col(i)+np
            if(j>=1)&&(k>=1)
                vsol=CalculaSD(Ic1bn,Ic2bn,tam,[fil(i),col(i)],[j,k]);
                if(vsol<vsolmin)
                    vsolmin = vsol;
                    vsolposmin=[j,k];
                end
            end
        end
    end
    Corresp=[Corresp;fil(i),col(i),vsolposmin(1),vsolposmin(2)];
end

point=30;
figure(11)
subplot(1,2,1)
imshow(Ic1bn);
hold on
plot(Corresp(point,2),Corresp(point,1),'or');
subplot(1,2,2)
imshow(Ic2bn);
hold on
plot(Corresp(point,4),Corresp(point,3),'xr');



        
        