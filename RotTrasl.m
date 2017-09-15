path(path, 'D:\robotica\robotica02\ToolBox_Hemero')
%{
    Rotacion y traslacion
    Este script de ejemplo permite rotar un sistema de coordenadas
    para luego trasladarlo a un punto xyz
    Nota: primero se define el path donde estan definidas las funciones de
    ToolBox_Hemero
%}

% definiendo rotacion en x
% 2pi = 360, pi = 90
rx = rotx(pi/2);

% ahora transladamos despues e girar 90 grados
rt = transl(8, -4, 12)*rx;

% defines tu sistema uvw
r_uvw = [-3; 4; -11; 1];

% trasladamos y giramos el sistema de cordenadas uvw
r_xyz = rt*r_uvw;

% empezamos a graficar
% generamos el plano 3d
figure;

TA = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
% graficamos nuestro sistema de referencia en 0,0,0
frame(TA, 'y', 3);

% ahora graficamos nuestro sistema de referencia rotado y trasladado
frame(rx, 'k', 1.5);

% nos permite definir de donde a donde se mostrara el plano 3d
% con esto se permite mostrar desde -2 a 4 en todos los ejes
%axis([-2 4 -2 2 0 4])

% con esto solo puedes mostrar de 0 a 3
axis([0 4 0 4 0 4])

% para poder girar el plano 3d
rotate3d
grid