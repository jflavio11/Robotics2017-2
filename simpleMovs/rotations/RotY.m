%{
    Rotation on the Y axis. 'b' parameter is the angle given in radians.
%}
function R = RotY(b)

cb = cos(b);
sb = sin(b);

R = [cb 0 sb 0;
     0  1  0 0;
    -sb 0 cb 0;
     0  0  0 1];   