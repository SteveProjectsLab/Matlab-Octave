% Filtro LP attivo (Sallen-Key) dello stadio d'uscita
% Frequenza di taglio: 22,135kHz
clear all
close all
clc

load LP_SK_20Vpp.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze = LPSK20Vpp.Freq;
% asse verticale diagramma del modulo
modulo_dB = LPSK20Vpp.ModuloDB;
% asse verticale diagramma della fase
fase = LPSK20Vpp.Fase;

% modulo 
    % sperimentale
    figure
    subplot(2,1,1), semilogx(frequenze,modulo_dB, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$|H|_{dB} $','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -15 5])
        legend('-dynamicLegend')
    grid on
    m3dB();
    % teorico
    R1=20e3;
    R2=1e3;
    C1=4.7e-9;
    C2=550e-12;
    f=linspace(10,1e6,1e6);
    w=2*pi*f;
    module=abs(1./(1-w.^2*R1*C1*R2*C2+1i*w*(R1*C2+R2*C2))); % formula del modulo
    semilogx(f, 20*log(module),'DisplayName','Teorico'),
        axis([min(frequenze) 1e6 -90 5]);
    grid on
% fase
    % sperimentale
    subplot(2,1,2), semilogx(frequenze,fase, ...
        'o','MarkerFaceColor','c','MarkerEdgeColor','b','DisplayName','Misure'), 
        title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) max(frequenze) -180 0])
        legend('-dynamicLegend')
    grid on
    % teorico
    hold on
    phase=angle(1./(1-w.^2*R1*C1*R2*C2+1i*w*(R1*C2+R2*C2)));
    semilogx(f, rad2deg(phase),'DisplayName','Teorico'),
    title('$Arg(H) [deg]$','Interpreter','latex'), 
        axis([min(frequenze) 1e6 -190 0]);
    grid on