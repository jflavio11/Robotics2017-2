echo off
disp('Solución del Ejemplo 4.7 de Ollero [2] mediante jacobn')
clear all
syms t1 t2 t3 t4 t5 t6 a2 a3 d3 d4 real
dh = [0		0	t1	0	0;
		-pi/2	0	t2	0	0;
		0		a2	t3	d3	0;
		-pi/2	a3	t4	d4	0;
		pi/2	0	t5	0	0;
		-pi/2	0	t6	0	0];
q=[t1 t2 t3 t4 t5 t6];
J = simple (jacobn(dh,q))
disp('Pulse cualquier tecla para continuar')
pause
disp('Solución del Ejemplo 4.7 de Ollero [2] con la técnica de propagación de velocidades')
clear all
syms t1 t2 t3 t4 t5 t6 td1 td2 td3 td4 td5 td6 a2 a3 d3 d4 real
dh = [0		0	t1	0	0;
		-pi/2	0	t2	0	0;
		0		a2	t3	d3	0;
		-pi/2	a3	t4	d4	0;
		pi/2	0	t5	0	0;
		-pi/2	0	t6	0	0];
q=[t1 t2 t3 t4 t5 t6];
qd=[td1 td2 td3 td4 td5 td6];
v0=[0 0 0]';
w0=[0 0 0]';
z = simple (velprop(dh,q,qd,v0,w0))
