function y = puntomedio(x,dt)
   N=length(x);
   sum=0;
   for k=1:N-1
       sum=sum+(x(k)+x(k+1))/2;
   end
   y=dt*sum;