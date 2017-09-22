path(path, '.\simpleMovs')
path(path, '.\simpleMovs\rotations')
path(path, '.\simpleMovs\denavitHartenbergMoves')
%{
    This scripts allows to apply Denavit Hartenberg algorithm using four
    degrees of liberty.
%}

teta1 = 30;
teta2 = 90;
teta4 = 45;

from0Ato1 = RotZTraslXZ(teta1, 0, 10);

% De la articulacion 1 a 2 se hace una traslación de 25cm en el eje Z y
% una rotación de 90° con respecto al eje Z. Entonces se tiene el eje Y
% apuntando hacia la izquierda y el eje X apuntando hacia adelante. Luego se
% hace una rotación de 90° con respecto al eje X en sentido horario. Por
% ende el eje Z termina apuntando hacia la derecha, el eje Y hacia arriba y
% el eje X sigue hacia adelante.
from1Ato2 = RotZTraslXZ(teta2, 0, 25) * RotXTraslXZ(teta2, 0 , 0);

% Se hace un movimiento de 20cm con respecto al eje Z.
from2Ato3 = Trasl(0, 0, 20);

from3Ato4 = RotZTraslXZ(teta4, 0, 8);

% calculamos la transformada (se multiplica en orden)
transformada = from0Ato1 * from1Ato2 * from2Ato3 * from3Ato4;

puntoInicial = [0; 0; 0; 1];
puntoFinal = transformada * puntoInicial;

