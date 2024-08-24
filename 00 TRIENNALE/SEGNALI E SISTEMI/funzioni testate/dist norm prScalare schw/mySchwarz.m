function mySchwarz(x,y,dt)
psxy= myScalarProduct(x,y,dt);
nx = myNorm(x,dt); ny = myNorm(y,dt);

fprintf('|<x,y>|<=||x||*||y||: %.3f<=%.3f*%.3f=%.3f\n', ...
        abs(psxy),nx,ny,nx*ny);

if((nx*ny)>=abs(psxy))
    fprintf('La disuguaglianza di Schwarz è verificata!\n');
else 
    fprintf('La disuguaglianza di Schwarz NON è verificata!\n');  
end