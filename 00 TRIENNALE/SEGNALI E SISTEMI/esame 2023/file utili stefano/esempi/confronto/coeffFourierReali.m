function [a0, ak, bk] = coeffFourierReali (x,t,k,T)
addpath ../../0.FUNZIONI/
    dt=t(2)-t(1);
    a0=integrale(x.*rect(t/T),dt)/T;
    ak=zeros(1,length(k));
    bk=zeros(1,length(k));
    for i=1:length(k)
        ak(i)=integrale(x.*rect(t/T).*cos(2*pi*t*k(i)/T),dt)/T;
        bk(i)=integrale(x.*rect(t/T).*sin(2*pi*t*k(i)/T),dt)/T;
    end
end