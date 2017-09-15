disp('Solución del Ejemplo 4.3 de Ollero [2]');
clear all
syms t1 d2 real
% Se introduce la matriz con los parámetros de Denavit-Hartenberg, que en este caso
% tendrá solo dos filas, ya que en este ejemplo no se considera el tercer enlace
dh=[0 	0 t1 	0 	0;
    pi/2 0 0 	d2 1];
q = [t1 d2]; % Vector de variables articulares
T = simple( fkine(dh,q) )
disp('Pulse cualquier tecla para continuar');
pause
colormap(gray);
[x,y]=meshgrid(-1:0.03:1,-1:0.03:1);
t1=atan2(x,-y);
% Se representa t1
surfl(x,y,t1); xlabel('Eje X (m)'), ylabel('Eje Y (m)'), zlabel('t1 (rad)')
pause
d2=sqrt(x.^2+y.^2);
% Se representa d2
surfl(x,y,d2); xlabel('Eje X (m)'), ylabel('Eje Y (m)'), zlabel('d2 (m)')