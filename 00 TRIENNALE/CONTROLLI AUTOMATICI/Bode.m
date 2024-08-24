%% Importo i dati
frequenza = table2array(SperimentalData(:,1));
guadagno = table2array(SperimentalData(:,2));
fase = table2array(SperimentalData(:,3));
fase_xy = table2array(SperimentalData(:,4));
fase_xy = fase_xy*(-1);

%% Imposto gli assi del diagramma di Bode
frequenza_log = log10(frequenza);
guadagno_dB = 20*log10(guadagno);

%% Inizio a disegnare 
figure('Name', "Bode sperimentale - modulo");
scatter(frequenza, guadagno_dB);
set(gca,'xscale','log');
xlim([400 30000]);
ylim([min(guadagno_dB)-0.5 0.5]);
xlabel('Frequenza [Hz]');
ylabel('Guadagno [dB]');
title('Diagramma di Bode del modulo - Dati sperimentali');
grid on

%% Definisico il sistema teorico
R=10000;
C=1e-9;
num = 1;
den = [2*pi*R*C 1];

sys = tf(num, den);

[mag,phase,wout] = bode(sys);

%% Plot on same figure

%Figura
figure('Name', "Dati sperimentali VS Dati teorici: Modulo");
title('Bode Diagram - Module')
hold on

% %Diagramma interpolato
% inter = min(frequenza):0.001:max(frequenza);
% vq1 = interp1(frequenza, guadagno_dB, inter, 'linear');
% plot(frequenza, guadagno_dB,'o',inter,vq1,':.');

%Diagramma teorico
bodemag(sys, {100, 3000000});
%xlim([400 300000]);
ylim([min(guadagno_dB)-0.5 0.5]);

%Diagramma sperimentale
scatter(frequenza, guadagno_dB, 80, 'filled', 'r');
hold off

legend('Diagramma teorico', 'Diagramma sperimentale', 'FontSize',20);
grid on

%% Fase

figure("Name", "Fase");
h = bodeplot(sys, {100, 100000});
setoptions(h,'MagVisible','off');
%xlim([400 30000]);
ylim([min(fase)-0.5 0.5]);
hold on
%Diagramma sperimentale
scatter(frequenza, fase, 80, 'filled', 'r');
scatter(frequenza, fase_xy, 80, 'filled', 'b');
title('Bode Diagram - Phase')
hold off
grid on
grid minor 
legend('Diagramma ideale', 'Modalità YT', 'Modalità XY', 'FontSize',20)