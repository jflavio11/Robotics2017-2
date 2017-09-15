clear all
disp('Ejemplo H.6.7')
disp('Seguimiento de trayectorias con control lineal y escalado en velocidad')

sim('ejh67a')
figure(1)
subplot(2,1,1)
plot(tout,v_r,'--'), hold on, plot(tout,v), xlabel('Tiempo (seg)'), ylabel('v (m/s)'), grid
subplot(2,1,2)
plot(tout,w_r,'--'), hold on, plot(tout,w), xlabel('Tiempo (seg)'), ylabel('w (rad/s)'), grid

figure(2)
plot(x_r,y_r,'--'), hold on, plot(x,y),plot(0,0,'*'), plot(1,0.5,'*'), xlabel('X (m)'), ylabel('Y (m)'), grid