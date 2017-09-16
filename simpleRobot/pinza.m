%{
    Clamb function
    To draw a clamb by the transformation matrix given as a parameter.
%}
function pinza(T)
    s = 1/8;
    
    % se dibuja la garra
    p1 = T*[0 s*2 s*1 1]';
    p2 = T*[0 s*1 s*1 1]';
    p3 = T*[0 0 0 1]';
    p4 = T*[0 s*1 s*-1 1]';
    p5 = T*[0 s*2 s*-1 1]';
    
    y = [p1(2) p2(2) p3(2) p4(2) p5(2)];
    z = [p1(3) p2(3) p3(3) p4(3) p5(3)];
    
    plot(y, z, 'g', 'linewidth', 4);
    
end
