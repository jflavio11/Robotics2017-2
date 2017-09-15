% ENLACE Construye cada uno de los enlaces del manipulador en la representación que hace PLOTBOT

function A = enlace (t,l,hdl,mag,opt)
   w=mag/10;
   h=w;
   datosx=[0 l l 0 0 l l 0];
   datosy=[-w/2 -w/2 w/2 w/2 -w/2 -w/2 w/2 w/2];
   datosz=[-h/2 -h/2 -h/2 -h/2 h/2 h/2 h/2 h/2];
   unos=[1 1 1 1 1 1 1 1];
   link=[datosx;datosy;datosz;unos];
   l1=t*link;
   lfs=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
   
   if nargin==5
      set(hdl,'faces',lfs,'vertices',[l1(1,:)' l1(2,:)' l1(3,:)'],'FaceColor','c','erasemode','none');
      patch('faces',lfs,'vertices',[l1(1,:)' l1(2,:)' l1(3,:)'],'FaceColor','c','erasemode','none');
   else
      set(hdl,'faces',lfs,'vertices',[l1(1,:)' l1(2,:)' l1(3,:)'],'FaceColor','c');
   end
   
   A=hdl;