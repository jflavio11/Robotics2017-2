%RNE	Calcula el modelo dinámico completo del manipulador mediante el método recursivo de Newton-Euler.
%
%	TAU = RNE(DYN, Q, QD, QDD)
%	TAU = RNE(DYN, [Q QD QDD])
%
%	TAU = RNE(DYN, Q, QD, QDD, GRAV)
%	TAU = RNE(DYN, [Q QD QDD], GRAV)
%
%	TAU = RNE(DYN, Q, QD, QDD, GRAV, FEXT)
%	TAU = RNE(DYN, [Q QD QDD], GRAV, FEXT)
%
%	La función RNE se encarga de calcular las ecuaciones del movimiento para proporcionar el par 
%	total en función de la posición, velocidad y aceleración articulares.
%
%	Si Q, QD y QDD son vectores fila, el par TAU es un vector fila. En el caso de que Q, QD y QDD
%	sean matrices, cada fila se interpretará como un vector de posiciones/velocidades/aceleraciones
%	articulares y el resultado será una matriz TAU en la que cada fila tendrá el par correspondiente.
%
%	El vector aceleración de la gravedad deseado se le puede pasar en el parámetro GRAV. Si no se le
%	da este parámetro, se toma por defecto una aceleración de 9.81 m/s2 en dirección -Z.
%
%	También es posible especificar una fuerza/momento externo actuando al final del manipulador mediante
%	un vector de 6 elementos FEXT = [Fx Fy Fz Mx My Mz] expresado en el sistema de referencia del
%	efector final.
%
%	El par total que devuelve la función también contiene términos debidos a la inercia de la armadura
%	y a las fricciones. Dichos términos se calculan a partir de ciertos parámetros de la matriz DYN
%	mediante el modelo que se presenta en la descripción de la función FRICTION.
%
%	Ver también CORIOLIS, DYN, GRAVITY, INERTIA.

%	Copyright (C)	Peter Corke 1999
%						Iván Maza 2001

function tau = rne(dh_dyn, a1, a2, a3, a4, a5)
	z0 = [0;0;1];
	grav = 9.81*z0;
	fext = zeros(6, 1);
   
	n = numrows(dh_dyn);
	if numcols(a1) == 3*n,
		Q = a1(:,1:n);
		Qd = a1(:,n+1:2*n);
		Qdd = a1(:,2*n+1:3*n);
		np = numrows(Q);
		if nargin >= 3,
			grav = -a2(:);
		end
		if nargin == 4,
			fext = a3(:);
      end
	else
		np = numrows(a1);
		Q = a1;
		Qd = a2;
		Qdd = a3;
		if numcols(a1) ~= n | numcols(Qd) ~= n | numcols(Qdd) ~= n | ...
			numrows(Qd) ~= np | numrows(Qdd) ~= np,
			error('bad data');
		end
		if nargin >= 5,	
			grav = -a4(:);
		end
		if nargin == 6,
			fext = a5(:);
      end
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
		w = [0; 0; 0];
		wd = [0; 0; 0];
      vd = grav;
      
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

      if length(class(qd))==3
         if class(qd)=='sym'
            for x=1:length(qd)
               if tcp(x)~=0 & tcm(x)~=0
                  sigfric(x) = sym(sprintf('tc%s*signo(%s)',num2str(x),char(qd(x))));
               else
                  sigfric(x) = 0;
               end
            end
            tau(p,:) = tau(p,:) + qd'*diag(b) + sigfric;
         else
            tau(p,:) = tau(p,:) + qd'*diag(b) + (qd'>0)*diag(tcp) + (qd'<0)*diag(tcm);
         end
      else
         tau(p,:) = tau(p,:) + qd'*diag(b) + (qd'>0)*diag(tcp) + (qd'<0)*diag(tcm); 
      end
      
   end
