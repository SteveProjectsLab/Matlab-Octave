clear all
numberOfVariables = 3; % le due componenti di K e a
lb = [];
ub = [];
opts =optimoptions(@ga);		% dammi le opzioni di default
opts.UseParallel=true;		% usa tutti i core del computer
opts.Display='iter';			% per Vedere che si muova qualcosa
opts.PopulationSize=100;		% dimensione popolazione
opts.MaxTime=300; 		% in secondi		

%file_name=sprintf('%s_Pop_03d.mat',label_test,opts.PopulationSize);
[Kga,fval,Output] = ga(@(K) E6_fobj(K,0),numberOfVariables,[],[],[],[],lb,ub,[],opts);
fobj_GA=E6_fobj(Kga,1);

% opts =optimoptions('Particleswarm');
% opts.UseParallel=true;
% opts.Display='iter';
% opts.InitialSwarmSpan=2000;
% opts.MaxTime=1000;
% [xps,fval,Output] = particleswarm(@(x) E6_fobj(x,0),numberOfVariables,lb,ub,opts);
% fobj_PS=E7_fobj(xps,1);
% save(strcat(label_test,'_',file_name,'.mat'));

% 
% 
%                                   Best           Mean      Stall
% Generation      Func-count        f(x)           f(x)    Generations
%     1              200           33.75       2.971e+04        0
%     2              295           33.75        1.87e+04        1
%     3              390           33.75       2.069e+04        2
%     4              485           33.74       1.667e+04        0
%     5              580           33.74        2.26e+04        1
%     6              675           33.74       1.826e+04        2
%     7              770           33.74       2.334e+04        3
%     8              865           33.74       1.094e+04        4
%     9              960           33.74            9456        5
%    10             1055           33.74            4202        6
% ga stopped because it exceeded options.MaxTime.