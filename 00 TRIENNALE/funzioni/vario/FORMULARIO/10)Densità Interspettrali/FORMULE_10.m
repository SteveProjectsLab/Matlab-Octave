%%DENSITÀ INTERSPETTRALI Φxy(f)      

 
%→  SEGNALI di ENERGIA
%Wx= integrale( | X(f) |² .df)

% Φxy(f) = F(Phi_xy(τ ) )           , dove Phi = Crosscorrelazione
%	   = F(x* (−τ ) ∗ y(τ )) 
%	   = X *(f).Y (f)

% Φx(f) = F(Phi_x(τ )) 
%	 = | X(f) |² 

% Wx=integrale(  Φx(f) .df )

%→  SEGNALI di potenza

% Φxy(f) = F(Phi_xy(τ ))           , dove Phi = Crosscorrelazione
%	   = F(x* (−τ ) ∗ y(τ )) 
%	   =lim D->∞ [1/D .( Xd*(f).Yd(f) ) ]
%
% , con  Xd(f)= F ( x(t). rect(t/D))
%, con   Yd(f)= F ( y(t). rect(t/D))

% Φx(f) = F(Phi_x(τ )) 
%	 = |X(f)|² 

% Px=integrale(  Φx(f) .df )
%     = Phi(0)

