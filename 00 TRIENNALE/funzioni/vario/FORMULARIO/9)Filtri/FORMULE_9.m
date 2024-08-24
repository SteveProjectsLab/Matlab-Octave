%TIPOLOGIE DI FILTRI   

%Passa Basso Ideale
%→ H(f)= rect(f/ 2B)
%→ h(t)= 2B sinc(2Bt)
%	LEONARDI  H(f) = H0 .  rect (f/2B) . exp ( -j 2 pi f t0)
%Passa Banda Ideale 
%→ H(f)= rect((f-fo)/ B)+rect((f+fo)/ B) 
%→ h(t)=  2B sinc(Bt) cos(2πf0t) 
%	LEONARDI  H(f) = K . rect(f-fo/ B)+rect((f+fo)/ B)
%Passa Alto Ideale
%→ H(f)=1-  rect(f/ 2B)
%→ h(t)=  δ(t) − 2B sinc(2Bt)
%	LEONARDI  H(f) = H inf .  1 - rect (f/2B) . exp ( -j 2 pi f t0)
