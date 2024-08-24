clear all
numberOfVariables = ; 
opts =optimoptions(@ga);
opts.UseParallel=true; 
opts.Display='iter';
opts.PopulationSize=10;
opts.MaxTime=150; 
Ad=;
Bd=;
Ae=;
Be=;
lb = ;
ub = ;

[Kga,fval,Output] = ga(@(K) esame_fobj(K,0),numberOfVariables,Ad,Bd,Ae,Be,lb,ub,[],opts);
fobj_GA=E6_fobj(Kga,1);
