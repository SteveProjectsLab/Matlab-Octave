function y= segnalePeriodico(segnale_base, periodo, t)
%SEGNALEPERIODICO 
%   y= (segnale_base)(δn(t))
%   Indica un segnale periodicon di periodo n: dato dalla ripetizione del
%   segnale_base ogni n spazi

T= periodo;
y=zeros(1, length(t));


for k = floor(min(t)/T): ceil(max(t)/T)  
    
    y= y + traslazione(segnale_base, k*T ,t);
    
    
end

end

