function Jout = E6_fobj(K,grafico)
% LE COSE CHE SERVONO AL GENETICO PER LA FITNESS FUNCITON
x0=[0 3]';  % condizione iniziale definita dal testo
y0=10;      % setpoint definito dal testo
%K=[x(1) x(2)];
   
% valori che l'algoritmo genetico deve testare con la fitness function
%prende il primo elemento, calcola fitbness function.. prende il secondo
% questi elementi sono caratterizzati da 3 grandezze e vanno a finire nel
% vettore K
K1=K(1);    % prima componente individuo
K2=K(2);    % seconda componente individuo
a=K(3);     % terza componente individuo
alfa=0.5;   % definita nel testo

options = simset('SrcWorkspace', 'current');
sim('simulink_E6', [], options);       % lancio la simulazione dello schema simulink      
% nelle quadre ci sono le consizioni iniziali
% in options uso il comando strano options = simset('SrcWorkspace', 'current');
% stiamo facendo girare una funzione, lanciando uno schema simmulink
% all'interno di una funzione
% però quando lancio lo schema simulink devo dirgli dove prendere i
% parametri

close_system('simulink_E6');      % chiude lo schema simulink e libera un po' di memoria 

J1=J1(end); % prendo l'ultimo elemento
J2=J2(end);
Jout=alfa*J1+(1-alfa)*J2; % parametro di uscita della mia fitness funciton

%RIASSUNTO
% all'inizio diciamo cosa serve al genetico per calcolare la fitness
% essa è una funzione matlab che prende i valori che gli da il genetico
% ( che stanno dentro k) li ripartisce nei parametri a K1 K2 parametri che
% voglio ottimizzare nello schema simulink, lancia lo shcema simulink,
% prende i valori in uscita da J1 e J2 e ridà Jout all'algoritmo genetico.
% l'algoritmo genetico dice "quanto è la fitness funciton dell'individuo
% che ha certi parametri?"
% la calcola lanciando la funzione, che lancia lo schema simulink, che gli
% restituisce J1 e J2 che permette di calcolare Jout
% elemento 1 1-4-5 our 5000 ecc
% poi si calcola popolazione elite, crossover, mutazione ecc

if grafico>0
    %close all;
    figure
    plot(uscita.time,uscita.signals.values);
    hold on
    plot(var_controllo.time,var_controllo.signals.values,'k--');
end
end