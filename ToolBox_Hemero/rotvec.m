%ROTVEC	Rotación en torno a un eje arbitrario
%
%	ROTVEC(V, THETA) devuelve la transformación homogénea que representa una rotación 
%	de THETA radianes en torno a un vector V.
%
%	Ver también ROTX, ROTY, ROTZ.

% 	Copyright (C) Peter Corke 1990

function r = rotvec(v, t)
ct = cos(t);
st = sin(t);
vt = 1-ct;
v = v(:);
r = [	ct			-v(3)*st	v(2)*st
   	v(3)*st	ct			-v(1)*st
   	-v(2)*st	v(1)*st	ct	];
r = [v*v'*vt+r zeros(3,1); 0 0 0 1];
