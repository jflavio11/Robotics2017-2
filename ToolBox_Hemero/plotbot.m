% PLOTBOT	Representa gráficamente el manipulador
%
%	PLOTBOT(DH, Q)
%	PLOTBOT(DH, Q, OPT)
%
%	Esta función construye una representación gráfica del robot, a partir de los
%	parámetros cinemáticos contenidos en DH y de los valores de las variables ar-
%	ticulares (Q) que se le pasen.
%
%	Se trata de una representación gráfica simple en la que cada enlace se modela
%	mediante un paralelepípedo de color cián. El sistema de coordenadas asociado
%	al efector final se representa en color verde, mientras que los sistemas de
%	coordenadas asociados a cada una de las articulaciones intermedias se repre-
%	sentan en color rojo.
%
%	Si el parámetro Q es una matriz que representa una trayectoria en el espacio de
%	las variables articulares (es decir, que contiene en cada fila el conjunto de
%	variables articulares del robot), entonces el resultado es una animación del
%	robot siguiendo dicha trayectoria.
%
%	El parámetro OPT será una cadena en la que se especificarán las opciones de
%	representación que se deseen de entre las siguientes:
%
%	d	Establece que la representación se muestre en 2D (sobre el plano XY).
%	f	Dibujar los cuadros de referencia asociados a cada articulación.
%	l	No borrar el robot en cada paso si se trata de una animación.
%	r	Repetir la animación 50 veces.
%	w	Dibujar el sistema de referencia asociado al efector final.
%
%	Si no se usa el parámetro OPT se hace la representación convencional.
%
%	Por ejemplo mediante PLOTBOT(DH, Q, 'dw') se especificaría que la representa-
%	ción fuera en dos dimesiones y que se representara el sistema de referencia
%	asociado al efector final.

%	Ver también DH, FKINE.

%	Copyright (C) Iván Maza 2001

function plotbot(dh, q, opt)
	np = numrows(q);
	n = numrows(dh);

	if numcols(q) ~= n,
		error('Número insuficiente de columnas en Q')
	end

	erasemode = 'normal';
   wrist = 0;
   fram = 0;
	repeat = 1;
   flag1=0;
   flag2=0;
   

	% opciones   
	if nargin == 3,
		mopt = size(opt,2);
		for i=1:mopt,
			if (opt(i) == 'l'), erasemode = 'none'; flag2=1; end;
         if (opt(i) == 'w'), wrist = 1; end;
         if (opt(i) == 'f'), fram = 1; end;
         if (opt(i) == 'r'), repeat = 50; end;
         if (opt(i) == 'd'), flag1=1; end;
		end;
	end;
   
	% Se usa una regla simple para calcular el máximo alcance del robot
	reach = sum(abs(dh(:,2))) + sum(abs(dh(:,4)));
	mag = reach/8;
   
   [xbase, ybase, zbase] = cylinder([mag/4 0], 20);
   zbase = mag*zbase - mag;
   hdlbase = surf(xbase, ybase, zbase);
   
   for j=1:n-1
      hdl1(j)=patch; % Se inicializan los "manejadores" de los enlaces
   end
   
   if wrist,	% Si se representa el efector final, se inicializan los "manejadores" correspondientes
		hdl2(1)=patch; hdl2(2)=patch;
      etiq1(1)=text('String','X');
      etiq1(2)=text('String','Y');
      etiq1(3)=text('String','Z');
	end
   
   if fram,		% Si se representan los cuadros de referencia, se inicializan los "manejadores" correspondientes
      for j=1:2*n-2
         hdl3(j)=patch;
      end
      for j=1:n-1
         etiq2(j,1)=text('String','X');
      	etiq2(j,2)=text('String','Y');
         etiq2(j,3)=text('String','Z');
      end
   end
   
 	% Se inicializan los ejes para animar el robot  
   axis([-reach reach -reach reach -reach reach]);
   set(gcf,'renderer','zbuffer')
	figure(gcf);
	xlabel('X')
	ylabel('Y')
	zlabel('Z')
	set(gca, 'drawmode', 'fast');

   
   for r=1:repeat,
	    for p=1:np,
          % Para cada punto de la trayectoria se calculan las transformaciones, y se guarda 
          % el origen de cada cuadro para la animación
          
          t = eye(4);

          for j=1:n-1,
             t = t * linktrans(dh(j,:), q(p,j));
             tsig = t * linktrans(dh(j+1,:), q(p,j+1));
             xvec=tsig(1,4)-t(1,4);
             yvec=tsig(2,4)-t(2,4);
             zvec=tsig(3,4)-t(3,4);
             l=sqrt( xvec^2+yvec^2+zvec^2 );
             if l~=0
                col1=(1/l)*[xvec;yvec;zvec];
                a=col1(1);
                b=col1(2);
                c=col1(3);
             else 
                col1=[1;0;0];
                col2=[0;1;0];
             end
             if col1==[0;1;0]
                col2=[1;0;0];
             else
                col2=[(-c)/(sqrt(a^2+c^2)); 0; a/(sqrt(a^2+c^2))];
             end
             
             col3 = cross(col1,col2);
             trans=[col1(1) col2(1) col3(1) t(1,4);
                col1(2) col2(2) col3(2) t(2,4);
                col1(3) col2(3) col3(3) t(3,4);
                0 0 0 1];
             
             if fram,	% Se dibujan los cuadros si el usuario lo especifica
                if flag2==1
                	[hdl3(2*j-1:2*j), etiq2(j,:)] = auxframe(t,mag,hdl3(2*j-1:2*j),etiq2(j,:),'r',1);
                else
                	[hdl3(2*j-1:2*j), etiq2(j,:)] = auxframe(t,mag,hdl3(2*j-1:2*j),etiq2(j,:),'r');
                end
             end
             
             
             % Se dibujan los enlaces del manipulador
             if flag2==1
                hdl1(j)=enlace(trans,l,hdl1(j),mag,'l');
             else
                hdl1(j)=enlace(trans,l,hdl1(j),mag);
             end
          end
          
          if wrist,
             % Se dibuja el sistema asociado al efector final
             if flag2==1
                [hdl2, etiq1]=auxframe(tsig,mag,hdl2,etiq1,'g',1);
             else
                [hdl2, etiq1]=auxframe(tsig,mag,hdl2,etiq1,'g');
             end   
          end

          if (flag1==1)
             view(2) % Se establece la vista 2D del plano XY
          end
          drawnow
       end
    end
 