disp('Ejemplo del uso de la función ikine')
clear all
t1=0; t2=0; t3=0; % Estos valores de t1, t2 y t3 son irrelevantes
l1=4; l2=3;
% Se crea la matriz dh con los parámetros del manipulador
dh = [0 0	t1 0 0;
		0 l1	t2 0 0;
		0 l2	t3 0 0];
% Se establecen la tolerancia y el número máximo de iteraciones
stol=1e-6; ilimit=1000;
% Se introduce la trayectoria (arco de radio 5) y la orientación (0 grados) deseadas
x=[0:0.2:5];
y=sqrt(25-x.^2);
phi=zeros(1,length(x));
% Se crea la trayectoria de transformaciones

for k=1:length(x)
   TG(:,:,k) = [cos(phi(k)) -sin(phi(k)) 0 x(k);
                sin(phi(k)) cos(phi(k)) 0 y(k);
                0 0 1 0;
                0 0 0 1];
end

% Se calcula el modelo inverso para cada uno de los puntos de la trayectoria usando un vector
% inicial q0=[0 0 0] y una máscara [1 1 0 0 0 1]
q=ikine(dh,stol,ilimit,TG,[0 0 0],[1 1 0 0 0 1])

% Se representa gráficamente el manipulador mientras recorre la trayectoria
plotbot(dh,q,'lfdw')
