clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;

T=4;  %PERIODO dell FUNZIONE
x1=zeros(1, length(t));

%x1=(t)rect(t/4)*delta4(t)

%Come rappresentare un segnale periodico
for n = floor(min(t)/T): ceil(max(t)/T)  
 
    x1= x1 + (t-n*T).*rect((t-n*T)/T);
    
    
end

plot(t, x1), title('x1 originale')
