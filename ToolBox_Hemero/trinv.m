%TRINV	Transformacion inversa de una dada
%
%	TRINV(T) devuelve la transformación inversa de la transformación T que se le
%	pasa como parámetro
%

% 	Copyright (C) Iván Maza 2001

function Ti = trinv(T)
	R=T(1:3,1:3);
	P=T(1:3,4);
	Ti=[R' -R'*P
	    0 0 0 1];	