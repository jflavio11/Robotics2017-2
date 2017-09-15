%RPY2TR	Obtiene la transformación homogénea correspondiente a los ángulos RPY dados
%
%	RPY2TR([R P Y])
%	RPY2TR(R,P,Y) devuelve la transformación homogénea que corresponde a los ángulos RPY
%	(roll/pitch/yaw). Dichos ángulos se le deben pasar expresados en radianes, y son los
%	ángulos de rotación en torno a los ejes X, Y y Z respectivamente.
%
%	Ver también TR2RPY, EUL2TR

%	Copyright (C) Peter Corke 1993

function r = rpy2tr(roll, pitch, yaw)

if length(roll) == 3,
   r = rotz(roll(3)) * roty(roll(2)) * rotx(roll(1));
else
   r = rotz(yaw) * roty(pitch) * rotx(roll);
end