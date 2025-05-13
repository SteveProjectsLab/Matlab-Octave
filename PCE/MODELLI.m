


I_s=1e-15;
V_T=25e-3;



v= linspace (0,1,1000);

f=@(v)I_s*(exp(v/V_T-1));
i=f(v);
axis=([1,2,3,4])
plot (v,i);

grid on;

