%{
    Draws a robot arm with 2 liberty degrees.
%}
function robot2(angle1, angle2)

path(path, '..\ToolBox_Hemero')
path(path, '..\simpleMovs')
path(path, '..\simpleMovs\rotations')

% convertimos el angulo a radianes
angle = angle1 * pi/180;
angle2 = angle2 * pi/180;

% calculamos primero las dos matrices principales que conformaran las dos
% partes del brazo
longitude = 1;
longitude2 = 1;
A1 = RotX(angle) * Trasl(0, longitude, 0);
A2 = RotX(angle2) * Trasl(0, longitude2, 0);

% la trasnformada final
T = A1 * A2;

% obtenemos las coordenadas del extremo
% y
P01 = A1 * [0 0 0 1]';
% z
P02 = T * [0 0 0 1]';


% dibujamos el robot [x,y,z]
y = [0 P01(2) P02(2)];
z = [0 P01(3) P02(3)];

hold off;
plot(y, z, '-o', 'linewidth', 4);
hold on;

% dibujamos la pinza
pinza(T);

l = longitude + 2*longitude;

% permitimos que el espacio 3d vaya desde 0 a l como máximo en X Y Z
axis([0 l 0 l 0 l]);
axis('on');
rotate3d;
grid;

end