%	TRINTERP Calcular la interpolación entre dos transformaciones homogéneas
%
%	T = TRINTERP(T0, T1, R)
%	T = TRINTERP(T0, DP, R)
%
%	Esta función, en su primera sintaxis, interpola entre las dos transformaciones
%	homogéneas T0 y T1 a medida que r varía entre 0 y 1. Se suele usar generalmente
%	para generar trayectorias cartesianas.
%
%	La segunda sintaxis emplea el vector dp devuelto por la función drivepar (que
%	representa la ‘diferencia’ entre T0 y T1) y puede ser más eficiente cuando se
%	calculen muchos puntos interpolados entre las mismas transformaciones.
%
%	Ver también CTRAJ, DRIVEPAR.

%	Copyright (C) 1993 Peter Corke

function t = trinterp(T0, a2, r)
	D = zeros(4,4);

	% eqn (5.69)

	% Usando la notación de Paul, dp es
	%	dp(1)	x
	%	dp(2)	y
	%	dp(3)	z
	%	dp(4)	phi
	%	dp(5)	theta
	%	dp(6)	psi

	if ishomog(a2),
		dp = drivepar(T0, a2);
	else
		dp = a2;
	end
	srp = sin(dp(4)*r);	% r*phi
	crp = cos(dp(4)*r);
	srt = sin(dp(5)*r);	% r*theta
	crt = cos(dp(5)*r);
	vrt = 1 - crt;
	sp = sin(dp(6));	% psi
	cp = cos(dp(6));

	D(1,2) = -srp*(sp^2*vrt+crt)+crp*(-sp*cp*vrt);
	D(2,2) = -srp*(-sp*cp*vrt)+crp*(cp^2*vrt+crt);
	D(3,2) = -srp*(-cp*srt)+crp*(-sp*srt);

	D(1,3) = cp*srt;
	D(2,3) = sp*srt;
	D(3,3) = crt;

	D(1:3,1) = cross(D(1:3,2), D(1:3,3));

	D(:,4) = [dp(1:3)*r 1]';

	t = T0*D;
