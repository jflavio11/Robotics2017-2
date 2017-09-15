%ROTZ	Rotación en torno al eje Z
%
%	ROTZ(THETA) devuelve la transformación homogénea correspondiente a una rotación de
%	THETA radianes en torno al eje Z.
%
%	Ver también ROTX, ROTY, ROTVEC.

% 	Copyright (C) Peter Corke 1990

function r = rotz(t)
ct = cos(t);
st = sin(t);
r = [	ct	-st	0	0
   	st	ct		0	0
   	0	0		1	0
      0	0		0	1];