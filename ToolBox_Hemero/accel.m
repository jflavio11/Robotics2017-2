%ACCEL	Calcula las aceleraciones articulares resultantes de aplicar unos determinados
%     	pares a las articulaciones del manipulador
%
%	QDD = ACCEL(DYN, Q, QD, TORQUE, GRAV) devuelve un vector columna con
%	las aceleraciones articulares que resultan de aplicar al manipulador los pares
%	contenidos en el vector TORQUE.
%
%	Utiliza el método 1 de Walker y Orin para calcular la dinámica del manipulador. Este
%	método es útil para la simulación de la dinámica del manipulador, en conjunción con
%	una función numérica de integración.
%
%	Con el vector columna GRAV se especifica la aceleracion de la gravedad que sufre el
%	manipulador (por defecto se toma 9.81 m/s2 en dirección -Z, es decir GRAV=[0 0 -9.81]).
%
%	Ver también RNE, DYN, ODE45.

%  Copyright (C)	1999 Peter Corke
%						2001 Iván Maza

function qdd = accel(dyn, q, qd, torque, grav)
	q = q(:)';
	qd = qd(:)';
	M = inertia(dyn, q);	% Cálculo de la matriz de masas
   tau = rne(dyn, q, qd, zeros(size(q)), grav);	% 	Cálculo de los términos centrífugos y de Coriolis, 
																%	gravitatorios y de fricción.
	qdd = inv(M) * (torque(:) - tau');
