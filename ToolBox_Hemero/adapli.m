%	Función-S auxiliar que se usa en el bloque Simulink "Control de inercia adaptativo"

%	Copyright (C) Iván Maza 2001

function [sys,x0,str,ts] = adapli(t,x,u,flag,dyn, gamma, a, grav)

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(dyn, gamma, a, grav);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u, dyn, gamma, a, grav);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(dyn, gamma, a, grav)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5*numrows(dyn);
sizes.NumInputs      = -1;
sizes.DirFeedthrough = -1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

global DYN_ESTIM
DYN_ESTIM = dyn;

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

sys = [];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,dyn, gamma, a, grav)

global DYN_ESTIM
global ES_VM

n = numrows(DYN_ESTIM);
qd = u(1:n)';
q = u( (n+1):(2*n) )';
ed = u( (2*n+1):(3*n) );
e = u( (3*n+1):(4*n) );
sd = u( (4*n+1):(5*n) );
s = u( (5*n+1):(6*n) );

param = DYN_ESTIM;
Y1 = [];
m = [];
for k=1:n
   eval(['q' num2str(k) ' = q(k)']);
   eval(['qd' num2str(k) ' = qd(k)']);
end

for k=1:n
   aux = param;
   aux(1:n,18:20) = 0;
   m(1:n,1)=0;
   aux(1:n,6)=0;
   m(k)=1;
   aux(k,6)=1;
   M = rnes(aux, ones(n,1)*q, zeros(n,n), eye(n), [0;0;0], [0;0;0], [0;0;0], [0;0;0]);
   for k=1:n
      eval(['m' num2str(k) ' = m(k)']);
   end
   Vm = eval(ES_VM);
   G = rnes(aux, q, zeros(size(q)), zeros(size(q)), [0;0;0], [0;0;0], [0;0;0], grav)';
   total = M*sd + Vm*s + G; 
   Y1 = [Y1 total];
end


Y2 = ((param(:,17)).^2).*qd';
Y3 = (param(:,17)).*(qd'>0);
Y4 = (param(:,17)).*(qd'<0);
Y=[Y1 diag(Y2) diag(Y3) diag(Y4)];

estim = gamma*Y'*(a*e+ed);

M = rnes(param, ones(n,1)*q, zeros(n,n), eye(n), [0;0;0], [0;0;0], [0;0;0], [0;0;0]);
m = param(:,6);
for k=1:n
   eval(['m' num2str(k) ' = m(k)']);
end
Vm = eval(ES_VM);
G = rnes(param, q, zeros(size(q)), zeros(size(q)), [0;0;0], [0;0;0], [0;0;0], grav)';
total = M*sd + Vm*s + G;

sys = [estim; total];
% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
