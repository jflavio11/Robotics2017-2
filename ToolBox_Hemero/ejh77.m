clear all
T1=eye(4);
T2=transl(2,4,3)*rotz(pi/2)*T1;
TT=trinterp(T1,T2,0.01);
frame(TT,'c',1,1);
