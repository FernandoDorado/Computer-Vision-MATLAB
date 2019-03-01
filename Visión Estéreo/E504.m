
%% Metodo simple para obtener puntos conjugados.
% Dado dos imagenes de la misma imagen

Ic1=double(imread('Catedral1.JPG'));
Ic2=double(imread('Catedral2.JPG'));
Ic2=Ic2(1:size(Ic1,1),1:size(Ic1,2),:);
[Ny,Mx]=size(Ic1(:,:,1));
Tam=floor(round([Ny,Mx]./20)/2);


%% Calculamos las diferencias en valor absoluto para R=S

Res(:,:,1)=zeros(Ny,Mx);
Res(:,:,2)=zeros(Ny,Mx);
Res(:,:,3)=zeros(Ny,Mx);

ResM=zeros(Ny,Mx);
ResMx=zeros(Ny,Mx);
ResMy=zeros(Ny,Mx);

% Para la imagen 1
for i=1+Tam(1):Tam(1):Ny-Tam(1)
    for j=1+Tam(2):Tam(2):Mx-Tam(2)
        
        % Recorremos la imagen 2
        
            for k=1+Tam(1):Tam(1):Ny-Tam(1)
                for l=1+Tam(2):Tam(2):Mx-Tam(2)
        
                    % Recorremos la imagen
                        
                        for s=-Tam(1):Tam(1)
                            for p=-Tam(2):Tam(2)
                                Res(k,l,1)=Res(k,l,1)+abs(Ic1(i+s,j+p,1)-Ic2(k+s,l+p,1));
                                Res(k,l,2)=Res(k,l,2)+abs(Ic1(i+s,j+p,2)-Ic2(k+s,l+p,2));
                                Res(k,l,3)=Res(k,l,3)+abs(Ic1(i+s,j+p,3)-Ic2(k+s,l+p,3));
                                ResM(k,l)=norm([Res(k,l,1) Res(k,l,2) Res(k,l,3)],2);
                            end
                        end
                    
                    
                end
            end
        
           % Asociamos a R(i,j) el S(k,l) mas parecido 
            ResMv=ResM(:);
            ind_to_inf=find(ResMv==0);
            ResMv(ind_to_inf)=Inf;
            valx=min(ResMv);
            %[ResMy(i,j),ResMx(i,j)]=find(ResM==valx);
                       
        
    end
end