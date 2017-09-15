%	Función-S auxiliar que se emplea en el bloque Simulink "Par realimentado aprendido"

%	Copyright (C) Iván Maza 2001

function [sys,x0,str,ts] = learn(t,x,u,flag,Kp,Kv,mu,tfinal)


switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(u, Kp, Kv, mu, tfinal);

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
    sys=mdlOutputs(t,x,u,Kp,Kv,mu,tfinal);

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

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(u,Kp, Kv, mu, tfinal)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
global TIEMPO
global D_K
global E
global E_D
global E_DD


n = length(Kp(1,:));

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4*n;
sizes.NumInputs      = -1;
sizes.DirFeedthrough = -1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed


sys = simsizes(sizes);

if (exist('itera.mat')==2)
   a=load('itera','tout');	   
   TIEMPO = a.tout;
   a=load('itera','dknueva');
   D_K = a.dknueva;
   a=load('itera','error');
   E = a.error;
   a=load('itera','error_d'); 
   E_D = a.error_d;
   a=load('itera','error_dd');
   E_DD = a.error_dd;
else
	TIEMPO = [0;tfinal];
   D_K = [zeros(1,n);
      zeros(1,n)];   
   E = D_K;
   E_D = E;
   E_DD = E;
end


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
function sys = mdlOutputs(t,x,u,Kp,Kv,mu,tfinal)

global TIEMPO
global D_K
global E
global E_D
global E_DD

n = length(u)/3;
edd = u(1:n);
ed = u( (n+1):(2*n) );
e = u( (2*n+1):(3*n) );

for (w=1:n)
   if (t==tfinal)
      d_ant = D_K(numrows(D_K),:);
      e_ant = E(numrows(E),:);
      ed_ant = E_D(numrows(E_D),:);
      edd_ant = E_DD(numrows(E_DD),:);
   else
      d_ant(w) = interp1(TIEMPO, D_K(:,w), t);
      e_ant(w) = interp1(TIEMPO, E(:,w), t);
      ed_ant(w) = interp1(TIEMPO, E_D(:,w), t);
      edd_ant(w) = interp1(TIEMPO, E_DD(:,w), t);
   end
end
   
nuevo_d = d_ant' + edd_ant' + (Kv-mu)*ed_ant' + (Kp-mu)*e_ant';

sys = [nuevo_d; e; ed; edd];

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
