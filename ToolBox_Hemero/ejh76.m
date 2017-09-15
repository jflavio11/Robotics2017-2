clear all
q = [0 10 5];
ac = [40 40 40];
t0 = 0; tij = [1 1];
[Q,time,q_t,qd_t,qdd_t,intervs] = parab(q,ac,t0,tij,0.001);

subplot(3,1,1)
plot(time,q_t,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q (rad)')
subplot(3,1,2)
plot(time,qd_t,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q'' (rad/s)')
subplot(3,1,3)
plot(time,qdd_t,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q'''' (rad/s^2)')
axis([0 2 -50 50])
