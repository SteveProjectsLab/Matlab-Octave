function Xk = coeffFourierComplessi (x,t,k,T)
addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/
    dt=t(2)-t(1);
    Xk=zeros(1,length(k));
    for i=1:length(k)
        Xk(i)=(1/T)*integrale(x.*rect(t/T).*exp(-1j*2*pi*k(i)*t/T),dt);
    end
end