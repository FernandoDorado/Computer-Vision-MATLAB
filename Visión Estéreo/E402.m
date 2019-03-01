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
h1 = gscatter(PL,PW,species,'krb','ov^',[],'off');
h1(1).LineWidth = 2;
h1(2).LineWidth = 2;
h1(3).LineWidth = 2;
legend('Setosa','Versicolor','Virginica','Location','best')
hold on

% Se crea el discriminante lineal

X = [PL,PW];
cls = fitcdiscr(X,species);

% Se plotean los discriminantes calculados

% Se obtienen los coeficientes para el discriminante lineal entre las
% clases 2 y 3.

w = cls.Coeffs(2,3).Const; % First retrieve the coefficients for the linear
v = cls.Coeffs(2,3).Linear;% boundary between the second and third classes
                           % (versicolor and virginica).

% Se dibuja la curva  [v1 v2]*[x1,x2]' + w  = 0.

f = @(x1,x2) w + v(1)*x1 + v(2)*x2;

h2 = ezplot(f,[.9 7.1 0 2.5]);  % Version facil del plot
h2.Color = 'r';
h2.LineWidth = 2;

% Discriminante entre la clase 1 y la 2
w2 = cls.Coeffs(1,2).Const;
v2 = cls.Coeffs(1,2).Linear;

% Se vuelve a pintar la curva discriminante [v1 v2]*[x1,x2]' + w  = 0:
f2 = @(x1,x2) w2 + v2(1)*x1 + v2(2)*x2;

h3 = ezplot(f2,[.9 7.1 0 2.5]);
h3.Color = 'k';
h3.LineWidth = 2;
axis([.9 7.1 0 2.5])

xlabel('Caracteristica 1')
ylabel('Caracteristica 2')
title('{\bf Ejemplo de Clasificacion lineal}')

%% Indice de Bondad

c=ones(size(species));
CI=0;

for i=1:length(species)

 fd1=f(X(i,1),X(i,2));   % entre la clase 2 y 3
 fd2=f2(X(i,1),X(i,2));  % entre la clase 1 y 2 
 
 if strcmp(species(i),'setosa')==1
    c(i)=1;
elseif strcmp(species(i),'versicolor')==1
    c(i)=2;
elseif strcmp(species(i),'virginica')==1
    c(i)=3;
end
 
 
 if fd2>0 && fd1>0 % pertenece a la clase 1
   if c(i)~=1
       CI=CI+1;
   end
 elseif fd2<0 && fd1>0 % pertenece a la clase 1
    if c(i)~=2
       CI=CI+1;
   end
 elseif fd2<0 && fd1<0 % pertenece a la clase 3  
    if c(i)~=3
       CI=CI+1;
   end
 end
 
end

PCI=100*(CI/length(species));


%% Discriminante cuadratico

cqs = fitcdiscr(X,species,'DiscrimType','quadratic');

% Borrando los discriminantes lineales
delete(h2); delete(h3) 

% Tomamos la ecuacion cuadratica que separa la clase 2 y 3
K = cqs.Coeffs(2,3).Const;
L = cqs.Coeffs(2,3).Linear;
Q = cqs.Coeffs(2,3).Quadratic;

% Creamos la curva discriminante cuadratica K + [x1,x2]*L + [x1,x2]*Q*[x1,x2]' = 0.
f = @(x1,x2) K + L(1)*x1 + L(2)*x2 + Q(1,1)*x1.^2 + ...
    (Q(1,2)+Q(2,1))*x1.*x2 + Q(2,2)*x2.^2;

h2 = ezplot(f,[.9 7.1 0 2.5]);
h2.Color = 'r';
h2.LineWidth = 2;

% Discriminante entre la clase 1 y 2
K = cqs.Coeffs(1,2).Const;
L = cqs.Coeffs(1,2).Linear;
Q = cqs.Coeffs(1,2).Quadratic;

% Plot the curve K + [x1,x2]*L + [x1,x2]*Q*[x1,x2]'=0:
f = @(x1,x2) K + L(1)*x1 + L(2)*x2 + Q(1,1)*x1.^2 + ...
    (Q(1,2)+Q(2,1))*x1.*x2 + Q(2,2)*x2.^2;
h3 = ezplot(f,[.9 7.1 0 1.02]); % Plot the relevant portion of the curve.
h3.Color = 'k';
h3.LineWidth = 2;
axis([.9 7.1 0 2.5])
xlabel('Petal Length')
ylabel('Petal Width')
title('{\bf Quadratic Classification with Fisher Training Data}')
hold off


