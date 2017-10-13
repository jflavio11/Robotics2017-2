%Conectarse con el simulador
vrep=remApi('remoteApi');
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID ~=-1)
 %Crear un handle para los motores
 [err, motor_izquierdo]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_leftMotor', vrep.simx_opmode_oneshot_wait);
 [err, motor_derecho]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_rightMotor', vrep.simx_opmode_oneshot_wait);
 while (vrep.simxGetConnectionId(clientID)~=-1) %Mientras la simulacion este activa hay que correr el bucle
 %Cambiar la velocidad de los motores
 vrep.simxSetJointTargetVelocity(clientID, motor_izquierdo,3,vrep.simx_opmode_streaming);
 vrep.simxSetJointTargetVelocity(clientID, motor_derecho,2,vrep.simx_opmode_streaming);
 end
end
vrep.simxFinish(clientID);