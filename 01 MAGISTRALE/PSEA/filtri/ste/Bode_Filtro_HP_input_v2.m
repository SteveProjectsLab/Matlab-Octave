% Filtro HP stadio d'ingresso TL072
% Frequenza di taglio: 19,4Hz
clear all
close all
clc

load filtroHP.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze =FiltroHP.Freq;
% asse verticale diagramma del modulo
modulo_dB =FiltroHP.ModulodB;
% asse verticale diagramma della fase
fase = FiltroHP.Fase;
% modulo 
    % sperimentale
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -35 5])
        legend('-dynamicLegend')
    grid on
    m3dB();
    hold on
    % teorico
    R=82e3;
    C=100e-9;
    f=min(frequenze):0.1:max(frequenze);
    abs=(2*pi*R*C*f)./sqrt(1+(2*pi*R*C*f).^2);
    semilogx(f, 20*log10(abs), 'Color', 'g', 'Linewidth', 1.5,'DisplayName','Teorico'),
        axis([min(frequenze) max(frequenze) -35 5]);
    grid on
    
% fase
    % sperimentale
    subplot(2,1,2), semilogx(frequenze,fase, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -5 90])
        legend('-dynamicLegend')
    grid on
    hold on
    % teorico
    angle=rad2deg(atan(1./(2*pi*R*C*f)));
    semilogx(f, angle, 'Color', 'g', 'Linewidth', 1.5,'DisplayName','Teorico'),
        axis([min(frequenze) max(frequenze) -5 90]);
    grid on