
clear all
close all
clc

load inmicamp.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze = inmicamp.Freq;
% asse verticale diagramma del modulo
modulo_dB = inmicamp.ModuloDB;
% asse verticale diagramma della fase
fase = inmicamp.Fase;

% modulo 
    % sperimentale
    figure
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) 20 50])
        legend('-dynamicLegend')
    grid on
    % teorico
   f=linspace(0,1e5,1e3);
    w=2*pi*f;
    line(xlim, [40 40], 'Color', 'g', 'Linewidth', 1.5,'DisplayName','Teorico');
        axis([min(frequenze) max(frequenze) 20 50]);
    grid on

    %%
% fase
    % sperimentale
    subplot(2,1,2), semilogx(frequenze,fase, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -10 10])
        legend('-dynamicLegend')
    grid on
    % teorico
    hold on
    line(xlim, [0 0], 'Color', 'g', 'Linewidth', 1.5,'DisplayName','Teorico');
        axis([min(frequenze) max(frequenze) -90 5]);
    title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -90 5]);
    grid on