function [fi] = myCrossCorrelazioneLineare(x,y,t,tau,dt)

fi=zeros(1,length(tau));% inizializzo il vettore

for k=1:length(tau)
    ytau=myTranslation(y,tau(k),t,dt);
    fi(k)=myScalarProduct(ytau,x,dt);
end
end

