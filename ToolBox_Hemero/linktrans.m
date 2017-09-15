% LINKTRANS	Calcula las matrices de transformación a partir de los parámetros
%		de Denavit-Hartenberg
%
%	T = LINKTRANS(ALPHA, A, THETA, D)
%	T = LINKTRANS(DH, Q) 
%
%	Calcula la matriz de transformación entre sistemas de referencia asociados a
%	enlaces adyacentes a partir de los parámetros de Denavit-Hartenberg expresa-
%	dos según la notación de Craig (1986).
%
%	Hay dos formas posibles de sintaxis:
%
%	-	T = LINKTRANS(ALPHA, A, THETA, D)
%		Calcula la matriz de transformación que corresponde a los parámetros
%		ALPHA, A, THETA y D.
%
%	-	T = LINKTRANS (DH, Q)
%		El primer parámetro que se le pasa es una fila de la matriz de pará-
%		metros de Denavit-Hartenberg (DH). El segundo parámetro es el valor
%		de la variable articular para el que se quiere evaluar la matriz de
%		transformación. Pero es evidente que en este caso es preciso incluir
%		una información que con la sintaxis anterior no era necesaria. Dicha
%		información es el tipo de articulación de que se trata, ya que de no
%		hacerlo sería imposible determinar si el segundo parámetro que se le
%		pasa a la función es THETA o D. Por eso es importante recordar in-
%		cluir la quinta columna (SIGMA) en DH. En el caso de que dicha co-
%		lumna no aparezca se asume que la articulación es de rotación. 
%
%	Ver también DH, FKINE

%	Copyright (C)	Peter Corke 1993
%						Iván Maza 2001

function t = linktrans(a, b, c, d)

	if nargin == 4,
		alpha = a;
		an = b;
		theta = c;
		dn = d;
	else
		if numcols(a) < 4,
         error('faltan columnas en DH');
		end
		alpha = a(1);
		an = a(2);
		if numcols(a) > 4,
			if a(5) == 0,	% Articulación de rotación
				theta = b;
				dn = a(4);
			else		% Articulación prismática
				theta = a(3);
				dn = b;
			end
		else
			theta = b;	% Por defecto se considera de rotación si no aparece sigma
			dn = a(4);
		end
	end
   
   if (alpha==pi | alpha==(-pi) | alpha==(2*pi))
		sa=0; ca=cos(alpha);
	else
		if (alpha==pi/2 | alpha==(3*pi)/2 | alpha==(-pi/2))
			ca=0; sa=sin(alpha);
		else
			sa = sin(alpha); ca = cos(alpha);		
		end
	end

   st = sin(theta); ct = cos(theta);
   
      
   t = [	ct		-st	0		an
			st*ca	ct*ca	-sa	-sa*dn
			st*sa	ct*sa	ca		ca*dn
			0		0		0		1];
