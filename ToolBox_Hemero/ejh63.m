clear all
disp('Persecución pura II sin considerar la dinámica del actuador')
x=0:0.01:12; y=0:0.01:12;
figure(1)
subplot(2,2,1), s=0.7; sim('ejh63a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,2), s=1.4; sim('ejh63a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,3), s=2.3; sim('ejh63a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,4), s=4; sim('ejh63a');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
disp('Pulse una tecla para continuar')
pause
disp('Persecución pura II teniendo en cuenta la dinámica del actuador')
clear all
x=0:0.01:12; y=0:0.01:12;
figure(2)
subplot(2,2,1), s=0.7; sim('ejh63b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,2), s=1.4; sim('ejh63b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,3), s=2.3; sim('ejh63b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')
clear x_v y_v
subplot(2,2,4), s=4; sim('ejh63b');plot(x,y,x_v,y_v,'k'); grid, axis([0 8 0 8]), xlabel('X (m)'), ylabel('Y (m)')

