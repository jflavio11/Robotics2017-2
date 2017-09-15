%RNES	Calcula el modelo dinámico completo del manipulador mediante el método recursivo de Newton-Euler.
%
%	TAU = RNES(DYN, Q, QD, QDD, W0, WD0, VD0)
%	TAU = RNES(DYN, [Q QD QDD], W0, WD0, VD0)
%
%	TAU = RNES(DYN, Q, QD, QDD, W0, WD0, VD0, GRAV)
%	TAU = RNES(DYN, [Q QD QDD], W0, WD0, VD0, GRAV)
%
%	TAU = RNES(DYN, Q, QD, QDD, W0, WD0, VD0, GRAV, FEXT)
%	TAU = RNES(DYN, [Q QD QDD], W0, WD0, VD0, GRAV, FEXT)
%
%	La función RNES se encarga de calcular las ecuaciones del movimiento para proporcionar el par 
%	total en función de la posición, velocidad y aceleración articulares.
%
%	Si Q, QD y QDD son vectores fila, el par TAU es un vector fila. En el caso de que Q, QD y QDD
%	sean matrices, cada fila se interpretará como un vector de posiciones/velocidades/aceleraciones
%	articulares y el resultado será una matriz TAU en la que cada fila tendrá el par correspondiente.
%
%	W0, WD0 y VD0 son vectores que contienen respectivamente la velocidad angular, la aceleración
%	angular y la aceleración lineal de la base del robot manipulador.
%
%	El vector aceleración de la gravedad deseado se le puede pasar en el parámetro GRAV. Si no se le
%	da este parámetro, se toma por defecto una aceleración de 9.81 m/s2 en la dirección y sentido del
%	vector -Z.
%
%	También es posible especificar una fuerza/momento externo actuando al final del manipulador mediante
%	un vector de 6 elementos FEXT = [Fx Fy Fz Mx My Mz] expresado en el sistema de referencia del
%	efector final.
%
%	El par total que devuelve la función también contiene términos debidos a la inercia de la armadura
%	y a las fricciones. Dichos términos se calculan a partir de ciertos parámetros de la matriz DYN y
%	mediante el modelo que se emplea en la función FRICTION.
%
%	Ver también CORIOLIS, DYN, GRAVITY, INERTIA.

%	Copyright (C)	Peter Corke 1999
%						Iván Maza 2001

