clear
close all
clc
%considerare il segnale x1 (t) = rect (t/4) * delta4(t)
%usando i coeff sintetizzare un'approsimazione
%disegnare l'approssimazione
%disegnare l'errore

dt = 0.01;
t = -10:dt:10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 6 es 1.1\n\n');
T1 = 4;

x1 = zeros(size(t));

%sommo di volta in volta le versioni traslate del segnale fondamentale
for n = floor(min(t)/T1):ceil(max(t)/T1)
    x1 = x1+(t-n*T1).*rect(t/T1-n);
end

figure(1), set(1, 'WindowStyle', 'docked')
plot(t,x1); title('x1'); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]); grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 6 es 1.2\n\n');
%numero di armoniche utilizzate
NarmVet = [10 20 30 100]; 

x1SingPer = x1.*rect(t/T1);

% segnale ricostruito nelle righe, ognuna usa un numero diverso di armoniche
% ci saranno 3 righe dato che ho 3 opzioni: 10,20,30

%tramite b
x1Approx = zeros(length(NarmVet),length(t));

%tramite la bcalc ottenuti tramite integrale
x1ApproxCalc = zeros(length(NarmVet),length(t));

for n = 1:length(NarmVet) 
    Narm = NarmVet(n);
    b = zeros(Narm,1);
    bCalc = zeros(Narm,1);
    for k = 1:Narm 
        b(k) = -2/(pi*k)*(-1)^k;    %b(k) da formula pdf
        
        % ***************
        % * ESERCIZIO 3 *
        % ***************
        bCalc(k) = 1/T1*integrale(x1SingPer.*sin(2*pi*k/T1*t),dt);% b calcolata
        x1Approx(n,:) = x1Approx(n,:)+2*b(k)*sin(2*pi*k/T1*t);% sommo la sinusoide
        x1ApproxCalc(n,:) = x1ApproxCalc(n,:)+2*bCalc(k)*sin(2*pi*k/T1*t);
    end
    
    %stampo i risultati
    figure(2), set(2, 'WindowStyle', 'docked')
    subplot(length(NarmVet),2,n*2-1), stem(1:Narm,b); title(sprintf('b secondo la formula data con %d armoniche',Narm)); grid on
    subplot(length(NarmVet),2,n*2), stem(1:Narm,bCalc); title(sprintf('b calcolato con l''integrale con %d armoniche',Narm)); grid on

    figure(2+n), set(2+n, 'WindowStyle', 'docked');
    plot(t,x1Approx(n,:)); title(sprintf('x1 ricostruito con b secondo la formula data con %d armoniche',Narm)); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]); grid on
    figure(2+length(NarmVet)+n), set(2+length(NarmVet)+n, 'WindowStyle', 'docked');
    plot(t,x1ApproxCalc(n,:)); title(sprintf('x1 ricostruito con b calcolato con l''integrale con %d armoniche',Narm)); axis([min(t) max(t) min(x1)-.5 max(x1)+.5]); grid on
    
end