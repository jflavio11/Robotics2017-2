%CORIOLIS	Calcula el par correspondiente a los términos centrífugos y de Coriolis.
%
%	TAU_C = CORIOLIS(DYN, Q, QD) Devuelve el par (vector fila TAU_C) que corresponde
%	a los términos centrífugos y de Coriolis para el estado definido por los vectores
%	fila Q y QD, que son respectivamente las posiciones y velocidades articulares.
%
%	Para el caso en que Q y QD sean matrices, cada fila es interpretada como un vector
%	de variables/velocidades articulares y TAU_C es una matriz que en cada fila contie-
%	ne el par correspondiente.
%
%	Ver también DYN, GRAVITY, INERTIA, RNE.

%	Copyright (C)	Peter Corke 1993
%						Iván Maza 2001

function c = coriolis(dyn, q, qd)
	dyn(:,18:20) = 0;
	c = rne(dyn, q, qd, zeros(size(q)), [0;0;0]);
