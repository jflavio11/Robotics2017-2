% Funcion que contiene el par aplicado al manipulador del Ejemplo 5.2

function tau = taucap5 (t,x)
tau=[30+(1+exp(-t))*10*sin(t);
   10+10*cos(t)];
