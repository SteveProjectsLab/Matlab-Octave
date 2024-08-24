function Jout = E6_fobj(K,grafico)
% 
x0=[0 3]';
y0=10;
%K=[x(1) x(2)];
K1=K(1);
K2=K(2);
a=K(3);
alfa=0.5;
options = simset('SrcWorkspace', 'current');
sim('simulink_E6', [], options);
close_system('simulink_E6');
J1=J1(end);
J2=J2(end);
Jout=alfa*J1+(1-alfa)*J2;

if grafico>0
    %close all;
    figure
    plot(uscita.time,uscita.signals.values);
    hold on
    plot(var_controllo.time,var_controllo.signals.values,'k--');
end
end