function tau = rnes(dh_dyn, a1, a2, a3, a4, a5, a6, a7, a8)
	z0 = [0;0;1];
	grav = 9.81*z0;
	fext = zeros(6, 1);
   
	n = numrows(dh_dyn);
	if numcols(a1) == 3*n,
		Q = a1(:,1:n);
		Qd = a1(:,n+1:2*n);
		Qdd = a1(:,2*n+1:3*n);
		np = numrows(Q);
		if nargin >= 6,	
			grav = -a5(:);
		end
		if nargin == 7,
			fext = a6(:);
      end
      wini = a2(:);
      wdini = a3(:);
      vdini = grav + a4(:);
	else
		np = numrows(a1);
		Q = a1;
		Qd = a2;
		Qdd = a3;
		if numcols(a1) ~= n | numcols(Qd) ~= n | numcols(Qdd) ~= n | ...
			numrows(Qd) ~= np | numrows(Qdd) ~= np,
			error('bad data');
		end
		if nargin >= 8,	
			grav = -a7(:);
		end
		if nargin == 9,
			fext = a8(:);
      end
      wini = a4(:);
      wdini = a5(:);
      vdini = grav + a6(:);
	end
	
	%
	% asignación a variables locales de las masas, centros de masas y matrices de inercia
	%
	m = dh_dyn(:,6);	% vector columna para las masas de los enlaces
	Pc = dh_dyn(:,7:9);	% matriz con los centros de masas; una fila por enlace
	Jm = [];
	for j=1:n,
		% se crea la matriz simétrica de inercia de los enlaces a partir de los datos de DYN
		J = [	dh_dyn(j,10) dh_dyn(j,13) dh_dyn(j,15); ...
			dh_dyn(j,13) dh_dyn(j,11) dh_dyn(j,14); ...
			dh_dyn(j,15) dh_dyn(j,14) dh_dyn(j,12)	];

		% se crea una matriz pseudo 3D 
		Jm = [Jm J];
	end
   
   % fricciones
   b = dh_dyn(:,18);
   tcp = dh_dyn(:,19);
   tcm = dh_dyn(:,20);
   % se refieren los valores de fricción a los enlaces
   b = b.*(dh_dyn(:,17).^2);
   tcp = tcp.*dh_dyn(:,17);
   tcm = tcm.*dh_dyn(:,17);
   
	for p=1:np,
		q = Q(p,:)';
		qd = Qd(p,:)';
		qdd = Qdd(p,:)';
	
		Fm = [];
		Nm = [];
		Pm = [];
		Rm = [];
		w = wini;
		wd = wdini;
		vd = vdini;

	%
	% se inicializan algunas variables y se calculan las matrices de rotación de los enlaces
	%
		for j=1:n,
			alpha = dh_dyn(j,1);
			A = dh_dyn(j,2);
			if dh_dyn(j,5) == 0,
				theta = q(j);
				D = dh_dyn(j,4);
			else
				theta = dh_dyn(j,3);
				D = q(j);
			end
		   sa = sin(alpha); ca = cos(alpha);
			st = sin(theta); ct = cos(theta);
 
			%
			% matrices de rotación de los enlaces: (i-1)/i R
			%    
			R = [   ct      -st     0
				st*ca   ct*ca   -sa
				st*sa   ct*sa   ca];

			% otra matriz pseudo 3D
			% el i-ésimo elemento es (i-1)/i R
			Rm = [Rm R];
			P = [A; -D*sa; D*ca];	% (i-1) P i
			Pm = [Pm P];
		end

	%
	%  las iteraciones hacia adelante
	%
		for i=0:(n-1),
			R = Rm(:,3*i+1:3*i+3)';	% (i+1)/i R
			P = Pm(:,i+1);		% i/P/(i+1)

			%
			% las variables con subrayado indican nuevos valores
			%
			if dh_dyn(i+1,5) == 0,
				% articulación de rotación
				w_ = R*w + z0*qd(i+1);
				wd_ = R*wd + cross(R*w,z0*qd(i+1)) + z0*qdd(i+1);
				vd_ = R * (cross(wd,P) + ...
					cross(w, cross(w,P)) + vd);

			else
				% articulación prismática
				w_ = R*w;
				wd_ = R*wd;
				vd_ = R*(cross(wd,P) + ...
               cross(w,cross(w,P)) + vd) + ...
               2*(cross(w_,z0*qd(i+1))) + z0*qdd(i+1);
			end
			% se actualizan variables
			w = w_;
			wd = wd_;
			vd = vd_;

			J = Jm(:,3*i+1:3*i+3);
			vdhat = cross(wd,Pc(i+1,:)') + ...
				cross(w,cross(w,Pc(i+1,:)')) + vd;
			F = m(i+1)*vdhat;
			N = J*wd + cross(w,J*w);
			Fm = [Fm F];
			Nm = [Nm N];
		end

	%
	%  iteraciones hacia atrás
	%

		f = fext(1:3);		% fuerzas/momentos al final del brazo
		nn = fext(4:6);

		for i=n:-1:1,
			
			%
         % el orden de estas sentencias es importante, ya que tanto nn como f dependen de
         % valores anteriores de f
			%
			
			if i == n,
				R = eye(3);
				P = [0;0;0];
			else
				R = Rm(:,3*i+1:3*i+3);	% i/(i+1) R
				P = Pm(:,i+1);		% i/P/(i+1)
			end
			f_ = R*f + Fm(:,i);
			nn_ = Nm(:,i) + R*nn + cross(Pc(i,:)',Fm(:,i)) + ...
				cross(P,R*f);
			
			f = f_;
         nn = nn_;
                                         
			if dh_dyn(i,5) == 0,
				% articulación de rotación
            tau(p,i) = nn'*z0 + dh_dyn(i,16)*qdd(i)*dh_dyn(i,17)^2;
			else
				% articulación prismática
            tau(p,i) = f'*z0 + dh_dyn(i,16)*qdd(i)*dh_dyn(i,17)^2;
         end
		end

      tau(p,:) = tau(p,:) + qd'*diag(b) + (qd'>0)*diag(tcp) + (qd'<0)*diag(tcm); 
        
   end
	