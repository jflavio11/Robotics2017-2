%JACOBN	Calcula el Jacobiano expresado en el sistema de coordenadas del efector final
%
%	JACOBN(DH, Q) devuelve el Jacobiano expresado en el sistema de referencia del 
%	efector final que corresponde a los valores de las variables articulares con-
%	tenidos en Q.
%
%	La matriz Jacobiana permite obtener el vector de velocidades en el espacio car-
%	tesiano (V) del efector final expresado en el cuadro {n} (asociado al efector 
%	final) a partir de las derivadas de las variables articulares en virtud de la 
%	expresión:
%
%                        V = J dQ
%
%	El vector de velocidades (V) está formado por las velocidades lineales a lo largo
%	de los ejes X, Y y Z, y por las velocidades angulares de giro en torno a los ejes
%	X, Y y Z, expresadas ambas en el cuadro {n}.
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
%	Ver también JACOB0, TR2DIFF

%  Copyright (C)	Peter Corke 1999
%						Iván Maza 2001

function J = jacobn(dh, q)
	J = [];
	n = numrows(dh);
	
	T = eye(4,4);
   for i=n-1:-1:1,
      T = linktrans(dh(i+1,:), q(i+1)) * T;
      if dh(i,5) == 0,
         % articulación de rotación
         d = [-T(1,1)*T(2,4)+T(2,1)*T(1,4)
              -T(1,2)*T(2,4)+T(2,2)*T(1,4)
              -T(1,3)*T(2,4)+T(2,3)*T(1,4)];
         delta = T(3,1:3)';	% nz oz az
      else
         % articulación prismática
         d = T(3,1:3)';		% nz oz az
         delta = zeros(3,1);	%  0  0  0
      end
      J = [[d; delta] J];
   end
   
   if dh(n,5) == 0,
      % articulación de rotación
      d = zeros(3,1);         %  0  0  0
      delta = [0 0 1]';       %  0  0  1
   else
      % articulación prismática
      d = [0 0 1]';           %  0  0  1 
      delta = zeros(3,1);     %  0  0  0
   end
   J = [J [d; delta]];

