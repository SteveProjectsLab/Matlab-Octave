%SEGNALI

%%
%CARATTERISTICHE

%causalità
%    causale     		  x(t)=0 per t<0
%    anticausale	 	  x(t)=0 t>=0
%    non causale		  E t1>=0 x(t1)!=0 e E t2<0 x(t1)!=0 e

%simmetrie 
%    pari       		  x( t0 + t )= x( t0 - t )
%    dispari     		  x( t0 + t )= -x( t0 - t )

%%
%GEOMETRIA DEI SEGNALI

%norma               	  ||x|| =sqrt(<x,x>)=d2(x,0) = sqrt(energia(x))
%Distanza                 d2(x,y) = ||x-y|| = sqrt(energia(x-y))
%Distanza al quadrato     d2²(x,y) = ||x||² + ||y||² - 2 Re{<x,y>}
%Prodotto scalare      	  <x,y>=integrale(x(t).y*(t))
%Schwarz		         |<x,y>| <= ||x||² . ||y||²

%%
%ENERGIA - POTENZA 

%energia                  energia = integrale( |x²| )
%potenza periodico        potenza = 1/T . energia( segnale periodo )

