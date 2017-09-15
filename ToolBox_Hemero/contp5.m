%	CONTP5	Calcula la curva que enlaza la postura del vehículo con la postura del punto
%		objetivo empleando polinomios de orden cinco
%
%	[X,Y,COEF] = CONTP5(X_V,Y_V,PHI_V,GAMMA_V,X_OB,Y_OB,PHI_OB,GAMMA_OB,STEP)
%
%	La función CONTP5 calcula las coordenadas X e Y (vectores columna) en el sistema de
%	coordenadas global de la curva que enlaza la postura del vehículo con la postura del
%	punto objetivo empleando polinomios de orden cinco.
%
%	Asimismo, también devuelve los coeficientes (vector fila COEF) del polinomio de orden
%	cinco que corresponde a la curva en el sistema de coordenadas asociado al vehículo.
%	Hay una columna para cada coeficiente, correspondiendo la primera columna a la potencia
%	quíntica y la última al término independiente.
%
%	Los parámetros X_V, Y_V, PHI_V y GAMMA_V son las coordenadas (x,y), la orientación y
%	la curvatura del vehículo respectivamente. Asimismo, Los parámetros X_OB, Y_OB, PHI_OB
%	y GAMMA_OB son las coordenadas (x,y), la orientación y la curvatura del punto objetivo
%	respectivamente.
%
%	Finalmente, el parámetro STEP permite variar el paso con el que se calculan los puntos
%	de la curva.
%
%	Para el vehículo se adopta el modelo de la bicicleta.
%
%	Hay que adoptar ciertas precauciones a la hora de emplear esta función:
%	-	El valor de PHI_OB-PHI_V debe pertenecer al intervalo (-pi/2,pi/2).
%	-	La coordenada y del punto objetivo en el sistema de referencia del vehículo debe ser
%		mayor que cero.

% Copyright (C) Iván Maza 2001

function [x,y,coef] = contp5(x_v,y_v,phi_v,gamma_v,x_ob,y_ob,phi_ob,gamma_ob,step)

if (nargin~=9)
   error('Número incorrecto de parámetros');
end

% Se hace un cambio de variables al sistema del vehículo
x_ini = 0; y_ini = 0; phi_ini = 0; gamma_ini = gamma_v;
x_f = (x_ob-x_v)*cos(phi_v)+(y_ob-y_v)*sin(phi_v);
y_f = (y_ob-y_v)*cos(phi_v)-(x_ob-x_v)*sin(phi_v);
if (y_f<=0)
   error('La coordenada y del punto objetivo en el sistema local del vehículo debe ser mayor que cero')
end
phi_f = phi_ob-phi_v;
gamma_f = gamma_ob;

if (phi_f<=-pi/2 | phi_f>=pi/2)
   error('phi_f debe estar en el intervalo (-pi/2,pi/2)');
end

% Se utiliza una constante k para simplificar las expresiones
k = - (gamma_f)/( (cos(phi_f))^3);

% Se calculan los coeficientes del polinomio de orden cinco
a0 = 0;
a1 = 0;
a2 = -(gamma_ini)/2;
a3 = (20*x_f+k*(y_f)^2+3*gamma_ini*(y_f)^2+8*y_f*tan(phi_f))/(2*(y_f)^3);
a4 = - (2*k*(y_f)^2+14*y_f*tan(phi_f)+3*gamma_ini*(y_f)^2+30*x_f)/(2*(y_f)^4);
a5 = (6*y_f*tan(phi_f)+12*x_f+(k+gamma_ini)*(y_f)^2)/(2*(y_f)^5);
coef = [a5 a4 a3 a2 a1 a0];

% Se calculan las coordenadas x e y en el sistema asociado al móvil
if y_f<0
   step = -step;
end
y_local = 0:step:y_f;
x_local = a0+a1*y_local+a2*(y_local.^2)+a3*(y_local.^3)+a4*(y_local.^4)+a5*(y_local.^5);

% Se calculan las coordenadas x e y en el sistema global
P_local = [x_local; y_local; zeros(1,length(x_local)); ones(1,length(x_local))]; 
P_global = transl(x_v,y_v,0)*rotz(phi_v)*P_local;
x = P_global(1,:)';
y = P_global(2,:)';

