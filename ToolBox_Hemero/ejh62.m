clear all
disp('Persecución pura I sin considerar la dinámica del actuador')
x=0:0.01:12; y=0:0.01:12;
figure(1)
subplot(2,2,1), L=0.7; sim('ejh62a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,2), L=1.4; sim('ejh62a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,3), L=2.3; sim('ejh62a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,4), L=4; sim('ejh62a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
disp('Pulse una tecla para continuar')
pause
disp('Persecución pura I teniendo en cuenta la dinámica del actuador')
clear all
x=0:0.01:12; y=0:0.01:12;
figure(2)
subplot(2,2,1), L=0.7; sim('ejh62b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,2), L=1.4; sim('ejh62b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,3), L=2.3; sim('ejh62b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,4), L=4; sim('ejh62b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')

