function x_quant = myQuant(x, numero_bit_quant)
%MYQUANT :Quantizza il segnale restituendo il valore medio dell'intevallo
%   Dividere la funzione in livelli, dove nuumero_livelli= 2^(numero_bit)
%   Valori di quantizzazione sono i valori mdi degli intervalli
%   (es. I=[0; 0.5] -> valore medio= 0.25 )

dinamica_x= max(x)-min(x);

x_res= x-min(x); %per far si che l'estremo inferiore sia = 0;

%Devo dividere l'asse delle ordinate in intevalli di ampiezza Delta

numero_livelli=2^(numero_bit_quant);
Delta= dinamica_x/numero_livelli;

x_quant= Delta*(floor(x_res/Delta)+0.5);
%Faccio in modo da ottenere il valore medio dell'intevallo,
%ovvero Delta/2, 3*Delta/2, etc

x_quant= x_quant + min(x) - Delta*(x_quant==max(x_quant));
%(x_quant==max(x_quant)):
%restituisce 0 o 1, in base se la condizione è verificata o no
%toglie delta tutte le volte che si raggiunge il massimo

end

