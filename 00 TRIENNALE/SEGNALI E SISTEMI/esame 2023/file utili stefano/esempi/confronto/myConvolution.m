function [out] = myConvolution(x,y,t)
%MYCONVOLUTION Summary of this function goes here
%   Detailed explanation goes here
tau=t;
dt=t(2)-t(1);

x_flip=flip(x);

out=myCrossCorrelation(conj(x_flip),y,t,tau,dt);

% tau=t;
% dtau=t(2)-t(1);
% out=zeros(1,length(t));
% for k=1:length(t)
%     %mi serve y(t-tau) con t parametro, y(-(tau-t)) prima traslo di -t poi
%     %ribalto
% ytau=myTranslation(y,-t(k),tau,dtau);
% ytau_rib=flip(ytau);
% out(k)=integrale(x.*ytau_rib,dtau);
% end
% out=flip(out);


end

