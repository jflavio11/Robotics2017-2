%DYN	Contiene los parámetros cinemáticos y dinámicos del manipulador.
%
%	Cada vez que se quiera utilizar una función de HEMERO relacionada con la dinámica
%	será necesario introducir en una matriz los parámetros de Denavit-Hartenberg del
%	manipulador, junto con ciertos parámetros dinámicos. El modo de introducir esta
%	información en dicha matriz (a la que se denominará genéricamente DYN) es el
%	siguiente:
%
%	* Habrá una fila por cada enlace que tenga el manipulador.
%	* Cada fila tendrá el siguiente formato:
%  
%		1	alpha(i-1)	Parámetros de Denavit-Hartenberg	
%		2	a(i-1)		
%		3	theta(i)	
%		4	d(i)	
%		5	sigma(i)	Tipo de articulación; 0 si es de rotación y 1 si es prismática 
%		6	masa		Masa del enlace i
%		7	rx		Centro de masas del enlace respecto al cuadro de referencia de dicho enlace
%		8	ry
%		9	rz
%		10	Ixx		Elementos del tensor de inercia referido al centro de masas del enlace
%		11	Iyy
%		12	Izz
%		13	Ixy
%		14	Iyz
%		15	Ixz
%		16	Jm		Inercia de la armadura	          
%		17	G		Velocidad de la articulación / velocidad del enlace
%		18	B		Fricción viscosa, referida al motor
%		19	Tc+		Fricción de Coulomb (rotación positiva), referida al motor
%		20	Tc-		Fricción de Coulomb (rotación negativa), referida al motor
%
%	Así pues para un robot con n enlaces, la matriz DYN tendría dimensiones nx20.
%
%	Todos los ángulos deberán ser introducidos en radianes. El resto de parámetros
%	de la matriz podrán tener las unidades que se deseen, siempre que se sea cohe-
%	rente en el uso de dichas unidades. Es decir que si se introducen las masas en
%	Kg y los centros de masas en metros, al escribir el tensor de inercia se deberá
%	expresar en Kg m2.
%
%	Ver también DH.

%	Copyright (C) Peter Corke 1993
