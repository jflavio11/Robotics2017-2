path(path, '.\ToolBox_Hemero')
path(path, '.\simpleMovs')
path(path, '.\simpleMovs\rotations')
%{

1. Teniendo un sistema de coordenadas O'UVW ha sido trasladado inicialmente a r(2,2,0)
con respecto al sistema OXYZ, calcular las coordenadas Rx,Ry,Rz (con
respecto a OXYZ) que con respecto al sistema O'UVW son (13, 6, 3)
Rpta: p(15,8,3)

%}

% Ejercicio 1
% definimos la matriz identidad para usarla como sistema de referencia
TA = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
% definimos el sistema o'uvw trasladado hacia el punto r(2,2,0)
r_uvw = transl(2,2,0);
% lo colocamos con respecto al sistema de coordenadas TA
r_uvw = r_uvw*TA;

% generamos el sistema o'uvw trasladado hacia p(15,8,3)
r_uvw_2 = transl(15, 8 ,3);
tras_uvw = r_uvw_2* TA;
% empezamos a graficar
% generamos el plano 3d
figure;

% graficamos nuestro sistema de referencia en 0,0,0
frame(TA, 'b', 3);

% graficamos nuestro sistema de referencia en la posicion inicial
%frame(initPos, 'y', 1)
% ahora graficamos nuestro sistema de referencia trasladado
frame(r_uvw, 'r', 1);

frame(tras_uvw, 'y', 1);

% mostramos el plano de -1 a 18 en todos los ejes
axis([-1 18 -1 18 -1 18])

% para poder girar el plano 3d
rotate3d
grid