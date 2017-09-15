%	AUXINV	Función auxiliar de los bloques Simulink que calculan los modelos
%		cinemáticos inversos

%	Copyright (C) Iván Maza 2001

function phi = triaux(u)

xd = u(1);
yd = u(2);
if yd == 0
   if xd>0
      phi = pi/2;
   else
      phi = -pi/2;
   end
else
   phi = atan(-xd/yd);
end
