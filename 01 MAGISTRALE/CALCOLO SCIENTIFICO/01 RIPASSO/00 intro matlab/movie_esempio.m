%% generazione di un movie
f=@(x,y,t)sin(sqrt(x.^2+y.^2)-2*t);
[x,y]=meshgrid(-2*pi:.2:2*pi);% stessa discretizzazione per x e y
numero_campioni=50
durata=2*pi;
t=linspace(0,durata,numero_campioni);

Mv=struct('cdata',{},'colormap',{});
figure(1);clf
for n=1:numero_campioni
    z=f(x,y,t(n));
    s=surf(x,y,z);
    s.EdgeColor= "none";
    % axis=([-2*pi,2*pi,-2*pi,2*pi])
    Mv(n)=getframe;

    pause(0.01)
end
movie(Mv,10);