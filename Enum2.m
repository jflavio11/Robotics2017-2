path(path, '.\ToolBox_Hemero')
path(path, '.\simpleMovs')
path(path, '.\simpleMovs\rotations')
%{
    Obtener la matriz de transformación que representa las siguientes transformaciones 
    sobre un sistema OXYZ fijo de referencia: traslación de un vector pxyz(-3,10,10);
    giro de –90° sobre el eje ‘OU del sistema trasladado y un giro de 90°sobre 
    el eje O’V del sistema girado.


    Nota: como el movimiento no es con respecto a un sistema quieto (OXYZ),
    sino móvil (OUVW), se ejecuta el movimiento en el orden del enunciado.
%}

% se define en orden las funciones
noventa = pi/2;
mNoventa = -pi/2;
init = [8; -4; 12; 1];

% ejecutamos el movimiento
r_uvw = transl(-3, 10, 10);
giro1 = RotX(mNoventa);
giro2 = RotY(noventa);

% la matriz homogenea que se usara para graficar el eje final
mHom = r_uvw * giro1 * giro2;

% empezamos a graficar, colocamos el sistema en TA (oxyz)
TA = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
r_uvw = r_uvw*TA;

% vector resultande, posición final del eje con respecto a OXYZ
vRultante = mHom * init;

% graficamos nuestro sistema de referencia en 0,0,0
figure;
frame(TA, 'b', 10)

% ahora graficamos ouvw
% se grafica la traslación
% frame(r_uvw, 'r', 5);

% ahora se grafica la posición final del eje rotado
frame(mHom, 'y', 5);

axis([-35 35 -1 35 -1 35])

% para poder girar el plano 3d
rotate3d
grid

