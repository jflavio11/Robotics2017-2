clear all
q = [10 90];
qd = [0 0];
t0 = 0;
tij = 4;
[Qcoef,time,q_t,qd_t,qdd_t] = pol3(q,qd,t0,tij,0.001);
subplot(3,1,1),plot(time,q_t,'k'),xlabel('Tiempo (seg)'),ylabel('q (rad)'),grid
subplot(3,1,2),plot(time,qd_t,'k'),xlabel('Tiempo (seg)'),ylabel('q'' (rad/s)'),grid
subplot(3,1,3),plot(time,qdd_t,'k'),xlabel('Tiempo (seg)'),ylabel('q'''' (rad/s^2)'),grid