clear all;close all;
load fisheriris

%meas: empleamos 4 caracteristicas
%species: vector de clases. Hay 3 clases

clear all
close all

load fisheriris

% meas : medidas o caractetisticas : se emplean 4 caracteristicas
% species : vector de clases : Hay 3 clases
% Cargamos una base de datos

PL = meas(:,3);
PW = meas(:,4);

% Nos quedamos con las dos ultimas  caracteristicas para la representacion
% Se emplea un  plot tipo scatter para representarlo
figure
h1 = gscatter(PL,PW,species);hold on;
X=[PL,PW];
cls = fitcdiscr(X,species);

w2 = cls.Coeffs(2,3).Const;
v2 = cls.Coeffs(2,3).Linear;

w = cls.Coeffs(1,2).Const;
v = cls.Coeffs(1,2).Linear;


%d1
f = @(x1,x2) v(1)*x1 + v(2)*x2 + w;
f2 = @(x1,x2) v2(1)*x1 + v2(2)*x2 + w2;

ezplot(f);hold on;ezplot(f2);

%% Indice de bondad

c = ones(size(species));
CI = 0;

for i=1:length(species)
    fd1 = f(X(i,1),X(i,2));
    fd2 = f2(X(i,1),X(i,2));
    
    if strcmp(species(i),'setosa')==1
    c(i)=1;
    elseif strcmp(species(i),'versicolor')==1
    c(i)=2;
    elseif strcmp(species(i),'virginica')==1
    c(i)=3;
    end
    
    if fd2>0 && fd1>0 
        if(c(i)~=1)
            CI = CI+1;
        end
    elseif fd2>0 && fd1 <0
        if (c(i) ~= 2)
            CI = CI+1;
        end
        
    elseif fd2<0 && fd1 <0
        if (c(i) ~= 3)
            CI = CI+1;
        end
    end
end

BONDAD = 100*(CI/length(species))
            



