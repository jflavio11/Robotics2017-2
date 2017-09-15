clear all
disp('Ejemplo H.6.4')
disp('Seguimiento de un camino consistente en una línea recta mediante un')
disp('controlador lineal')
figure(1)
subplot(2,1,1)
x_camino=0:0.01:10;
y_camino=x_camino;
K1=0.1; K2=1.1;
sim('ejh64a')
plot(x_camino,y_camino,'--'), hold on, plot(x_v,y_v),axis([0 10 0 10]),
title('k_1=0.1 k_2=1.1'), xlabel('X (m)'), ylabel('Y (m)'), grid
K1=0.5; K2=0.8;
subplot(2,1,2)
sim('ejh64a')
plot(x_camino,y_camino,'--'), hold on, plot(x_v,y_v),axis([0 10 0 10]),
title('k_1=0.5 k_2=0.8'), xlabel('X (m)'), ylabel('Y (m)'), grid
clear x_camino y_camino
disp('Pulse una tecla para continuar')
pause

disp('Seguimiento de un camino parabólico mediante un controlador lineal')
figure(2)
subplot(2,1,1)
x_camino=0:0.01:10;
y_camino=x_camino.^2;
K1=0.1; K2=1.1;
sim('ejh64a')
plot(x_camino,y_camino,'--'), hold on, plot(x_v,y_v),axis([-0.25 3.2 0 13]),
title('k_1=0.1 k_2=1.1'), xlabel('X (m)'), ylabel('Y (m)'), grid
K1=0.5; K2=0.8;
subplot(2,1,2)
sim('ejh64a')
plot(x_camino,y_camino,'--'), hold on, plot(x_v,y_v),axis([-0.25 3.7 0 13]),
title('k_1=0.5 k_2=0.8'), xlabel('X (m)'), ylabel('Y (m)'), grid
