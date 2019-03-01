clear all;close all;
load fisheriris

%meas: empleamos 4 caracteristicas
%species: vector de clases. Hay 3 clases

PL = meas(:,3);
PW = meas(:,4);

%% Calculamos prototipos 
P1_PL=0; P1_PW=0;
P2_PL=0; P2_PW=0;
P3_PL=0; P3_PW=0;
n1=0; n2=0; n3=0;


for i=1:length(species)
    if strcmp(species(i),'setosa') == 1
        c(i) = 1;
        P1_PL = P1_PL + PL(i);
        P1_PW = P1_PW + PW(i);
        n1 = n1 + 1;
    elseif strcmp(species(i),'versicolor') == 1
        c(i) = 2;
        P2_PL = P2_PL + PL(i);
        P2_PW = P2_PW + PW(i);
        n2 = n2 + 1;
   elseif strcmp(species(i),'virginica') == 1
        c(i) = 3;
        P3_PL = P3_PL + PL(i);
        P3_PW = P3_PW + PW(i);
        n3 = n3 + 1;
    end
end


P1_PL=P1_PL/n1;
P1_PW=P1_PW/n1;
P2_PL=P2_PL/n2;
P2_PW=P2_PW/n2;
P3_PL=P3_PL/n3;
P3_PW=P3_PW/n3;

%% Nos quedamos con las dos ultimas características para la representación

figure
h1 = gscatter(PL,PW,species,'krb','ov^',[],'off');
h1(1).LineWidth = 2;
h1(2).LineWidth = 2;
h1(3).LineWidth = 2;
legend('Setosa','Versicolor','Virginica','Location','best')
hold on

plot(P1_PL,P1_PW,'xm','LineWidth',3);
plot(P2_PL,P2_PW,'xm','LineWidth',3);
plot(P3_PL,P3_PW,'xm','LineWidth',3);

%% Montamos discriminantes

f1 = @(x1,x2) sqrt((x1-P1_PL).^2 + (x2-P1_PW).^2);
f2 = @(x1,x2) sqrt((x1-P2_PL).^2 + (x2-P2_PW).^2);
f3 = @(x1,x2) sqrt((x1-P3_PL).^2 + (x2-P3_PW).^2);

speciesnew=species;

[value,clas] = min([f1(PL,PW) f2(PL,PW) f3(PL,PW)],[],2);

for i=1:length(species)
 
if clas(i)==1
    speciesnew{i}='setosa';
elseif clas(i)==2
    speciesnew{i}='versicolor';
elseif clas(i)==3
    speciesnew{i}='virginica';
end

end

figure
h2 = gscatter(PL,PW,speciesnew,'krb','ov^',[],'off');
h2(1).LineWidth = 2;
h2(2).LineWidth = 2;
h2(3).LineWidth = 2;
legend('Setosa','Versicolor','Virginica','Location','best')
axis([.9 7.1 0 2.5])

xlabel('Caracteristica 1')
ylabel('Caracteristica 2')
title('{\bf Ejemplo de Clasificacion lineal}')




   