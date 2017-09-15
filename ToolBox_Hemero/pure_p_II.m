%	PURE_P_II	Calcula el índice del punto del camino que está más próximo a encontrarse
%			a una distancia s (medida sobre el camino) del punto del camino más próximo
%			al vehículo
%
%	Esta función se utiliza dentro del bloque Simulink "Pure Pursuit II".

function index_obj = pure_p_II(u)

global K_ANT
global INDEX

long = (length(u)-3)/2;
x_camino = u(1:long);
y_camino = u(long+1:2*long);
x_vehiculo = u(2*long+1);
y_vehiculo = u(2*long+2);
s = u(2*long+3);
dist=sqrt( (x_camino-x_vehiculo).^2+(y_camino-y_vehiculo).^2 );
dif = abs(dist);
k = K_ANT;
dif_delante = dif(k:length(dif));
[z,indice] = min(dif_delante);
k = indice + k -1;
K_ANT = k;
index_obj = INDEX(k);

