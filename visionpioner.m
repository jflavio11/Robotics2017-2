%Conectarse con el simulador
vrep=remApi('remoteApi')
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID ~=-1)
 %Crear un handle para la camara
 [err, camara] = vrep.simxGetObjectHandle(clientID, 'Vision_sensor', vrep.simx_opmode_oneshot_wait);
 giros = 0;
 while (vrep.simxGetConnectionId(clientID)~=-1)
     %Capturar imagen con la camara
     [errorCode,resolution,img]=vrep.simxGetVisionSensorImage2(clientID,camara,0,vrep.simx_opmode_oneshot_wait);

     %Mostrar imagen en una ventana
     imshow(img);
     drawnow;

     %Crear un handle para los motores
     [err, motor_izquierdo]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_leftMotor', vrep.simx_opmode_oneshot_wait);
     [err, motor_derecho]=vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_rightMotor', vrep.simx_opmode_oneshot_wait);

     %Crear un handle para los sensores de distancia
     [err, sensor4] = vrep.simxGetObjectHandle(clientID, 'Pioneer_p3dx_ultrasonicSensor4', vrep.simx_opmode_oneshot_wait);

     %Cambiar la velocidad de los motores
     vrep.simxSetJointTargetVelocity(clientID, motor_izquierdo,2,vrep.simx_opmode_streaming);
     vrep.simxSetJointTargetVelocity(clientID, motor_derecho,2,vrep.simx_opmode_streaming);

     %Leer los dos sensores. En este ejemplo solo nos interesa la variable 'estado'.
     [err, estado4, puntoA, objeto_detectadoA, vector_normalA] = vrep.simxReadProximitySensor(clientID, sensor4, vrep.simx_opmode_streaming);
     
     if(estado4 == 1 && giros < 3 )
         vrep.simxSetJointTargetVelocity(clientID, motor_derecho,1,vrep.simx_opmode_streaming);
         vrep.simxSetJointTargetVelocity(clientID, motor_izquierdo,2,vrep.simx_opmode_streaming);
         giros = giros +1;
     end
     
     if(giros == 3)
         giros = 0;
         vrep.simxSetJointTargetVelocity(clientID, motor_derecho,2,vrep.simx_opmode_streaming);
         vrep.simxSetJointTargetVelocity(clientID, motor_izquierdo,1,vrep.simx_opmode_streaming);
     end
     
 end
else
    disp('error de conexionnn');
end
disp('Se termino');
vrep.simxFinish(clientID);