warning off
if ~(exist('num_c')) 
   clc;
   fprintf('Il sistema di controllo non è stato inserito\n');
elseif isempty(find(num_c~=0))| size(num_c,1)==0
   clc;
   fprintf('Il sistema di controllo non è stato inserito\n');
else
   sys=tf(num_c,den_c);
   sys=minreal(sys);
   num_temp=cell2mat(get(sys,'num'));
   den_temp=cell2mat(get(sys,'den'));
   if ~isempty(roots(num_temp))| ~isempty(roots(den_temp))
      grafico(2,0,num_temp,den_temp,0);
   elseif isempty(roots(num_temp)) & isempty(roots(den_temp))
      clc;
      fprintf('Il sistema di controllo è un guadagno puro\n');
   end
   clear num_temp den_temp
end;

