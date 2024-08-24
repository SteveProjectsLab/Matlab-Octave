function [out] = myConvoluzione(x,y,t)

tau=t;
dt=t(2)-t(1);
out=myCrossCorrelazioneLineare(conj(flip(x)),y,t,tau,dt);

end

