% Ejemplo de apoyo para aprender el uso de la función FRAME

echo off
disp('Ejemplo H.2.1 de FRAME')
clear all
TA=[1 0 0 0;
   0 1 0 0 ;
   0 0 1 0;
   0 0 0 1];
frame(TA,'c',1);
axis([-0.5 1 -0.5 1 -0.5 1])	% Se establecen los rangos de los ejes
grid on								% Se establece una rejilla
view(-33,16)						% Se establece el punto de vista
