function xd = fdyn2(t, x)
	global	FDYN_DYN FDYN_TORQFUN ACEL_GRAV

	n = numrows(FDYN_DYN);
	if isstr(FDYN_TORQFUN)
      tau = feval(FDYN_TORQFUN, t, x);
   else
		tau = zeros(n,1);
	end
   grav = ACEL_GRAV;
      
	qdd = accel(FDYN_DYN, x(1:n,1), x(n+1:2*n,1), tau, grav);
	xd = [x(n+1:2*n,1); qdd];
