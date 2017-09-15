clear all
q = [10 5 20];
qd = [2 4 1];
qdd = [1 4 2];
t0 = 0; tij = [2 4];
[Qcoef,time,q_t,qd_t,qdd_t] = pol5(q,qd,qdd,t0,tij,1e-3);
subplot(3,1,1),plot(time,q_t,'k'),xlabel('Tiempo (seg)'),ylabel('q (rad)'),grid
subplot(3,1,2),plot(time,qd_t,'k'),xlabel('Tiempo (seg)'),ylabel('q'' (rad/s)'),grid
subplot(3,1,3),plot(time,qdd_t,'k'),xlabel('Tiempo (seg)'),ylabel('q'''' (rad/s^2)'),grid