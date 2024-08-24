function Jout = fobj_esame(K,grafico)
%[alfa, K4(1), K4(2)] in ordine



x0=0;
y0=5;
%K=[x(1) x(2)];
K1=K(2);
K2=K(3);
%a=; non ci serve
alfa=K(1);

A=[-1 4;0 -5];
B=[1 1]';
C=[1 0];

options = simset('SrcWorkspace', 'current');
sim('simulink_esame', [], options);
close_system('simulink_esame');
J1=ans.J1(end);
J2=ans.J2(end);
% J3=
% J4=
Jout=J1+J2;

end