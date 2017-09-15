%JACOB0	Calcula el Jacobiano del manipulador expresado en el sistema de referencia
%	base
%
%	JACOB0(DH, Q) devuelve el Jacobiano correspondiente a las variables articulares
%	Q, expresado en el cuadro de referencia de la base del robot.
%
%	La matriz Jacobiana permite obtener el vector de velocidades en el espacio car-
%	tesiano (V) del efector final expresado en el cuadro {0} (base del manipulador) 
%	a partir de las derivadas de las variables articulares en virtud de la expresión:
%
%                        V = J dQ
%
%	El vector de velocidades (V) está formado por las velocidades lineales a lo largo
%	de los ejes X, Y y Z, y por las velocidades angulares de giro en torno a los ejes
%	X, Y y Z, expresadas ambas en el cuadro {0}.
%	Así pues, si el manipulador tiene menos de seis grados de libertad en el Jacobiano
%	aparecerán filas de ceros. En concreto se puede establecer la siguiente correspon-
%	dencia:
%
%               Fila nula                  No es posible
%                   1              Traslación a lo largo del eje X
%                   2              Traslación a lo largo del eje Y
%                   3              Traslación a lo largo del eje Z
%                   4                 Rotación en torno al eje X
%                   5                 Rotación en torno al eje Y
%                   6                 Rotación en torno al eje Z
%
%	Para un manipulador un n articulaciones, el Jacobiano es una matriz 6xn.
%
%	Ver también JACOBN, TR2DIFF

%	Copyright (C) Peter Corke 1999

function J0 = jacob0(dh, q)
	%
	%   V = J dq
	%
	Jn = jacobn(dh, q); % Jacobiano expresado en el sistema del efector final

	%
	%  Se pasa el Jacobiano al sistema de coordenadas de la base
	%
	Tn = fkine(dh, q);	% transformación del efector final
	J0 = [Tn(1:3,1:3) zeros(3,3); zeros(3,3) Tn(1:3,1:3)] * Jn;
