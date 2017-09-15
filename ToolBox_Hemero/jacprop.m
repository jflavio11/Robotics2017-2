%JACPROP Calcula el Jacobiano expresado en el sistema de coordenadas del efector
%			final empleando el método de propagación de velocidades
%
%  JACPROP(DH,Q,QD,V0,W0) devuelve el Jacobiano del manipulador en el cuadro {n}
%	para la posición actual Q, dados un vector W0 de velocidad angular del marco
%	{0} y un vector V0 de velocidad lineal del marco {0}. QD es un vector con las
%	derivadas de las variables articulares respecto al tiempo.
%
%	El algoritmo que se emplea en esta función es más costoso computacionalmente
%	que el utilizado en JACOBN.
%
%  Ver también DH, FKINE, JACOBN, JACOB0
%
%  Copyright (C) Iván Maza 1999

function J = jacprop(dh,q,qd,v0,w0)

n = numrows(dh);
z=[];
for k=1:n
   qd=zeros(1,n);
   qd(k)=1;
   
   for i=1:n
      
      T=linktrans(dh(i,:), q(i));
      if dh(i,5) == 0
         % articulación de rotación
         w=T(1:3,1:3)'*w0+qd(i)*[0 0 1]';
         v=T(1:3,1:3)'*(v0+cross(w0,T(1:3,4)));
         w0=w;
         v0=v;
      else
         % articulación prismática
         w=T(1:3,1:3)'*w0;
         v=T(1:3,1:3)'*(v0+cross(w0,T(1:3,4)))+qd(i)*[0 0 1]';
         w0=w;
         v0=v;
      end      

   end
   z=[z [v;w]];
end
J=z;
