clear all
a=0.5;
b=2;
c=3;
d=0.5;

A=[-a b;c -d];
B=[1;1]; % coefficienti della u nella prima e nella seconda equazione di stato
C=[1 1]; % coefficienti della x nella trasformazione di uscita
% PUNTO 1: calcolo pto equilibrio
% dx/dt=0=>dx/dt=Ax+Bu=>Ax+Bu=0
% se ueq=0=>non intervento
x0=[0.5,0.3]';
ueq=0;
xeq=-inv(A)*B*ueq % => [0,0]
% classificazione del pto di equilibrio
aval=eig(A)  
% => autovalori reali discordi => xeq è una sella
% xeq è pto di equilibrio instabile => sistema instabile

% controllo 1: u=-K1*x
% K1 deve garantire che il sistema sia all'eq.
% in T=5
% Se T=5 allora costante di tempo dominante del sistema
% deve essere: Td=T/5=>Td=1=>Pd=-1/Td=-1
% Il sistema retroazionato: 
% dx/dt=Ax+Bu=Ax-BK1*x=(A-BK1)x
% dovrà avere un autovalore dominante in -1
% sul secondo autovalore ho solo due vincoli:
% 1) deve essere stabile
% 2) non deve essere dominante
% => -5 rispetta queste specifiche 
% (come tutti gli autovalori più negativi di -1)
avalD=[-1 -5];
rR=rank(ctrb(A,B))
K1=place(A,B,avalD)

% controllo 2: u=-K2x+alfa*Y0 con Y0 è pari al setpoint
% dx/dt=Ax+B(-K2x+alfa*Y0)=(A-BK2)x+B*alfa*Y0
K2=K1;
alfa=-inv(C*inv(A-B*K2)*B)

% nel caso in cui x non sia misurabile=>osservatore dello stato
% verifico la osservabilità
rO=rank(obsv(A,C)) % 2, cioé massimo=> procedo al posizionamento degli autovalori di (A-LC)
%EIG(A-LC)=EIG(A-LC)'=>EIG(A'-(LC)')=>(EIG(A'-C'L'))
avalO=avalD*10;
L=place(A',C',avalO)'


