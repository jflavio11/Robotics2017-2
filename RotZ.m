%{
    Rotación en el eje Z
    author: joseflavio
%}
function R = RotZ(c)

cc = cos(c);
sc = sin(c);

R = [cc -sc 0 0;
     sc  cc 0 0;
     0    0 1 0;
     0    0 0 1];