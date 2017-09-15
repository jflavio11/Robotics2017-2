%ROTY	Rotación en torno al eje Y
%
%	ROTY(THETA) devuelve la transformación homogénea correspondiente a una rotación de
%	THETA radianes en torno al eje Y.
%
%	Ver también ROTX, ROTZ, ROTVEC.

% 	Copyright (C) Peter Corke 1990

function r = roty(t)
ct = cos(t);
st = sin(t);
r = [	ct		0	st	0
   	0		1	0	0
   	-st	0	ct	0
   	0		0	0	1];