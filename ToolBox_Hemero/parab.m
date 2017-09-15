%	PARAB	Calcula las trayectorias articulares resultantes de emplear funciones lineales
%		con enlace parabólico
%
%	[QCOEF,TIME,Q_T,QD_T,QDD_T,INTERVS] = PARAB (Q,AC,T0,TIJ,STEP)
%
%	Los parámetros de la función son:
%
%	- Q:	matriz con tantas filas como articulaciones, que contiene en cada columna las
%		posiciones articulares deseadas para el punto inicial,los puntos de paso y el
%		punto final.
%	- AC:	matriz con tantas filas como articulaciones, que contiene en cada columna los
%		módulos de las aceleraciones articulares deseados para el punto inicial,los
%		puntos de paso y el punto final.
%	- T0:	parámetro que contiene el instante inicial
%	- TIJ:	Vector que contiene la duración de los intervalos entre puntos.
%	- STEP:	Paso con el que se calculan la posición, velocidad y aceleración resultantes.
%
%	Esta función devuelve:
%
%	- QCOEF		matriz de tres dimensiones, que contiene en cada fila los coeficientes
%			de los polinomios de orden dos, que son solución para cada una de las
%			variables articulares. La primera columna se corresponde con la potencia
%			cuadrática y la última con el término independiente. Para los tramos
%			lineales, el término cuadrático es nulo. El tercer índice de la matriz
%			hace referencia a la articulación a la que le corresponden los coefi-
%			cientes.
%	- TIME		vector tiempo con los instantes para los que se calculan las matrices
%			Q_T, QD_T y QDD_T que contienen los valores de la posición, velocidad
%			y aceleración articular resultantes.
%	- Q_T		matriz que contiene en cada fila los valores de posición correspondientes
%			a cada articulación.
%	- QD_T		matriz que contiene en cada fila los valores de velocidad correspondientes
%			a cada articulación.
%	- QDD_T		matriz que contiene en cada fila los valores de aceleración correspondientes
%			a cada articulación.
%	- INTERVS	matriz que contiene en cada fila las duraciones de los tramos parabólicos
%			y lineales para cada articulación.

%	Copyright (C) Iván Maza 2001


function [Qcoef,time,q_t,qd_t,qdd_t,intervs] = parab(q,ac,t0,tij,step)

l = length(tij);
[h,n] = size(q);
[o,m] = size(ac);
if (n~=m) | (o~=h)
   error('Las dimensiones de las matrices de especificación de posición y aceleración deben ser idénticas')
end
if (l~=n-1)
   error('La dimensión del vector con la duración de los intervalos no es correcta')
end

for w=1:h
	qaux = q(w,:);
	acaux = ac(w,:);
	[tp,tl,vl,a] = parabaux(qaux,acaux,tij);
	intervaux=[];
	for x=1:1:(n-1)
   	intervaux = [intervaux tp(x) tl(x)];
	end
   intervaux = [intervaux tp(x+1)];
   intervs(w,:) = intervaux;
	t = t0;
	tfinal = t0 + sum (tij);
	time = t0:step:tfinal;
	pal1 = a(1)/2;
	pal2 = vl(1)-a(1)*(t0+intervaux(1));
	pal3 = qaux(1) - pal2*t0 - pal1*t0^2;
	Qcoef(1,:,w) = [pal1 pal2 pal3]; 
   
   k = 1;
	qt = [];
	qdt = [];
	qddt = [];

	while (time(k)<t+intervaux(1))
   	qt(k) = sum(Qcoef(1,:,w).*[time(k)^2 time(k) 1]);
   	qdt(k) = sum(Qcoef(1,:,w).*[time(k)*2 1 0]);
   	qddt(k) = sum(Qcoef(1,:,w).*[2 0 0]);
   	k = k+1;
	end

	t = t + intervaux(1);
	aux = sum(Qcoef(1,:,w).*[t^2 t 1]);

	if (n>2)
   	for i=2:2:2*n-4
      	lin1 = 0;
      	lin2 = vl(i/2);
      	lin3 = aux - lin2*t;
      	Qcoef(i,:,w) = [lin1 lin2 lin3];
      	while (time(k)<t+intervaux(i))
         	qt(k) = sum(Qcoef(i,:,w).*[time(k)^2 time(k) 1]);
         	qdt(k) = sum(Qcoef(i,:,w).*[time(k)*2 1 0]);
         	qddt(k) = sum(Qcoef(i,:,w).*[2 0 0]);
         	k = k+1;
      	end   
      	t = t + intervaux(i);
         aux = sum(Qcoef(i,:,w).*[t^2 t 1]);
         
      	pal1 = a(i/2+1)/2;
      	pal2 = vl(i/2) - a(i/2+1)*t;
      	pal3 = aux - pal2*t-pal1*t^2;
      	Qcoef(i+1,:,w) = [pal1 pal2 pal3];   
      	while (time(k)<t+intervaux(i+1))
         	qt(k) = sum(Qcoef(i+1,:,w).*[time(k)^2 time(k) 1]);
         	qdt(k) = sum(Qcoef(i+1,:,w).*[time(k)*2 1 0]);
         	qddt(k) = sum(Qcoef(i+1,:,w).*[2 0 0]);      
         	k = k+1;
      	end
      	t = t + intervaux(i+1);
      	aux = sum(Qcoef(i+1,:,w).*[t^2 t 1]);
      
   	end
	else
   	i = 0;
	end


	i = i+2;

	lin1 = 0;
	lin2 = vl(i/2);
	lin3 = aux - lin2*t;
	Qcoef(i,:,w) = [lin1 lin2 lin3];
	while (time(k)<t+intervaux(i))
   	qt(k) = sum(Qcoef(i,:,w).*[time(k)^2 time(k) 1]);
   	qdt(k) = sum(Qcoef(i,:,w).*[time(k)*2 1 0]);
   	qddt(k) = sum(Qcoef(i,:,w).*[2 0 0]);   
   	k = k+1;
	end   
	t = t + intervaux(i);
	aux = sum(Qcoef(i,:,w).*[t^2 t 1]);

	pal1 = a(i/2+1)/2;
	pal2 = vl(i/2) - a(i/2+1)*t;
	pal3 = qaux(i/2+1)-pal2*(t+intervaux(i+1))-pal1*(t+intervaux(i+1))^2;
	Qcoef(i+1,:,w) = [pal1 pal2 pal3];

	while (time(k)<t+intervaux(i+1))
   	qt(k) = sum(Qcoef(i+1,:,w).*[time(k)^2 time(k) 1]);
   	qdt(k) = sum(Qcoef(i+1,:,w).*[time(k)*2 1 0]);
   	qddt(k) = sum(Qcoef(i+1,:,w).*[2 0 0]);   
   	k = k+1;
	end

	qt(k) = sum(Qcoef(i+1,:,w).*[time(k)^2 time(k) 1]);
	qdt(k) = sum(Qcoef(i+1,:,w).*[time(k)*2 1 0]);
   qddt(k) = sum(Qcoef(i+1,:,w).*[2 0 0]);
   
   q_t(w,:) = qt;
   qd_t(w,:) = qdt;
   qdd_t(w,:) = qddt;
end



