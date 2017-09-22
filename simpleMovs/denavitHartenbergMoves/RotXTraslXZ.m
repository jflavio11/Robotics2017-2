%{
    Rotation on the X axis and allows translation on X and Z.
    - 'a' parameter is the angle given in radians.
    - 'x' parameter is the distance for translation on X, could be zero.
    - 'z' parameter is the distance for translation on Z, could be zero.
    author: joseflavio
%}
function R = RotXTraslXZ(a, x, z)

ca = cosd(a);
sa = sind(a);

R = [1  0  0  x;
     0 ca -sa 0;
     0 sa  ca z;
     0  0   0 1]; 