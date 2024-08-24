function [ytau] = myTranslation(y,tau,t,dt)
%MY_TRANSLATION restituisce il segnale y traslato di tau y(t+tau)
%  

ytau=zeros(size(t));
% 
% for k=1:length(t)
%     t(k)+tau;
%     ytau(k)=y(t(k)+tau);
% end

for k=1:length(t)
    if (k+round(tau/dt))>0 && (k+round(tau/dt))<length(t)
        ytau(k)=y(k+round((tau/dt)));
    end
end
end

