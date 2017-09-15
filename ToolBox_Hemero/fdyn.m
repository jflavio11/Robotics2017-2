%FDYN	Permite integrar la dinámica directa para obtener las trayectorias articulares.
%
%	[T Q QD] = FDYN(DYN, T0, T1)
%	[T Q QD] = FDYN(DYN, T0, T1, GRAV, TORQFUN)
%	[T Q QD] = FDYN(DYN, T0, T1, GRAV, TORQFUN, Q0, QD0)
%
%	La función FDYN se encarga de integrar las ecuaciones del movimiento del manipulador en el
%	intervalo de tiempo que va desde T0 a T1, usando la función de integración ODE45 de MATLAB.
%	Devuelve como resultado un vector de tiempo T, y dos matrices Q y QD, que se corresponden
%	respectivamente con las posiciones y velocidades articulares. Cada una de estas matrices
%	tiene una fila por cada instante contenido en el vector T, y tantas columnas como variables
%	articulares haya.
%
%	El par con el que se actúa sobre el manipulador puede ser especificado mediante una función:
%
%		TAU = TORQFUN(T, X)
%
%	donde T es el tiempo y X = [Q; QD] es un vector columna con 2n elementos que contiene las
%	posiciones  velocidades articulares. Dicha función debe devolver un vector fila. Si no
%	se especifica el parámetro TORQFUN, entonces se asume que se está aplicando un par nulo al
%	manipulador.
%
%	También es posible pasar como parámetros dos vectores Q0 y QD0 con los valores iniciales de
%	las posiciones y velocidades articulares.
%
%	Asimismo, en el parámetro GRAV, se puede introducir el vector aceleración de la gravedad que 
%	sufre el manipulador. Si no se indica ninguno, por defecto se asume una aceleración de 9.81 m/s2
%	en la dirección y sentido del vector -Z (es decir GRAV=[0 0 -9.81]).
%
%	Ver también DYN, ODE45, RNE.

%	Copyright (C)	1993 Peter Corke
%						2001 Iván Maza

function [t, q, qd] = fdyn(dyn, t0, t1, grav, torqfun, q0, qd0)

	global	FDYN_DYN FDYN_TORQFUN ACEL_GRAV
   
	n = numrows(dyn);
   if nargin == 3,
		FDYN_TORQFUN = 0;
      x0 = zeros(2*n,1);
      ACEL_GRAV = [0 0 -9.81];
   elseif nargin == 4,
		FDYN_TORQFUN = 0;
      x0 = zeros(2*n, 1);
      ACEL_GRAV = grav;
   elseif nargin == 5,
		FDYN_TORQFUN = torqfun;
      x0 = zeros(2*n, 1);
      ACEL_GRAV = grav;
   elseif nargin == 7,
      FDYN_TORQFUN = torqfun;
      x0 = [q0(:); qd0(:)];
      ACEL_GRAV = grav;
	end
	FDYN_DYN = dyn;
		
	[t,y] = ode45('fdyn2', [t0 t1], x0);
	q = y(:,1:n);
	qd = y(:,n+1:2*n);