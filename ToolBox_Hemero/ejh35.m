echo off
disp('Solución del Ejemplo 4.5 de Ollero [2] mediante jacobn y jacob0')
clear all
syms t1 t2 t3 l1 l2 real
dh = [0 0 	t1 0 0;
		0 l1 	t2 0 0;
		0 l2 	t3 0 0];
q=[t1 t2 t3];
J3 = simple (jacobn(dh,q))
J0 = simple (jacob0(dh,q))
disp('Pulse cualquier tecla para continuar')
pause
disp('Solución del Ejemplo 4.5 de Ollero [2] con la técnica de propagación de velocidades')
clear all
syms t1 t2 t3 td1 td2 td3 l1 l2 real
dh = [0 0 	t1 0 0;
		0 l1 	t2 0 0;
		0 l2 	t3 0 0];
q=[t1 t2 t3];
qd=[td1 td2 td3];
v0=[0 0 0]';
w0=[0 0 0]';
z = simple (velprop(dh,q,qd,v0,w0))


