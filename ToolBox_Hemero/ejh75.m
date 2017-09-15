clear all
q = [10 90];
ac1 = [30 30]; ac2 = [80 80];
t0 = 0; tij = 4;
[Qcoef1,time1,q_t1,qd_t1,qdd_t1,intervs1] = parab(q,ac1,t0,tij,0.001);
[Qcoef2,time2,q_t2,qd_t2,qdd_t2,intervs2] = parab(q,ac2,t0,tij,0.001);

subplot(3,1,1)
plot(time1,q_t1,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q (rad)')
hold on
plot(time2,q_t2,'k--')
subplot(3,1,2)
plot(time1,qd_t1,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q'' (rad/s)')
hold on
plot(time2,qd_t2,'k--')
subplot(3,1,3)
plot(time1,qdd_t1,'k'),grid,xlabel('Tiempo (seg)'),ylabel('q'''' (rad/s^2)')
hold on
plot(time2,qdd_t2,'k--')
