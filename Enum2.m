path(path, 'D:\robotica\robotica02\ToolBox_Hemero')
%{
    Obtener la matriz de transformaci�n que representa las siguientes transformaciones 
    sobre un sistema OXYZ fijo de referencia: traslaci�n de un vector pxyz(-3,10,10);
    giro de �90� sobre el eje �OU del sistema trasladado y un giro de 90�sobre 
    el eje O�V del sistema girado.
%}

% se define en orden las funciones
noventa = pi/2;
mNoventa = -pi/2;
init = [8; -4; 12; 1];

% ejecutamos el movimiento
r_uvw = transl(-3, 10, 10);
giro1 = RotX(mNoventa);
giro2 = RotZ(noventa);

% la matriz homogenea que se usara para graficar el eje final
mHom = r_uvw * giro1 * giro2;

% empezamos a graficar, colocamos el sistema en TA (oxyz)
TA = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
r_uvw = r_uvw*TA;

% vector resultande, posici�n final del eje
vRultante = mHom * init;

figure;
% graficamos nuestro sistema de referencia en 0,0,0
frame(TA, 'b', 5)

% ahora graficamos ouvw
% se grafica la traslaci�n
% frame(r_uvw, 'r', 5);

% ahora se grafica la posici�n final del eje rotado
frame(mHom, 'y', 5);

axis([-35 35 -1 35 -1 35])

% para poder girar el plano 3d
rotate3d
grid
