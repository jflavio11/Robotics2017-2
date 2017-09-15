disp('Solución del Ejemplo 4.1 de Ollero [2]')
clear all
syms t1 t2 t3 l1 l2 real

% Se introduce la matriz con los parámetros de Denavit-Hartenberg
dh=[0 0 	t1 0 0;
    0 l1 t2 0 0;
    0 l2 t3 0 0];
q = [t1 t2 t3];

T = simple( fkine(dh,q))
