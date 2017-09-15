% Ejemplo de apoyo para aprender el uso de la función FRAME

echo off
disp('Ejemplo H.2.3 de FRAME')
clear all
close all					% Se cierran todas las figuras anteriores
w=2;
T(:,:,1) = eye(4);
for np=1:6
      T(:,:,w)=transl(0,1.1,1.1)*T(:,:,w-1);
      w=w+1;
end

frame(T,'c',1,0);
axis([-4 4 -2 6 0 8])	% Se establecen los rangos de los ejes
grid on						% Se establece una rejilla
view(-40,12)				% Se establece el punto de vista
