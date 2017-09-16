function robot01(angle, longitude)

path(path, '..\ToolBox_Hemero')
path(path, '..\simpleMovs')
path(path, '..\simpleMovs\rotations')

% convertimos el angulo a radianes
angle = angle * pi/180;

% creamos la matriz homogenea de transformación
A1 = RotX(angle) * Trasl(0,longitude, 0);

% obtenemos las coordenadas del extremo
P01 = A1 * [0 0 0 1]';

% dibujamos el robot
y = [0 P01(2)];
z = [0 P01(3)];

hold off;
plot(y, z, '-o', 'linewidth', 4);
hold on;

% dibujamos la pinza
pinza(A1);

l = longitude + 0.5*longitude;

axis([0 l 0 l 0 l]);
axis('on');
rotate3d;
grid;

end