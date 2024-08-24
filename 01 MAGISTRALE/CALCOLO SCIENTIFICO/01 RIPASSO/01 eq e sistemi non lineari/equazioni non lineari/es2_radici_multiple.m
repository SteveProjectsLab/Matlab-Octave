clear all
close
clc
set(0,'DefaultFigureWindowStyle','docked');
figure(1);
f=@(x)sin(x-1)-0.5*sin(2*(x-1))
I=[-3,3]
fplot(f,I);mygrid();
hold on;

%cerco la prima radice in un suo intorno
scelta=menu('scegli..', ...
    'newton','secanti')

tol=1.e-8;
kmax=100;

if scelta==1
    fprintf('cerco le radici con il metodo di Newton\n')
    x0=-1.5;
    
    df=matlabFunction(diff(sym(f),1))
    [z1,res1,it1,ERR1]=newton(f,df,x0,tol,kmax);
    plot(z1,res1,'o','MarkerFaceColor','b')
    fprintf('radice trovata con metodo di Newton in (%e,%e),\n con %d ...iterazioni,\n commettendo un errore di %e\n',z1,res1,it1,ERR1(end))
        
    % cerco la seconda radice
    x0=0.1;
    [z2,res2,it2,ERR2]=newton(f,df,x0,tol,kmax);
    plot(z2,res2,'o','MarkerFaceColor','r')
    fprintf('radice trovata con metodo di Newton in (%e,%e),\n con %d iterazioni,\n commettendo un errore di %e\n',z2,res2,it2,ERR2(end))
    x0=1;
    
    % rappresento gli errori in scala logaritmica
    figure(2); clf
    semilogy((0:it1)',ERR1,'Displayname','errore sx')
    legend('-dynamiclegend')
    hold on
    semilogy((0:it2)',ERR2,'DisplayName','errore dx')
    grid on

elseif scelta==2
    fprintf('cerco le radici con il metodo delle secanti\n')
    %cerco la prima radice
    x0=-1.6
    x1=-1.5
    [z1s,res1s,it1s,ERR1s]=secant(f,x0,x1,tol,kmax);
    plot(z1s,res1s,'o','MarkerFaceColor','r')
    fprintf('radice trovata con metodo delle secanti in (%e,%e),\n con %d iterazioni,\n commettendo un errore di %e\n',z1s,res1s,it1s,ERR1s(end))
         
    %cerco la seconda radice 
    x0=0.1
    x1=0.4
    [z2s,res2s,it2s,ERR2s]=secant(f,x0,x1,tol,kmax);
    plot(z2s,res2s,'o','MarkerFaceColor','r')
    fprintf('radice trovata con metodo delle secanti in (%e,%e),\n con %d iterazioni,\n commettendo un errore di %e\n',z2s,res2s,it2s,ERR2s(end))
    
    % rappresento gli errori in scala logaritmica
    figure(2); clf
    semilogy((0:it1s)',ERR1s,'Displayname','errore sx')
    legend('-dynamiclegend')
    hold on
    semilogy((0:it2s)',ERR2s,'DisplayName','errore dx')
    grid on
end
%--------------------------------------------------------------------------
% newton
    % radice1 trovata con metodo di Newton in (1.000000e+00,-3.308722e-24),
    %  con 43 ...iterazioni,
    %  commettendo un errore di 9.169945e-09

    % radice2 trovata con metodo di Newton in (-2.141593e+00,-2.449294e-16),
    %  con 5 iterazioni,
    %  commettendo un errore di 1.580958e-13
%--------------------------------------------------------------------------
% secanti
     % radice trovata con metodo delle secanti in (-2.141593e+00,-2.449294e-16),
     % con 6 iterazioni,
     % commettendo un errore di 3.641532e-14

     % radice trovata con metodo delle secanti in (1.000000e+00,-6.617445e-24),
     % con 61 iterazioni,
     % commettendo un errore di 3.833519e-09
%--------------------------------------------------------------------------
% sia newton che secanti rispettano la teoria per quanto riguarda l'errore
% secanti richiede un'operzione in più di Newton per la radice semplice




