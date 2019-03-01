% Mapeo

theta=1:360;
rho=10*rand(1,360);

% construccion del mapeo

X=rho.*sin(theta*(pi/180));
Y=rho.*cos(theta*(pi/180));

plot(X,Y)