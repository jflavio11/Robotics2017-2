% TRIREP Función que permite representar gráficamente el modelo del triciclo clásico
%
%	TRIREP(X,Y,PHI,ALPHA,COLOR,B,L,C,NP,OPT)
%
%	Esta función se encarga de generar una representación gráfica simple del triciclo clásico a partir
%	de las coordenadas del centro de guiado (X,Y), de la orientación del vehículo (PHI) y de la orien-
%	tación de la rueda delantera del vehículo (ALPHA). Los valores de X, Y, PHI y ALPHA pueden ser
%	vectores, en cuyo caso se representarán tantos puntos de la trayectoria como indique el parámetro
%	NP. En este caso, es posible especificar que aparezcan simultáneamente todas esas representaciones
%	en pantalla dando un valor cualquiera al parámetro OPT. Si no se introduce dicho parámetro, las
%	representaciones aparecen y desaparecen sucesivamente, y al final solamente queda la última en
%	pantalla.
%
%	Las dimensiones de la representación gráfica vienen determinadas por los siguientes parámetros:
%	-	B: es la separación entre las dos ruedas traseras.
%	-	L: es la separación entre la rueda delantera y las traseras.
%	-	C: es el radio de las ruedas.
%
%	El color de la representación se especifica mediante el parámetro COLOR

%	Copyright (C) Iván Maza 2001

function h = trirep(x, y, phi, alpha, color, a, l, c, np, opt)

hdl(1) = patch; hdl(2) = patch;
puntos = length(x);
w = a/4;

% Se especifica la geometría de las ruedas traseras y la transmisión
datosx1=[-a-w/2	-a+w/2	-a+w/2	-w/4	-w/4	w/4	w/4	a-w/2	a-w/2	a+w/2	a+w/2	a-w/2	a-w/2	-a+w/2  -a+w/2	-a-w/2];
datosy1=[c			c			c/16		c/16	l		l		c/16	c/16	c		c		-c		-c		-c/16	-c/16	  -c		-c];
datosz1=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
unos1=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
link1=[datosx1;datosy1;datosz1;unos1];
lfs1=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];

% Se especifica la geometría de la rueda delantera
datosx2=[-w/2	w/2	w/2	-w/2];
datosy2=[c		c		-c		-c];
datosz2=[0 0 0 0];
unos2=[1 1 1 1];
link2=[datosx2;datosy2;datosz2;unos2];
lfs2=[1 2 3 4];


step = floor(puntos/np);
if (step==0)
   error('No hay suficientes datos para generar ese número de puntos');
end

for (k=1:step:step*np)
   % Se le da la orientación correcta al vehículo
   T1 = transl(x(k),y(k),0)*rotz(phi(k));   
   li1=T1*link1;
   % Se le da la orientación adecuada a la rueda delantera
   T2 = transl([-l*sin(phi(k)) l*cos(phi(k)) 0])*transl(x(k),y(k),0)*rotz(alpha(k))*rotz(phi(k));
	li2=T2*link2;   
	if (nargin==10)
		erasemode='none';
		% Se dibujan todas las representaciones juntas
		set(hdl(1),'faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
		set(hdl(2),'faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
		patch('faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
		patch('faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
	else
   	erasemode='normal';
   	% Se dibujan las representaciones secuencialmente
   	set(hdl(1),'faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
   	set(hdl(2),'faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
	end
end
   
h=hdl;