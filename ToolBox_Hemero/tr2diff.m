%TR2DIFF	Convierte una transformación en un vector de movimiento diferencial y
%		calcula la diferencia entre dos transformaciones.
%
%	TR2DIFF(T)
%	TR2DIFF(T1, T2)
%
%	Se tendrá una descripción distinta para cada una de las sintaxis:
%
%	a)	D = TR2DIFF(T)
%		Devuelve un vector D que contiene los seis elementos de movimiento
%		diferencial (tres de traslación y tres de rotación) que se pueden
%		obtener de la matriz T.
%
%	b)	D = TR2DIFF(T1, T2)
%		En este caso devuelve un vector D de seis elementos que representa
%		el movimiento diferencial que corresponde al desplazamiento de T1 a
%		T2, es decir a la matriz T2-T1.
%
%	Ver también IKINE.

%	Copyright (C) Peter Corke 1993


function d = tr2diff(t1, t2)
	if nargin == 1,
		d = [	t1(1:3,4);
			0.5*[t1(3,2)-t1(2,3); t1(1,3)-t1(3,1); t1(2,1)-t1(1,2)]];
	else
		d = [	t2(1:3,4)-t1(1:3,4);
			0.5*(	cross(t1(1:3,1), t2(1:3,1)) + ...
				cross(t1(1:3,2), t2(1:3,2)) + ...
				cross(t1(1:3,3), t2(1:3,3)) ...
			)];
	end

