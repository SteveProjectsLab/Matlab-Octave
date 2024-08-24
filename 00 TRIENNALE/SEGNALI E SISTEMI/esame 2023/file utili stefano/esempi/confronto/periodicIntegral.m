function f = periodicIntegral(x,t,dt,T)
    f = integrale((x.*rect((t-T/2)/T)).^2,dt)/T;
end