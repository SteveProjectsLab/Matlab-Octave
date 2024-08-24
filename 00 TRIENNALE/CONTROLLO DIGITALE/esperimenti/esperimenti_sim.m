num=1000*[10 1];
den=conv([100 1],[0.1 1]);
G=tf(num,den)

dcgain(G)
[z,p,k]=zpkdata(G,'v')

%SISTEMA PIU VELOCE, STABILE

sys1=tf(1,[10 1])
%p=roots([10 1])


%SISTEMA PIU LENTO
sys2=tf(1,[100 1])

%SISTEMA INSTABILE 

%ANELLO APERTO
sys3=tf(1,[1 1])

figure(1)
    subplot(1,2,1)
    bode(sys3)
    subplot(1,2,2)
    nyquist(sys3)

p=roots([10 1])

 %ANELLO CHIUSO
Gcl1=sys3/(1+sys3)
    %osservazioni
    P=0
    N=0
    Z=P-N %0





nyquist(Gcl1)
%instabile= fa un giro attorno (-1,0)
% in senso orario


%pzmap(G)
