% Filtro LP in uscita al blocco RMS-DC
% frqeuenza di taglio: 3,12Hz
clear all
close all
clc

load filtroLP_RMS.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze =FiltroLP_RMS.Freq;
% asse verticale diagramma del modulo
modulo_dB =FiltroLP_RMS.ModulodB;
% asse verticale diagramma della fase
fase = FiltroLP_RMS.Fase;
% modulo 
    % sperimentale
    figure
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
            axis([min(frequenze) max(frequenze) -35 5])
        grid on
    m3dB();
    hold on
    % teorico
    R=510;
    C=100e-6;
    f=linspace(0.01,100,100);
    abs=1./sqrt(1+(2*pi*R*C*f).^2); % formula del modulo
    semilogx(f, 20*log10(abs), 'Color', 'g', 'Linewidth', 1.5), 
        axis([min(frequenze) max(frequenze) -35 5]);
    grid on
% fase
    % sperimentale
    subplot(2,1,2), semilogx(frequenze,fase, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b'), 
        title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -90 0])
    grid on
    hold on
    % teorico
    angle=rad2deg(-atan((2*pi*R*C*f))); % formula della fase (passo da rad->deg)
    semilogx(f, angle, 'Color', 'g', 'Linewidth', 1.5),
        axis([min(frequenze) max(frequenze) -90 0]);
    grid on