% FKINE	Calcula la cinemática directa de un robot manipulador
%
%	FKINE(DH, Q)  calcula la cinemática directa de una manipulador para un
%	estado dado por el vector de variables articulares Q. Dicho manipulador
%	quedará descrito por su matriz de parámetros de Denavit-Hartenberg (DH).
%
%	Es posible utilizar esta función de dos modos:
%
%	a)	Si Q es un vector, entonces es interpretado como el vector de variables 
%		articulares para el que se pretende calcular el modelo directo, y FKINE
%		devuelve la transformación homogénea T correspondiente al último enlace
%		del manipulador. En este caso Q deberá ser un vector fila.
% 
%	b)	Si Q es una matriz, cada fila será interpretada como un vector de varia-
%		bles articulares, y T será una matriz tridimensional 4x4xm, siendo m el
%		número de filas de Q. T es lo que se denominará una trayectoria de trans-
%		formaciones homogéneas.
%		Para extraer la transformación homogénea (Ti) que hay "condensada" en la
%		fila i-ésima de la matriz T, bastará con escribir:
%
%                            TI = T(:,:,i)
%
%	Empleando la función FKINE según este último modo, es posible obtener todas
%	las transformaciones homogéneas correspondientes a una trayectoria dada en 
%	el espacio de variables articulares.
%
%	Ver también DH, LINKTRANS.

%	Copyright (C)	Peter Corke 1999
%						Iván Maza 1999                      

function t = fkine(dh, q)
   
   n = numrows(dh);
	if numcols(q) ~= n,
		error('datos erróneos')
	end
	
	if numrows(q) == 1, % si q es solamente un vector fila
		t = eye(4,4);
		for i=1:n,
         t = t * linktrans(dh(i,:), q(i));
		end
	else
		k=1;
		for qv=q',		% para cada punto de la trayectoria dada en variables articulares
			tt = eye(4,4);
			for i=1:n,
            tt = tt * linktrans(dh(i,:), qv(i));
         end
         t(:,:,k) = tt;
         k=k+1;
		end
	end
