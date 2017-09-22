%{
    Rotation on the Z axis and allows translation on X and Z.
    - 'c' parameter is the angle given in radians.
    - 'x' parameter is the distance for translation on X, could be zero.
    - 'z' parameter is the distance for translation on Z, could be zero.
    author: joseflavio
%}
function R = RotZTraslXZ(c, x, z)

cc = cosd(c);
sc = sind(c);

R = [cc -sc 0 x;
     sc  cc 0 0;
     0    0 1 z;
     0    0 0 1]; 
