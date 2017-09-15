%	Función-S correspondiente al bloque "Término Vm de Coriolis" para el
%	caso de robots manipuladores con base fija. Emplea una variable global
%	llamada VM.

%	Copyright (C)	2001 Iván Maza

function [sys,x0,str,ts] = svmcorioli(t,x,u,flag,dyn)


global VM

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(u, dyn);

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
    sys=mdlOutputs(t,x,u,dyn);

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
function [sys,x0,str,ts]=mdlInitializeSizes(u, dyn)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%

global VM

n = numrows(dyn);

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = n;
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

q = [];
qd = [];
dM = [];


for k=1:n
   q = [q sym(['q'num2str(k)],'real')];
   qd = [qd sym(['qd'num2str(k)],'real')];
end

M = rnes(dyn, ones(n,1)*q, zeros(n,n), eye(n), [0;0;0], [0;0;0], [0;0;0], [0;0;0]);

for k=1:n
   dM = [dM;diff(M,['q'num2str(k)])];
end

Mpunto = kron(qd,eye(n))*dM;
U = kron(eye(n),qd)*dM;
VM = simple(0.5*(Mpunto + U' - U));

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
function sys=mdlOutputs(t,x,u,dyn)

global VM
n = numrows(dyn);
q = u(1:n)';
qd = u( (n+1):2*n );
in = u( (2*n+1):3*n );

for k=1:n
   eval(['q' num2str(k) ' = q(k)']);
   eval(['qd' num2str(k) ' = qd(k)']);
end

sys = eval(VM)*in;

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
