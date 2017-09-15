%TRANSL	Cálculos asociados a transformaciones de traslación
%
%	T = TRANSL(X, Y, Z)
%	T = TRANSL(V)
%	V = TRANSL(T)
%	XYZ = TRANSL(TC)
%
%	Las dos primeras formas devuelven una matriz de transformación que representa una traslación
%	dada por tres escalares (X, Y, Z), o bien por un vector V.
%
%	La tercera forma devuelve, en un vector columna (V) de 3 elementos, la parte traslacional de
%	la transformación T.
%
%	La cuarta forma devuelve una matriz (XYZ), cuyas filas contienen las coordenadas x, y y z de
%	las traslaciones contenidas en cada una de las matrices de la trayectoria de transformaciones
%	TC.
%
%	Ver también ROTX, ROTY, ROTZ, ROTVEC.

% 	Copyright (C) Peter Corke 1990

function r = transl(x, y, z)
	if nargin == 1,
		if ishomog(x),
			r = x(1:3,4);
		elseif ndims(x) == 3,
			r = squeeze(x(1:3,4,:))';
		else
			t = x(:);
			r =    [eye(3)			t;
				0	0	0	1];
		end
	elseif nargin == 3,
		t = [x; y; z];
		r =    [eye(3)			t;
			0	0	0	1];
	end
