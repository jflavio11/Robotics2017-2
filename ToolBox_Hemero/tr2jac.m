%TR2JAC	Calcular la matriz (que se podría llamar Jacobiana) que permite pasar un vector
%	de velocidades cartesianas de un cuadro de referencia a otro distinto
%
%	J = TR2JAC(T)
%
%	Esta función devuelve una matriz Jacobiana (J) de dimensiones 6x6, que permite
%	expresar en un sistema de referencia {B} un vector de velocidades cartesianas
%	expresado en un sistema {A}. Para ello simplemente hay que pasarle como pará-
%	metro la matriz de transformación T que expresa el cuadro {B} en el {A}.
%
%	Ver también TR2DIFF, DIFF2TR

%	Copyright (C) Peter Corke 1993

function J = tr2jac(t)
	J = [	t(1:3,1)'	cross(t(1:3,4),t(1:3,1))'
			t(1:3,2)'	cross(t(1:3,4),t(1:3,2))'
			t(1:3,3)'	cross(t(1:3,4),t(1:3,3))'
			zeros(3,3)	t(1:3,1:3)'					];
		
