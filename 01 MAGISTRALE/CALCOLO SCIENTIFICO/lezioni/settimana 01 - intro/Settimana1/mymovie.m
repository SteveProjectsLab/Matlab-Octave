% generazione di un movie

% definsco il function handle
f=@(x,y,t)sin(sqrt(x.^2+y.^2)-2*t);
% discretizzo lo spazio
[x,y]=meshgrid(-2*pi:.2:2*pi); % stessa discretizzazione per x e y
t=linspace(0,2*pi,50); % discretizzo il tempo

figure(1); clf

Mv=struct('cdata',{},'colormap',{});
for n=1:50
    z=f(x,y,t(n)); % valuto f
    s=surf(x,y,z); % disegno la superficie
    s.EdgeColor='none';
    axis([-2*pi, 2*pi, -2*pi, 2*pi, -2,2])
    Mv(n)=getframe;
    pause(0.02);
end

movie(Mv,4);