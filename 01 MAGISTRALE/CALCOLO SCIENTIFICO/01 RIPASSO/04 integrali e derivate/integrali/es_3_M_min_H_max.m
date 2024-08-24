clear
close all
clc

a1=0;b1=pi;
a2=0;b2=1;

format longE

funz=menu('scegli la funzione','f1(x)','f2(x)');

if funz==1 % valuto la funzione 1
    fprintf('valuto la funzione 1\n')
    f1=@(x)exp(x).*cos(x)   % funzione 1
    
    
    x1=linspace(a1,b1,1e3);
    
    d2f1=matlabFunction(diff(sym(f1),2))% @(x)exp(x).*sin(x).*-2.0 ok
    d4f1=matlabFunction(diff(sym(f1),4))% @(x)exp(x).*cos(x).*-4.0 ok
    
    maxd2f1=max(abs(d2f1(x1)))% =1.492096786097506e+01 circa 15 ok
    maxd4f1=max(abs(d4f1(x1)))% =9.256277053111707e+01 circa 92 ok
    maxd2f1=15;
    maxd4f1=92;
elseif funz==2 % valuto la funzione 2
    fprintf('valuto la funzione 2\n')
    f2=@(x)sqrt(x.*(1-x))   
    d2f2=matlabFunction(diff(sym(f2),2))
    %= @(x)(x.*2.0-1.0).^2.*1.0./(-x.*(x-1.0)).^(3.0./2.0).*(-1.0./4.0)-1.0./sqrt(-x.*(x-1.0))
    %cioè - (2*x - 1)^2/(4*(-x*(x - 1))^(3/2)) - 1/(-x*(x - 1))^(1/2)
end

%%

if funz==1 
    metodo=menu('scegli la formula','pmedio','trapezi','simpson');
    err=1e-4
    if metodo== 1 % punto medio
        fprintf('punto medio')
            Hmax=sqrt((err*24)/((b1-a1)*(maxd2f1)))
            M_min=ceil((b1-a1)/Hmax)
    elseif metodo == 2 % trapezi
        fprintf('punto trapezi')
            Hmax=sqrt((err*12)/((b1-a1)*(maxd2f1)))
            M_min=ceil((b1-a1)/Hmax)
    elseif metodo == 3 % simpson
        fprintf('simpson')    
            Hmax=power((err*18*160)/((b1-a1)*(maxd4f1)),1/4)
            M_min=ceil((b1-a1)/Hmax)
    end
else
    fprintf('non posso usare la stima dell''errore, perchè in x=0  d2f2 va a inf')
end



%% per quanto riguarda la funzione 1
if funz==1
    % punto medio c
    % Hmax =     7.155371503539356e-03
    % M_min =   440
    
    % trapezi c
    % Hmax =     5.059611712061661e-03
    % M_min =   621
    
    % simpson c
    % Hmax =     1.773991634288697e-01
    % M_min =    18
    
    %--------------------------------------------------------------------------
    % NB usando le approx 15 e 92 esce come la prof
    
    % punto medio c
    % Hmax =     7.136496464611086e-03
    % M_min =   441
    
    % trapezi c
    % Hmax =     5.046265044040320e-03
    % M_min =   623
    
    % simpson c
    % Hmax =     1.776698341448063e-01
    % M_min =    18
    
    %--------------------------------------------------------------------------
    %l'integrale approssimato alla quarta cifra decimale è
    fprintf('calcolo l''integrale "esatto" e quello approssimato con simpson\n')
    Iex=int(sym(f1),a1,b1)
    % - exp(pi)/2 - 1/2
    % -1.207034631638964e+01
    
    % utilizzando simpson c rispettando Mmin
    Isimpcf1=simpsonc(f1,a1,b1,18)% =    -1.207033078868476e+01 ok
    % l'errore è minore di 1e-4
    
    % utilizzando simpson c NON rispettando Mmin
    Isimpcf1=simpsonc(f1,a1,b1,10)%=         -1.207018398048237e+01 NO?
end
%% per quanto riguarda la funzione 2

% non posso usare la formula per stimare l'errore in quanto va a infinito
% d2f2 in x=0, quindi err=max

