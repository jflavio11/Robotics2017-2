%OA2TR	Construye una transformación homogénea a partir de los vectores o y a
%
%	OA2TR(O, A) Devuelve la transformación homogénea de rotación correspondiente a los
%	vectores de orientación (O) y aproximación (A), que le pasamos como parámetros.
%
%	Ver también RPY2TR, EUL2TR

%	Copyright (C) 1993 Peter Corke

function r = oa2tr(o, a)

n = cross(o, a);
r = [unit(n(:)) unit(o(:)) unit(a(:)) zeros(3,1); 0 0 0 1];