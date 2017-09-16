%{
    Rotation on the X axis. 'a' parameter is the angle given in radians.
    author: joseflavio
%}
function R = RotX(a)

ca = cos(a);
sa = sin(a);

R = [1  0  0  0;
     0 ca -sa 0;
     0 sa  ca 0;
     0  0   0 1]; 