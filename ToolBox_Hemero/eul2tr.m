%EUL2TR	Genera una transformación homogénea a partir de los ángulos de Euler Z-Y-Z
%
%	EUL2TR([ALPHA BETA GAMMA])
%	EUL2TR(ALPHA, BETA, GAMMA)
%	Esta función devuelve la transformación homogénea que corresponde a los ángulos de
%	Euler Z-Y-Z (ALPHA, BETA, GAMMA) que se le pasan como parámetros.
%
%	Ver también RPY2TR, TR2EUL

%	Copyright (C) Peter Corke 1993

function r = eul2tr(alpha, beta, gamma)

if length(alpha) == 3,
   r = rotz(alpha(1)) * roty(alpha(2)) * rotz(alpha(3));
else
   r = rotz(alpha) * roty(beta) * rotz(gamma);
end