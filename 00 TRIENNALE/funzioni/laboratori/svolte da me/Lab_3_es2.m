
clc


dt=0.01;
t=-10:dt:10;
dtau=0.01
tau=-15:dtau:15;

y=sin(pi*t);
x = rect(t-0.5) - rect(t+0.5);

%calcolare crosscorrelazione circolare e autocorrelazione

CorrelazioneCircXY=zeros(1,length(tau));
xT=x.*rect(t/2);
for k=1:length(tau);
  ytau=sin(pi*(t+k));
  yT=ytau.*rect(t/2);
  CorrelazioneCircXY(1,k)=myCorrelazioneLin(xT,yT,dt)/2;
end
figure(1);
plot(tau,CorrelazioneCircXY);
AutoCorrelazione=zeros(1,length(tau));
for k=1:length(tau);
   xtau=rect(t-0.5+k) - rect(t-1.5+k);
    AutoCorrelazione(k)=myCorrelazioneLin(x,xtau,dt);
end
figure(2);
plot(tau,AutoCorrelazione);