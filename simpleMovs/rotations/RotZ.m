%{
    Rotation on the Z axis. 'c' parameter is the angle given in radians.
    author: joseflavio
%}
function R = RotZ(c)

cc = cos(c);
sc = sin(c);

R = [cc -sc 0 0;
     sc  cc 0 0;
     0    0 1 0;
     0    0 0 1];