close all;clear all;

%% Elementos y clase
x1=[0.5, 2.0, 3.6, 1.2, 3.4, 3.9, 4.2, 4.9, 3.0, 9.0, 7.6, 8.5, 6.9 ];
x2=[1.5, 1.7, 1.0, 0.5, 4.3, 4.2, 4.7, 3.9, 4.1, 8.5, 7.0, 8.2, 8.5 ];
c= [ 1 , 1 , 1, 1, 2 , 2, 2, 2, 2, 3, 3, 3, 3 ];


%% Representacion datos

i1 = find(c==1);
i2 = find(c==2);
i3 = find(c==3);

plot(x1(i1),x2(i1),'r.');
hold on;
plot(x1(i2),x2(i2),'g.');
hold on;
plot(x1(i3),x2(i3),'b.');
hold on;
axis([0 10 0 10]);grid on;
%% Sacamos discriminantes
x1d = 0:0.01:10;
fd1 = -5/6*x1d + 5;
fd2 = -9/10*x1d + 9;
plot(x1d,fd1,'g-.',x1d,fd2,'-.');hold on;

%% Chequeo 
D1 = [5 6 -30];
D2 = [9 10 -90];

cont = 0;

for i=1:length(x1)
    checkv1 = D1 * [x1(i);x2(i);1];
    checkv2 = D2 * [x1(i);x2(i);1];
    
    if (checkv1 < 0 && checkv2 < 0)
        plot(x1(i),x2(i),'ro');
    elseif (checkv1 > 0 && checkv2 < 0)
        plot(x1(i),x2(i),'go');
    elseif (checkv1 > 0 && checkv2 > 0)
        plot(x1(i),x2(i),'bo');
    end
end


%% Indice de Bondad

x1o=[6, 7, 6, 6, 2, 3, 4, 6, 5];
x2o=[2, 2, 8, 6, 8, 1, 6, 9, 5];
co =[1, 2, 3, 2, 3, 1, 2, 3, 2];
cc = ones(size(co));
CI=0;


for i=1:length(x1o)
    checkv1 = D1 * [x1o(i);x2o(i);1];
    checkv2 = D2 * [x1o(i);x2o(i);1];
    
    if (checkv1 < 0 && checkv2 < 0)
        plot(x1(i),x2(i),'om');
        cc(i)=1;
    elseif (checkv1 > 0 && checkv2 < 0)
        plot(x1(i),x2(i),'*m');
        cc(i)=2;
    elseif (checkv1 > 0 && checkv2 > 0)
        plot(x1(i),x2(i),'sm');
        cc(i)=3;
    end
    
    if (cc(i)~=co(i))
        CI=CI+1;
    end
   
end

IB = 100*CI/(length(x1))


    





