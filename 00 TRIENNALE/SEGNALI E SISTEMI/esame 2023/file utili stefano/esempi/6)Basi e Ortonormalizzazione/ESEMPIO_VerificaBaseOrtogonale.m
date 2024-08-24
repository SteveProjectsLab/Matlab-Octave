dt=0.01;
t=-10:dt:10;

%x= sin(t);
%x=cos(t);
x=sin(t).*abs(t);
dim=21;

B=zeros(dim, length(x));

figure   %crea un nuovo grafico su cui stamapare la funzione BASE
hold on
for k=1:dim
    
    B(k,:)= tri( t-k+11);  
    
end
plot (t, B)

verificaBaseOrtogonale(B, dim, t)

%%
%ORTONORMALIZZO e Verifico

B_ort=myOrtonormalizzazioneGramSchmidt(B, dim, x, dt);

verificaBaseOrtogonale(B_ort, dim, t)