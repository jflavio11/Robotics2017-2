disp('Solución del Ejemplo 5.2 de Ollero[1]')
clear all

l1=3; l2=1; m1=2; m2=1;
% Se cargan los parámetros del manipulador
dyn=[	0 0 	0 0 0 m1 l1 0 0 0 0 0 0 0 0 0 1 0 0 0;  
   	0 l1 	0 0 0 m2 l2 0 0 0 0 0 0 0 0 0 1 0 0 0];

[tsim,q,qd] = fdyn(dyn,0,10,[0 -9.81 0],'taucap5',[0 0],[0 0]);

% Las siguientes lineas sirven para preparar las representaciones gráficas
for k=1:length(tsim)
   tau(:,k)=taucap5(tsim(k),[]);
   x(k)=l1*cos(q(k,1))+l2*cos(q(k,1)+q(k,2));
   y(k)=l1*sin(q(k,1))+l2*sin(q(k,1)+q(k,2));
end


% Se representan los pares aplicados
figure(1)
subplot(2,1,1),plot(tsim,tau(1,:)),xlabel('Tiempo (seg)'),ylabel('Par 1 (N·m)')
subplot(2,1,2),plot(tsim,tau(2,:)),xlabel('Tiempo (seg)'),ylabel('Par 2 (N·m)')
pause
% Se representan q1 y q2 deseadas junto con las obtenidas
figure(2)
subplot(2,1,1),plot (tsim,q(:,1)),xlabel('Tiempo (seg)'),ylabel('theta 1 (rad)')
subplot(2,1,2),plot (tsim,q(:,2)),xlabel('Tiempo (seg)'),ylabel('theta 2 (rad)')
pause
% Se representa en cartesianas la trayectoria obtenida
figure(3)
plot(x,y), title('Trayectoria obtenida en cartesianas'),...
xlabel('Eje X (m)'), ylabel('Eje Y (m)')