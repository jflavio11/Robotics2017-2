disp('Ejemplo H.6.1')
[x,y,coef] = contp5(2,3,pi/3,1,-2,6,pi/2,2,0.01);
figure(2)
plot(x,y), xlabel('X (m)'), ylabel('Y (m)'), grid
axis([-2.5 2.5 2 7])
