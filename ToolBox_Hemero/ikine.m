% IKINE	Calcula la cinemática inversa del manipulador
%
%	Q = IKINE(DH, STOL, ILIMIT, T)
%	Q = IKINE(DH, STOL, ILIMIT, T, Q0)
%	Q = IKINE(DH, STOL, ILIMIT, T, Q0, M)
%
%	Devuelve los valores de las variables articulares necesarios para que el efector
%	final del manipulador tenga la posición y orientación dadas por la transformación
%	T. La solución del problema cinemático inverso no es única en general, y es posi-
%	ble que para una misma orientación y posición deseadas, se obtengan soluciones dis-
%	tintas en función del vector inicial de variables articulares (Q0) que se le pase
%	a IKINE.
%
%	Es posible usar la función para que devuelva las variables articulares correspon-
%	dientes a una sóla posición y orientación, o bien a una trayectoria de posiciones
%	y orientaciones. Eso dependerá del formato del parámetro T:
%
%	-	Si T es una transformación homogénea, entonces IKINE devuelve un vector
%		fila(Q) con las variables articulares correspondientes a la posición y
%		orientación indicadas en la matriz T.
%
%	-	Si T es una trayectoria de transformaciones homogéneas, entonces el re-
%		sultado será una matriz (Q), en la que la fila i-ésima contendrá las va-
%		riables articulares correspondientes a la transformación T (:, :, i ).
%		La estimación inicial para Q en cada paso se toma de la solución obtenida
%		en el paso anterior.
%
%	Sea cual sea el formato de T, la estimación inicial para el vector de variables
%	articulares será la dada en el parámetro Q0 (puede ser una columna o una fila), y
%	en el caso de que no se lo demos, asume que es el vector nulo. 
%
%	Para el caso de un manipulador con menos de 6 grados de libertad el efector final
%	no podrá alcanzar algunas posiciones y orientaciones. Esto normalmente lleva a una
%	no convergencia de IKINE. Una solución consiste en especificar un vector (fila o
%	columna) de pesos (M), cuyos elementos serán 0 para aquellos grados de libertad que
%	en cartesianas estén restringidos, y 1 en otro caso. Los elementos de M se corres-
%	ponden con las traslaciones a lo largo de los ejes X, Y y Z, y con las rotaciones en
%	torno a los ejes X, Y y Z. 
%	Por ejemplo si el manipulador no se puede desplazar a lo largo del eje Z, ni rotar en 
%	torno a los ejes X e Y, M deberá ser el vector [1 1 0 0 0 1].
%	El número de elementos no nulos debe ser igual al número de grados de libertad del ro-
%	bot.
%
%	ILIMIT es el número máximo de iteraciones que se ejecutarán en busca de una solución 
%	(un valor usual es 1000).
% 
%	STOL será la máxima diferencia que se admitirá entre la transformación correspondiente
%	a las variables articulares solución y la transformación con la posición y orientación
%	especificadas (un valor usual es 1e-6). Dicha diferencia se mide haciendo uso de la 
%	función TR2DIFF.
%
%	Ver también FKINE, JACOB0, TR2DIFF.
	
%  Copyright (C)	1999 Peter Corke
%						2001 Iván Maza


function qt = ikine(dh, stol, ilimit, tr, q, m)

	n = numrows(dh);

	if nargin == 4,
		q = zeros(n, 1);
	else
		q = q(:);
	end
	if nargin == 6,
		m = m(:);
      if numrows(m) ~= 6 
         error('El vector máscara debe tener 6 elementos')
		end
	else
      if numrows(dh) < 6,
         disp('Para un manipulador con menos de 6 DOF se debe pasar como parámetro un vector máscara');
		end
		m = ones(6, 1);
	end
		

	tcount = 0;
	if ishomog(tr),		% Caso de que se especifique una sóla transformación
		nm = 1;
		count = 0;
		while nm > stol,
			e = tr2diff(fkine(dh, q'), tr) .* m;
			dq = pinv( jacob0(dh, q') )*e;
         q = q + dq;                 
			nm = norm(dq);
			count = count+1;
         if count > ilimit,
            error('Parece que no hay convergencia')
			end
		end
		qt = q';
	else			% Caso de que se trate de una trayectoria de transformaciones
      np = size(tr,3);
      qt=[];
		for i=1:np,
			nm = 1;
         T = tr(:,:,i);
			count = 0;
			while nm > stol,
				e = tr2diff(fkine(dh, q'), T) .* m;
            dq = pinv( jacob0(dh, q') ) * e;
            q = q + dq;
				nm = norm(dq);
				count = count+1;
            if count > ilimit,
         		error('Parece que no hay convergencia')
				end
			end
			qt = [qt; q'];
			tcount = tcount + count;
		end
	end
