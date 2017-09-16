%{
    For translation on X, Y, Z given by parameters a, b, c
    author: joseflavio
%}
function T = Trasl(a,b,c)

T = [1 0 0 a;
     0 1 0 b;
     0 0 1 c;
     0 0 0 1];