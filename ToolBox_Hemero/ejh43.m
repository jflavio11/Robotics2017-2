disp('Solución del Ejemplo 5.3 de Ollero[1]')
clear all
syms t1 t2 t3 td1 td2 td3 tdd1 tdd2 tdd3 real

dyn=[	0 0 	0 0 0 4.7 0.8	0 0 0		0		0		0 0 0 0 1 0 0 0;
		0 0.8	0 0 0 2.6 0.8	0 0 0		0		0		0 0 0 0 1 0 0 0;
		0 0.8	0 0 0 1.1 0 	0 0 0.05	0.1	0.1	0 0 0 0 1 0 0 0];

q = [t1 t2 t3];
qd = [td1 td2 td3];
qdd = [tdd1 tdd2 tdd3];
grav = [0; 9.8; 0];

disp('Par total sobre las articulaciones')
tau = rne(dyn, q, qd, qdd, grav)
