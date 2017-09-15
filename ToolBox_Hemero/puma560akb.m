
% alpha	A	theta	D	sigma	m	rx	ry	rz	Ixx	Iyy	Izz	Ixy	Iyz	Ixz	Jm	G
p560=[0 0 0 0 0 0 0 0 0 0 0 0.35 0 0 0 291e-6 -62.6111 0 0 0;
   -pi/2 0 0 0.2435 0 17.4 0.068 0.006 -0.016 .13 .524 .539 0 0 0 409e-6 107.815 0 0 0;
   0 0.4318 0 -0.0934 0 4.8 0 -0.070 0.014 .066 .0125 .066 0 0 0 299e-6 -53.7063 0 0 0;
   pi/2 -0.0203 0 .4331 0 0.82 0 0 -0.019 1.8e-3 1.8e-3 1.3e-3 0 0 0 35e-6 76.0364 0 0 0;
   -pi/2 0 0 0 0 0.34 0 0 0 .3e-3 .3e-3 .4e-3 0 0 0 35e-6 71.923 0 0 0;
   pi/2 0 0 0 0 .09 0 0 .032 .15e-3 .15e-3 .04e-3 0 0 0 35e-6 76.686 0 0 0];

%
% some useful poses
%
qz = [0 0 0 0 0 0];	% zero angles, L shaped pose
qr = [0 pi/2 -pi/2 0 0 0];	% ready pose, arm up
qstretch = [0 0 -pi/2 0 0 0];

% CINEMATICA

syms t1 t2 t3 t4 t5 t6 real

dhp560 = [0	0	0	0	0;
   -pi/2	0	0	0.2435	0;
   0	0.4318	0	-0.0934	0;
   pi/2	-0.0203	0	.4331	0;
   -pi/2	0	0	0	0;
   pi/2	0	0	0	0];

plotbot(dhp560,[0 0 (pi*35)/180 0 0 (pi*45)/180], 'fw')
pause

dh1 = [0 0 0 0 0;
   0 2 0 0 0;
   0 2 0 0 0];

plotbot(dh1,[(pi*30)/180 (pi*30)/180 0], 'fw')
pause

dh2 = [0 0 0 0 0;
   pi/2 0 0 0 1;
   0 0 0 3 0];

plotbot(dh2,[pi/4 3 (pi*50)/180], 'fw')
pause


% MODELO DIRECTO

T1 = linktrans(dhp560(1,:),t1)
disp('Pulse una tecla para continuar')
pause
T2 = linktrans(dhp560(2,:),t2)
disp('Pulse una tecla para continuar')
pause
T3 = linktrans(dhp560(3,:),t3)
disp('Pulse una tecla para continuar')
pause
T4 = linktrans(dhp560(4,:),t4)
disp('Pulse una tecla para continuar')
pause
T5 = linktrans(dhp560(5,:),t5)
disp('Pulse una tecla para continuar')
pause
T6 = linktrans(dhp560(6,:),t6)
disp('Pulse una tecla para continuar')
pause

q = [t1 t2 t3 t4 t5 t6];

%T = simple( fkine(dhp560,q) )

% MODELO INVERSO
clear all
dhp560 = [0	0	0	0	0;
   -pi/2	0	0	0.2435	0;
   0	0.4318	0	-0.0934	0;
   pi/2	-0.0203	0	.4331	0;
   -pi/2	0	0	0	0;
   pi/2	0	0	0	0];
% Establecemos la tolerancia y el número máximo de iteraciones
stol=1e-1; ilimit=1000;
% Introducimos la trayectoria (arco de radio 5) y la orientación (0 grados) deseadas
%0.2 - 0.25

x=[0.4:0.001:0.45];
y=0.1*ones(1,length(x));
z=y;
phi=zeros(1,length(x));
% Creamos la trayectoria de transformaciones

for k=1:length(x)
   TG(:,:,k) = [cos(phi(k)) -sin(phi(k)) 0 x(k);
                sin(phi(k)) cos(phi(k)) 0 y(k);
                0 0 1 z(k);
                0 0 0 1];
end
% Calculamos el modelo inverso para cada uno de los puntos de la trayectoria usando un vector
% inicial q0=[0 0 0] y una máscara [1 1 0 0 0 1]
q = ikine(dhp560,stol,ilimit,TG)
% Representamos gráficamente el manipulador mientras recorre la trayectoria
figure(1)
plotbot(dhp560,q,'wf')

