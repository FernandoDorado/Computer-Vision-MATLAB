%% Transformada de Hought
f = imread('cameraman.tif');
plc = edge( f,'canny');
[ H,theta,rho] = hough( plc);               %Theta me indica cuales angulos se han usado para la discretizacion. Idem con "rho"
%Para recta que ha recibido mas votos:
max((H(:))); [F,C]=find(H==110);
picos = houghpeaks(H, 2);                   %Selecciona tantos picos como yo le diga. Si no le indico nada me devuelve cada punto de la matriz h.
selecc = houghlines( plc,theta,rho,picos);  %Estructura con una serie de campos: Point1,point2,theta,rho.
%selecc.point1                               obtengo los puntos de las rectas en pixieles
imshow(plc)
