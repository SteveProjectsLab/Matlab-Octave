% Filtro LP attivo (Sallen-Key) dello stadio d'uscita
% Frequenza di taglio: 22,135kHz
clear all
close all
clc

load lp_Sallen_Key.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze = LP_Sallen_Key.Freq;
% asse verticale diagramma del modulo
modulo_dB = LP_Sallen_Key.ModulodB;
% asse verticale diagramma della fase
fase = LP_Sallen_Key.Fase;

% modulo 
    % sperimentale
    figure
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -15 5])
    grid on
    m3dB();
    % teorico
    R=510;
    C=100e-6;
    f=linspace(0.01,100,100);
    abs=1./sqrt(1+(2*pi*R*C*f).^2); % formula del modulo
    semilogx(f, 20*log10(abs)),
        axis([min(frequenze) max(frequenze) -15 5]);
    grid on
% fase
    % sperimentale
    subplot(2,1,2), semilogx(frequenze,fase, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b'), 
        title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -180 0])
    grid on
    % teorico
    angle=-atan(2*pi*R*C*f);        % formula della fase
    semilogx(f, angle),
        axis([min(frequenze) max(frequenze) -90 0]);
    grid on