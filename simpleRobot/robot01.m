%{
    Draws a robot arm on the YZ plane. This function must be called from
    the command prompt writting: robot01(yourAngle).
    'angle' parameter is the angle measured in degrees.
%}
function robot01(angle)

path(path, '..\ToolBox_Hemero')
path(path, '..\simpleMovs')
path(path, '..\simpleMovs\rotations')

% convertimos el angulo a radianes
angle = angle * pi/180;

% creamos la matriz homogenea de transformación
% si la longitud del brazo es muy larga, cortara la garra (puedes probar
% cambiando el valor de la variable 'longitude'
longitude = 1;
A1 = RotX(angle) * Trasl(0,longitude, 0);

% obtenemos las coordenadas del extremo
P01 = A1 * [0 0 0 1]';

% dibujamos el robot
y = [0 P01(2)];
z = [0 P01(3)];

%{
    From the documentation:
    hold on: retains plots in the current axes so that new plots added to 
             the axes do not delete existing plots. New plots use the next 
             colors and line styles based on the ColorOrder and LineStyleOrder 
             properties of the axes. MATLAB® adjusts axes limits, tick marks, 
             and tick labels to display the full range of data.
    hold off: sets the hold state to off so that new plots added to the axes 
              clear existing plots and reset all axes properties. The next  
              plot added to the axes uses the first color and line style based 
              on the ColorOrder and LineStyleOrder properties of the axes. 
              This is the default behavior.
%}
hold off;
plot(y, z, '-o', 'linewidth', 4);
hold on;

% dibujamos la pinza
pinza(A1);

l = longitude + 0.5*longitude;

% permitimos que el espacio 3d vaya desde 0 a l como máximo en X Y Z
axis([0 l 0 l 0 l]);
axis('on');
rotate3d;
grid;

end