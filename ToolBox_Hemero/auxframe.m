%AUXFRAME	Función auxiliar necesaria para la ejecución de PLOTBOT
%

% 	Copyright (C) Iván Maza 2001


function [h1,h2] = auxframe(t,mag,hdl,etiq,color,opt)

% Se definen las dimensiones de las flechas de la representación
l1=mag/13;l2=mag/8;l3=(4/5)*mag;l4=mag; letra=mag*1.1;

% Se dibujan las flechas de los ejes X e Y
datosx1=[l1 l3 l3 l4 l3 l3 -l1 -l1 -l2 0 l2 l1];
datosy1=[l1 l1 l2 0 -l2 -l1 -l1 l3 l3 l4 l3 l3];
datosz1=[0 0 0 0 0 0 0 0 0 0 0 0];
unos1=[1 1 1 1 1 1 1 1 1 1 1 1];
link1=[datosx1;datosy1;datosz1;unos1];
li1=t*link1;
lfs1=[1 2 3 4 5 6 7 8 9 10 11 12];

% Se dibuja la flecha del eje Z
datosx2=[l1 l1 l2*sqrt(2) 0 -l2*sqrt(2) -l1 -l1];
datosy2=[l1 l1 l2*sqrt(2) 0 -l2*sqrt(2) -l1 -l1];
datosz2=[0 l3 l3 l4 l3 l3 0];
unos2=[1 1 1 1 1 1 1];
link2=[datosx2;datosy2;datosz2;unos2];
li2=t*link2;
lfs2=[1 2 3 4 5 6 7];

% Se calculan las posiciones de las letras de los ejes
posletrax = letra*t(1:3,1) + t(1:3,4);
posletray = letra*t(1:3,2) + t(1:3,4);
posletraz = letra*t(1:3,3) + t(1:3,4);

if (nargin==6)
	erasemode='none';
	% Se representan todas las flechas de los ejes
	set(hdl(1),'faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
	set(hdl(2),'faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
	patch('faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
	patch('faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
	% Se representan las letras
	set(etiq(1),'Position',[posletrax(1),posletrax(2),posletrax(3)],'erasemode',erasemode);
	set(etiq(2),'Position',[posletray(1),posletray(2),posletray(3)],'erasemode',erasemode);
	set(etiq(3),'Position',[posletraz(1),posletraz(2),posletraz(3)],'erasemode',erasemode);
	text('Position',[posletrax(1),posletrax(2),posletrax(3)],'erasemode',erasemode,'String','X');
	text('Position',[posletray(1),posletray(2),posletray(3)],'erasemode',erasemode,'String','Y');
	text('Position',[posletraz(1),posletraz(2),posletraz(3)],'erasemode',erasemode,'String','Z');
else
   erasemode='normal';
   % Se representan todas las flechas de los ejes
   set(hdl(1),'faces',lfs1,'vertices',[li1(1,:)' li1(2,:)' li1(3,:)'],'FaceColor',color,'erasemode',erasemode);
   set(hdl(2),'faces',lfs2,'vertices',[li2(1,:)' li2(2,:)' li2(3,:)'],'FaceColor',color,'erasemode',erasemode);
   % Se representan las letras
   set(etiq(1),'Position',[posletrax(1),posletrax(2),posletrax(3)],'erasemode',erasemode);
   set(etiq(2),'Position',[posletray(1),posletray(2),posletray(3)],'erasemode',erasemode);
   set(etiq(3),'Position',[posletraz(1),posletraz(2),posletraz(3)],'erasemode',erasemode);
end
   
h1=hdl; h2=etiq;
