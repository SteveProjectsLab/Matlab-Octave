function S = serieFourierComplessa(Xk,k,t,T)
S=zeros(1,length(t));
    for i=1:length(k)
        S=S+Xk(i)*exp(1j*2*pi*k(i)*t/T);
    end
end