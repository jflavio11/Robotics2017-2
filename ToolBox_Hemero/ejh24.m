echo off
disp('Ejemplo H.2.4')

clear all
T = transl(0.5,0,0)
frame(T,'c',1);
grid on
view(-30,30)
disp('Pulse una tecla para continuar')
pause

clear all
clf
T=roty(pi/2)
frame(T,'c',1);
grid on
view(-33,18)
disp('Pulse una tecla para continuar')
pause

clear all
clf
T=rotz(-pi/2)
frame(T,'c',1);
grid on
view(-25,52)
disp('Pulse una tecla para continuar')
pause

clear all
clf
T=transl(0.5,0,0)*roty(pi/2)*rotz(-pi/2)
ishomog(T)
frame(T,'c',1);
grid on
view(-53,22)
disp('Pulse una tecla para continuar')
pause

close all	% Se cierran todas las figuras

eul = tr2eul(T)	% Se calculan los ángulos de Euler Z-Y-Z

rpy = tr2rpy(T)	% Se calculan los ángulos RPY