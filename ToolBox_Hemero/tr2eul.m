%TR2EUL	Obtiene los ángulos de Euler Z-Y-Z a partir de una matriz de transformación homogénea
%
%	[ALPHA BETA GAMMA] = TR2EUL(T) devuelve un vector de ángulos en radianes, que se corresponden
%	con los ángulos de Euler Z-Y-Z asociados a la submatriz de rotación de la transformación
%	homogénea T que se le pasa como parámetro.
%
%	Ver también  EUL2TR, TR2RPY

%	Copyright (C) Peter Corke 1993

function euler = tr2eul(m)
	
	euler = zeros(1,3);

	if abs(m(2,3)) > eps & abs(m(1,3)) > eps,
		euler(1) = atan2(m(2,3), m(1,3));
		sp = sin(euler(1));
		cp = cos(euler(1));
		euler(2) = atan2(cp*m(1,3) + sp*m(2,3), m(3,3));
		euler(3) = atan2(-sp * m(1,1) + cp * m(2,1), -sp*m(1,2) + cp*m(2,2));

	else,
		euler(1) = 0;
		euler(2) = atan2(m(1,3), m(3,3));
		euler(3) = atan2(m(2,1), m(2,2));
	end
