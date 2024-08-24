function  verify_stability(method,h,lambda,figureNum)
% funzione realizzata da Stefano Molari
% ancora in fase di sviluppo...
% calcolo z1 vettore che rappresenterò nel pinao immaginario
z1=lambda*(real(h)+1i*imag(h));
xp=real(z1); % x nel piano complesso
yp=imag(z1); % y nel piano complesso
xl=xlim;  
yl=ylim;
axis([xl(1) xl(2) yl(1) yl(2)])

grana=0.01  

figure(figureNum);
%--------------------------------------------------------------------------
if method==1    %EULERO ESPLICITO
    [x,y] = meshgrid(min(xl(1),-5):grana:max(xl(2),5),min(yl(1),-5):grana:max(yl(2),5));
    z=x+i*y;
    R = double(abs(1+z)<1);
    contourf(x,y,R,1);colormap([1 1 1;0 1 0]);
    s='Eulero Esplicito ';
    titleFig=s;
%--------------------------------------------------------------------------
elseif method==2    %EULERO IMPLICITO
    [x,y] = meshgrid(min(xl(1),-1):grana:max(xl(2),5),min(yl(1),-5):grana:max(yl(2),5));
    z=x+i*y;
    R = double(abs(1-z)>1);
    contourf(x,y,R,1);colormap([1 1 1 ;0 1 0]);
    titleFig='Eulero Implicito ';
%--------------------------------------------------------------------------
elseif method==3    %CRANK-NICOLSON
    [x,y] = meshgrid(min(xl(1),-5):grana:max(xl(2),5),min(yl(1),-5):grana:max(yl(2),5));
    z=x+i*y;
    R = double(abs(2+z)./abs(2-z)<1);
    contourf(x,y,R,1);colormap([1 1 1 ;0 1 0]);
    titleFig='CrankNicolson';
%--------------------------------------------------------------------------
elseif method==4    %HEUN
    [x,y] = meshgrid(min(xl(1),-5):grana:max(xl(2),5),min(yl(1),-5):grana:max(yl(2),5));
    z=x+i*y;
    R =abs(1+z/2.*(2+z))<1;
    contourf(x,y,R,1);colormap([1 1 1 ;0 1 0]);
    titleFig='Heun';
%--------------------------------------------------------------------------
elseif method==5    %RK4
    [x,y] = meshgrid(min(xl(1),-5):grana:max(xl(2),5),min(yl(1),-5):grana:max(yl(2),5));
    z=x+i*y;
    R =abs(1+z.*(1+ z.*(1/2+z.*(1/6+z/24))))<1;
    contourf(x,y,R,1);colormap([1 1 1 ;0 1 0]);
    titleFig='RK4';
%--------------------------------------------------------------------------
elseif method==6    %AM
    fprintf('AM ancora da implementare...')    
end
%--------------------------------------------------------------------------
% stampo gli assi x e y
hold on
line([xp 0],[yp,0],'color','k')
grid on; hold on
h = line(xlim,[0,0]); set(h,'Color','k');
h = line([0,0],ylim); set(h,'Color','k');
plot(xp,yp,'o','MarkerFaceColor','r')
title(titleFig);

return