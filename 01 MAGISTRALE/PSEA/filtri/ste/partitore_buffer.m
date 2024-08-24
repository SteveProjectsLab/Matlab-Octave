
clear all
close all
clc

load partitore_buffer.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze = partitoreebuffer.Freq;
% asse verticale diagramma del modulo
modulo_dB = partitoreebuffer.ModuloDB;
% asse verticale diagramma della fase
fase = partitoreebuffer.Fase;

% modulo 
    % sperimentale
    figure
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -15 5])
        legend('-dynamicLegend')
    grid on
    % teorico
   f=linspace(0,1e5,1e3);
    w=2*pi*f;
    att=20*log10(3/10);
    line(xlim, [att att], 'Color', 'g', 'Linewidth', 1.5,'DisplayName','Teorico');
        axis([min(frequenze) max(frequenze) -20 5]);
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
        axis([min(frequenze) max(frequenze) -20 5]);
    title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -10 10]);
    grid on