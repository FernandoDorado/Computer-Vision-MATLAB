
% Suponemos datos

theta=1:360;
rho=10*rand(1,360);

% Pasamos a polares

X=rho.*sin(theta*pi/180);
Y=rho.*cos(theta*pi/180);

plot(X,Y);