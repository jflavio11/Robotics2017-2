%ROTX	Rotación en torno al eje X
%
%	ROTX(THETA) devuelve la transformación homogénea correspondiente a una rotación de
%	THETA radianes en torno al eje X.
%
%	Ver también ROTY, ROTZ, ROTVEC.

% 	Copyright (C) Peter Corke 1990

function r = rotx(t)

ct = cos(t);
st = sin(t);
r =[ 	1	0	0		0
   	0	ct	-st	0
   	0	st	ct		0
   	0	0	0		1];