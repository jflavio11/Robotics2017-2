%TR2RPY	Extrae de una transformación homogénea sus correspondientes ángulos RPY
%
%	[R P Y] = TR2RPY(T) devuelve un vector que contiene los ángulos RPY en radianes,
%	que corresponden a la submatriz rotacional de la transformación homogénea T.
%	Los ángulos calculados son respectivamente rotaciones en torno a los ejes X, Y y
%	Z respectivamente.
%
%	Ver también  RPY2TR, TR2EUL

%	Copyright (C) Peter Corke 1993

function rpy = tr2rpy(m)
	
	rpy = zeros(1,3);

	if abs(m(1,1)) < eps & abs(m(2,1)) < eps,
		rpy(3) = 0;
		rpy(2) = atan2(-m(3,1), m(1,1));
		rpy(1) = atan2(-m(2,3), m(2,2));
	else,
		rpy(3) = atan2(m(2,1), m(1,1));
		sp = sin(rpy(3));
		cp = cos(rpy(3));
		rpy(2) = atan2(-m(3,1), cp * m(1,1) + sp * m(2,1));
		rpy(1) = atan2(sp * m(1,3) - cp * m(2,3), cp*m(2,2) - sp*m(1,2));
	end
