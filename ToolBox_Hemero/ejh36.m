echo off
disp ('Solución del Ejemplo 4.6 de Ollero [2] mediante jacobn')
clear all
syms t1 d2 t3 l2 real
dh = [0		0	t1	0	0;
		pi/2	0	0	d2	1;
		0		0	t3	l2	0];
q=[t1 d2 t3];
J = simple (jacobn(dh,q))
disp('Pulse cualquier tecla para continuar')
pause

disp('Manipulador del Ejemplo 4.6 de Ollero [2] con la técnica de propagación de velocidades')
clear all
syms t1 d2 t3 td1 dd2 td3 l2 real
dh = [0		0	t1	0	0;
		pi/2	0	0	d2	1;
      0		0	t3	l2	0];
q=[t1 d2 t3];
qd=[td1 dd2 td3];
v0=[0 0 0]';
w0=[0 0 0]';
z = simple (velprop(dh,q,qd,v0,w0))
