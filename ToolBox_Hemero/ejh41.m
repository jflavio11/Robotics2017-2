disp('Solución del Ejemplo 5.1 de Ollero[1]')
clear all
syms t1 t2 td1 td2 tdd1 tdd2 l1 l2 m1 m2 g real
dyn=[	0 0 	t1 0 0 m1 l1 0 0 0 0 0 0 0 0 0 1 0 0 0;
		0 l1 	t2 0 0 m2 l2 0 0 0 0 0 0 0 0 0 1 0 0 0];
   
q = [t1 t2];
qd = [td1 td2];
qdd = [tdd1 tdd2];
grav = [0 g 0];

disp('Par total sobre las articulaciones')
tau = rne(dyn, q, qd, qdd, grav);
tau = simple(tau)
disp('Pulse cualquier tecla para continuar')
pause
disp('Matriz de masas del manipulador')
M = inertia(dyn, q);
M = simple(M)
disp('Pulse cualquier tecla para continuar')
pause
disp('Término gravitatorio')
G = gravity(dyn, q, grav);
G = simple(G)
disp('Pulse cualquier tecla para continuar')
pause
disp('Términos centrífugos y de Coriolis')
V = coriolis(dyn, q, qd);
V = simple(V)


