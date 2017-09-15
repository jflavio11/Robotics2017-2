% DH	Representación matricial de la cinemática del manipulador
%
%	Cada vez que se quiera utilizar una función de HEMERO relacionada con la cinemática
%	se deberán introducir en una matriz los parámetros de Denavit-Hartenberg del manipula-
%	dor, de acuerdo con la notación de Craig (1986). El modo de introducir dicha informa-
%	ción en esa matriz es el siguiente:
%
%	-	Habrá una fila por cada enlace que tenga el manipulador.
%
%	-	Cada fila tendrá el siguiente formato:
%
%			[alpha(i-1) a(i-1) theta(i) d(i) sigma(i)]
%    
%		donde:
%		-	alpha(i-1), a(i-1), theta(i), d(i) son los parámetros de Denavit-Hartenberg
%			según Craig (1986).
%		-	sigma(i) indicará el tipo de articulación (será 0 si es de rotación y un número
%			distinto de cero si por el contrario es prismática).
%
%	Así pues para un robot con n enlaces, la matriz sería de dimensiones nx5.
%
%	Todos los ángulos deberán ser introducidos en radianes. Las longitudes a(i-1) y d(i)
%	podrán ser expresadas en cualquier unidad y sólo habrá que tener cuidado de recordar
%	que las transformaciones homogéneas y los Jacobianos que se calculen aparecerán en 
%	esas mismas unidades.

%	Copyright (C) Peter Corke 1993
