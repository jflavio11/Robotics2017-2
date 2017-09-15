%	PARABAUX Función auxiliar de PARAB, que calcula la duración de los tramos parabólicos
%		y lineales en las trayectorias articulares formadas por tramos lineales con
%		enlaces parabólicos
%
%	[TP,TL,VL,ACSIGN] = PARABAUX(Q,AC,TIJ)
%
%	Esta función calcula la duracion de los enlaces parabólicos y de los tramos lineales.
%	Se le pasan los siguientes parámetros:
%
%	- Q:	vector que contiene los puntos inicial, intermedios y final.
%	- AC:	vector que contiene los módulos de las aceleraciones articulares deseados.
%	- TIJ:	Vector que contiene la duración de los intervalos entre puntos.
%
%	La función devuelve:
%	- TP:		vector con la duración de los enlaces parabólicos.
%	- TL:		vector con la duración de los enlaces lineales.
%	- VL:		vector con las velocidades en los enlaces lineales.
%	- ACSIGN:	vector con las aceleraciones articulares con signo.

%	Copyright (C) Iván Maza 2001

function [tp,tl,vl,acsign] = parabaux(q,ac,tij)

n = length(q);

if (n==2)
   acsign(1) = ac(1)*sign(q(2)-q(1));
   acsign(2) = ac(2)*sign(q(1)-q(2));
   if (abs(acsign(1))~=abs(acsign(2)))
      error('En el caso de tener sólo dos puntos, las aceleraciones tienen que ser iguales')
   else
      p = 4*(q(2)-q(1))/tij(1)^2;
      if ac(1)<p
         error('Aceleración pequeña')
      end
      tp(1)=tij(1)/2-(sqrt((tij(1))^2*acsign(1)^2-4*acsign(1)*(q(2)-q(1))))/(2*acsign(1));
      tb = tp(1);
      qb = q(1)+0.5*acsign(1)*tp(1)^2;
      qm = 0.5*(q(1)+q(2));
      tm = tij(1)/2;
      vl(1)=(qm-qb)/(tm-tb);
      tp(2) = tp(1);
      tl(1) = tij(1) -tp(1)-tp(2);      
   end   
else
   
   acsign(1)=ac(1)*sign(q(2)-q(1));
   p = (2*(q(2)-q(1)))/(tij(1)^2);
   if ac(1)<p
      error('Aceleración pequeña')
   end   
   tp(1)=tij(1)-sqrt(tij(1)^2-2*((q(2)-q(1))/acsign(1)));
   vl(1)=(q(2)-q(1))/(tij(1)-tp(1)/2);
   
   acsign(n)=ac(n)*sign(q(n-1)-q(n));
   p = (2*(q(n-1)-q(n)))/(tij(n-1)^2);
   if ac(n)<p
      error('Aceleración pequeña')
   end
   tp(n)=tij(n-1)-sqrt(tij(n-1)^2+2*((q(n)-q(n-1))/acsign(n)));
   vl(n-1)=(q(n)-q(n-1))/(tij(n-1)-tp(n)/2);
   
   if (n>3)
      for i=2:1:n-2
         vl(i)=(q(i+1)-q(i))/tij(i);
      end   
   end
   
   for i=2:1:n-1 
      acsign(i)=ac(i)*sign(vl(i)-vl(i-1));
      tp(i)=(vl(i)-vl(i-1))/acsign(i);   
   end
   tl(1)=tij(1)-tp(1)-tp(2)/2;
   
   for i=2:1:n-2      
      tl(i)=tij(i)-tp(i)/2-tp(i+1)/2;   
   end   
   tl(n-1)=tij(n-1)-tp(n)-tp(n-1)/2;   
end
