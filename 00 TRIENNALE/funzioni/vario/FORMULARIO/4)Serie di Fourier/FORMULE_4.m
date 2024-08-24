%%FOURIER_SERIE
%
%Serie di Fourier per segnali REALI

%NOTA BENE
%	SEGNALE PARI 	b(k)=0
%	SEGNALE DISPARI 	a(k)=0

%x(t) = x0 + sum  {2 . a(k) . cos(2 . π . (k/T) . t } + sum {2 . b(k) . sin(2 . π . (k/T) . t }
%x0	= 	(1/T)*integrale(x . rect(t/T) )
%a(k) 	= 	(1/T)*integrale( x . cos(2 . π . (k/T) . t) . rect(t/T) )
%b(k) 	= 	(1/T)*integrale( x . sin(2 . π . (k/T) . t) . rect(t/T) )


%%
%Serie di Fourier per segnali NON REALI

%x(t) = sum { x(k) . exp(-j . 2 . π . k/T . t) }
%x(k)= 1/T integrale( x(t) . exp( -j . 2 . π .k/T . t) )


%%
%PROPRIETA’ Serie Di Fourier   

%	traslazione 
		%x(t-t0) → Xk. exp(-j 2 pi k F t0)

%	modulazione
		%x(t) . exp(-j 2 pi k F t0) = sum {Xk . exp}(-j 2 pi k (f0+kF) t)
        
%	hermitianità	
		%x*(t) → X*k
        
%	derivazione
	%d^nx/dt^n → (j 2 pi k F) ^n
    
%	integrazione (X0=0)
		%integrale (x(u) du) → Xk/(j 2 pi k F)
        
%	linearità
		%ax1(t)+bx2(t) → aX1(t) + bX2(t)
        
%	conservazione della potenza
		%Px = 1/T integrale ( |x(t)|² dt ) = sum (|Xk|²)
        
%	ripetizione nel periodo
		%x(t) = x(t +-T/2) → Xk = 0 k dispari
		%x(t) ha periodo fondamentale T/2
        
%	antipodalità
		%| x(t) - X0 | = -| x(t+-T/2) - x0|
        
%	parità/ disparità di segnali reali
		%x(t) = x(-t) 	→ bk =0
		%x(t) = -x(-t) 	→ a0= ak = 0
        
%	decrescenza 
%di |xk| come |k|^-n se x(t) presenta discontinuità di seconda specie
