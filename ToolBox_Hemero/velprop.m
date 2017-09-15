%VELPROP Calcula las velocidades lineales (v) y rotacionales (w) del extremo
%	del manipulador expresadas en el cuadro {n}
%
%	VELPROP(DH,Q,QD,V0,W0) devuelve las velocidades lineales (v) y rotacionales
%	(w) del extremo del manipulador en el cuadro {n} para la posición actual Q,
%	dados un vector W0 de velocidad angular del marco {0} y un vector V0 de ve-
%	locidad lineal del marco {0}. QD es un vector con las derivadas de las va-
%	riables articulares respecto al tiempo.
%
%	Se emplea la técnica de propagación de velocidades.
%
%	Ver también DH, FKINE

%	Copyright (C) Iván Maza 1999

function z = velprop(dh,q,qd,v0,w0)

n = numrows(dh);
for i = 1:n
        T = linktrans(dh(i,:), q(i));
        if dh(i,5) == 0
                % articulación de rotación
                w = T(1:3,1:3)'*w0+qd(i)*[0 0 1]';
                v = T(1:3,1:3)'*(v0+cross(w0,T(1:3,4)));
                w0 = w;
                v0 = v;
        else
                % articulación prismática
                w = T(1:3,1:3)'*w0;
                v = T(1:3,1:3)'*(v0+cross(w0,T(1:3,4)))+qd(i)*[0 0 1]';
                w0=w;
                v0=v;
        end
end
z=[v;w];
