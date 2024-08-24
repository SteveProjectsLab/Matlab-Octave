% università sportmania
% squadre football vs squadre maskket
% modello tempo discreto per la dinamica deimenbri delle due squadre
%50% football al tempo t è ancora parte della squadra t+1
%incremento 10% annuale squadra basket
% u studenti sportsmania
%0.1% basket
35% footbsll 20% abbandonano la squadra

% TE febbraio 2022 preappello

%x1 football
%x2 basket


x1(t+1)=0.5*x1(t)+0.05*u(t)-0.35*x1(t);
x2(t+1)=1.1*x2(t)+0.001*u(t)-0.2*x2(t);

% variabili  di stato: x1 x2
% ingressi manipolabili: 
% a1=0.5 con staff medico
% b1= 0.05 e b2=0.001 con recruitment

% NB lo 0,35 3 lo 0.2 non li cambiio se no farei laureare meno persone

% a2=1.1 con recruitment esterno

% esempi, cerco di ampliare lo staaff medico per aumentare lo 50%
% esempi, faccio recruitment per aumentare


% ingressi non manipolabili: u 
% NB si potrebbe far pressione all'università di fare recruitment, però
% dipende poco dalla squadras