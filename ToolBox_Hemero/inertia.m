%INERTIA Calcula la matriz de masas del manipulador.
%
%	INERTIA(DYN, Q) Devuelve la matriz de masas M(Q) correspondiente al vector fila Q que contiene las
%	posiciones articulares. En la matriz DYN están contenidos los parámetros cinemáticos y dinámicos.
%
%	Para un manipulador con n articulaciones la matriz de masas tiene dimensiones nxn y es simétrica.
%
%	Hay que recordar que si en la matriz DYN aparecen parámetros relativos a la inercia del motor, en-
%	tonces dicha inercia, referida al cuadro de referencia del enlace, aparecerá en la diagonal de la 
%	matriz M.
%
%	Ver también CORIOLIS, DYN, GRAVITY, RNE.

%	Copyright (C)	Peter Corke 1993
%						Iván Maza 2000

function M = inertia(dyn, q)
	dyn(:,18:20) = 0;
	n = numrows(dyn);
	M = rne(dyn, ones(n,1)*q, zeros(n,n), eye(n), [0;0;0]);
	