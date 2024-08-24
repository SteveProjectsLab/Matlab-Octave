%%FOURIER_ TRASFORMATA
%
%Trasformata di Fourier     X(f) = Integrale(x.*exp(+1j . 2 . π . f . t),df);
%Tdf Inversa         	    x(t) = Integrale(X.*exp(-1j . 2 . π . f . t),dt);

%Modulo Abs          	    %  |x| = sqrt(a^2+b^2)    x app C, x= a+jb
%Fase angle             	    %  <x =  arctan (b/a)
%TH risposta in freq     % y(t) = A|H(f0)| cos (2πf0t+ < H(f0))

%%
%TRASFORMATE NOTE FOURIER:     
%x=1 → δ(f)
%x=δ(t) → 1
%x=rect(t) → sinc(f)
%x=δ(t-to) → exp(-j2πtof)
%x=exp(j2pitof) → δ(f-fo)
%x=cos(2πfot) → ½[ δ(f-fo) + δ(f+fo)]
%x=sin(2πfot) → 1/2j [ δ(f-fo) - δ(f+fo)]
%x=tri(t) → sinc² (f)
%x=sinc² (t) → x=tri(t) 
%x=-1/(j π t) → sgn (f) 
%x=sgn(t) → 1/(j π f)	
%x=gradino(t) → 1/2δ(f)1/(j 2 π f)

%%
%PROPRIETÀ TRASFORMATA FOURIER
%x(t) → X(f)                               - dualità
%X(t) → x(-f)

%F{a.x+ b.y} → a.F{x} +b.F{y}          - linearità

%X(0)= integrale(x.dt)                  - valori nell’origine
%x(0)= integrale(X, df)

%x(a.t) → 1/ |a| X(f/a)                 - cambio scala

%x*(t) → X*(-f)                          - simmetria

%                                         -diagramma delle simmetrie
%           tempi		frequenze

%reale		pari	------	pari
%           dispari		dispari		
%                    X
%imm		dispari		dispari
%   		pari	------	pari

%x(t-to) → X(f). exp(-j 2π f to)        - traslazione
%X(f-fo) → x(t). exp(j 2π f to)         - modulazione

%x’(t) → (j 2π f )X(f)                  - derivazione

%exp(-π t²) → exp(-π f²)                - punto unito trasformata

%z(t)= x(t)*y(t) → Z(f)= X(f).Y(f)      - convoluzione
%z(t)= x(t).y(t) → Z(f)= X(f)*Y(f)

%%
%IDENTITA’ DI PARSEVAL
%dati due segnali x1(t) e x2(t) che ammettono t.d.f.

%I FORMA   →  integrale ( x1(u) . X2(u) .du) = integrale ( X1(u) . x2(u) .du)
%II FORMA  →  integrale ( x1(u) . x2(-u) .du) = integrale ( X1(u) . X2(u) .du)
%III FORMA →  integrale ( x1(t) . x2*(t) .dt ) = integrale ( X1(f) . X2*(f) . df)
%IV FORMA → integrale( |x(t)|² .dt ) = integrale( |X(f)|² .df ) , se x è segnale ENERGIA
