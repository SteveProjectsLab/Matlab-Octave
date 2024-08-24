clear 
close all
clc
set(0,'DefaultFIgureWindowStyle','docked')
%% FILTRO LP RMS
load filtroLP_RMS.mat
% asse orizzontale delle frequenze (in scala log10)
frequenze =FiltroLP_RMS.Freq;

% asse verticale diagramma del modulo
modulo_dB =FiltroLP_RMS.ModulodB;

% asse verticale diagramma della fase
fase = FiltroLP_RMS.Fase;

% stampa a video il grafico
figure(1)

subplot(2,1,1), semilogx(frequenze,modulo_dB, 'o-','MarkerEdgeColor','r','DisplayName','Meas'), title('$|H|_{dB} $','Interpreter','latex')
m3dB();
%line(xm3dB,ylim,'color','k','DisplayName','-3dB','lineStyle','--');  
legend('-dynamicLegend')
grid on
subplot(2,1,2), semilogx(frequenze,fase, 'o-','MarkerEdgeColor','r'), title('$Arg(H) [deg]$','Interpreter','latex'), axis([min(frequenze) max(frequenze) -90 0])
grid on
%% FILTRO HP INGRESSO
% idem per il filtro HP
load filtroHP.mat
frequenze = FiltroHP.Freq;
modulo_in = 0.1.*FiltroHP.AmpCh1;
modulo_out = 0.001.*FiltroHP.AmpCh2;
fase = FiltroHP.Fase;
figure
subplot(2,1,1), semilogx(frequenze,20*log(modulo_out/modulo_in), 'o-','MarkerEdgeColor','r'), title('$|H|_{dB} $','Interpreter','latex')
m3dB();
grid on
subplot(2,1,2), semilogx(frequenze,fase, 'o-','MarkerEdgeColor','r'), title('$Arg(H) [deg]$','Interpreter','latex'), axis([min(frequenze) max(frequenze) -90 0])
grid on

%% FILTRO LP SALLEN KEY
load lp_Sallen_Key.mat
frequenze = LP_Sallen_Key.Freq;
modulo_dB = LP_Sallen_Key.ModulodB;
fase = LP_Sallen_Key.Fase;
figure
subplot(2,1,1), semilogx(frequenze,modulo_dB, 'o-','MarkerEdgeColor','r'), title('$|H|_{dB} $','Interpreter','latex')
m3dB();
grid on
subplot(2,1,2), semilogx(frequenze,fase, 'o-','MarkerEdgeColor','r'), title('$Arg(H) [deg]$','Interpreter','latex'), axis([min(frequenze) max(frequenze) -90 0])
grid on