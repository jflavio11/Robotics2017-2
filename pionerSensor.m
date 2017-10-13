%Conectarse con el simulador
vrep=remApi('remoteApi');
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID ~=-1)
 %Crear un handle para los motores
 [err, motor_izquierdo]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_leftMotor', vrep.simx_opmode_oneshot_wait);
 [err, motor_derecho]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_rightMotor', vrep.simx_opmode_oneshot_wait);

 %Crear un handle para los sensores de distancia
 [err, sensorA] = vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_ultrasonicSensor4', vrep.simx_opmode_oneshot_wait);
 [err, sensorB] = vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_ultrasonicSensor1', vrep.simx_opmode_oneshot_wait);
 %Los sensores de distancia se activan leyéndolos una vez
 %[err, estadoA, puntoA, objeto_detectadoA, vector_normalA] = vrep.simxReadProximitySensor(clientID, sensorA, vrep.simx_opmode_streaming);
 %[err, estadoB, puntoB, objeto_detectadoB, vector_normalB] = vrep.simxReadProximitySensor(clientID, sensorB, vrep.simx_opmode_streaming);
 while (vrep.simxGetConnectionId(clientID)~=-1)
 %Cambiar la velocidad de los motores
 vrep.simxSetJointTargetVelocity(clientID, motor_izquierdo,3,vrep.simx_opmode_streaming);
 vrep.simxSetJointTargetVelocity(clientID, motor_derecho,-3,vrep.simx_opmode_streaming);
 %Leer los dos sensores. En este ejemplo solo nos interesa la variable 'estado'.
 [err, estadoA, puntoA, objeto_detectadoA, vector_normalA] = vrep.simxReadProximitySensor(clientID, sensorA, vrep.simx_opmode_streaming);
 [err, estadoB, puntoB, objeto_detectadoB, vector_normalB] = vrep.simxReadProximitySensor(clientID, sensorB, vrep.simx_opmode_streaming);
 %Para mostrar las lecturas de los sensores, creamos un array con el nombre de cada sensor y su estado.
 %Las variables 'estadoA' y 'estadoB' son variables numericas. Hay que convertirlas a string con la funcion num2str.
 lectura_variables = ['Sensor A: ', num2str(estadoA), ' Sensor B: ', num2str(estadoB)];
 disp(lectura_variables)
 end
end
disp('esta es la clase de robotica');
vrep.simxFinish(clientID);