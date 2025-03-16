L=3;
fs=10;
Vi=24;


d= linspace (0,1,1000);

f=@(d)(Vi.*d.*(1-d))./(fs*L);
Delta_iL=f(d);
plot (d,Delta_iL);
grid on;

