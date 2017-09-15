%	NONLINEAR	Función auxiliar que se emplea en el bloque de "Seguimiento de
%			caminos (control no lineal)"

% Copyright (C) Iván Maza 2001

function y = nonlinear(u)
if u==0
   y=1;
else
   y=sin(u)/u;
end
