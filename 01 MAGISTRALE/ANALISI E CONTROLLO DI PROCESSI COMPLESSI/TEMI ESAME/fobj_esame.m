function Jout = E6_fobj(K,grafico)
% 
x0=;
y0=;
%K=[x(1) x(2)];
K1=;
K2=;
a=;
alfa=;

options = simset('SrcWorkspace', 'current');
sim('simulink_E6', [], options);
close_system('simulink_esame');
J1=
J2=
J3=
J4=
Jout=

if grafico>0
    %close all;
    figure
    plot(uscita.time,uscita.signals.values);
    hold on
    plot(var_controllo.time,var_controllo.signals.values,'k--');
end
end