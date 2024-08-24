function mySchwarz(x,y,dt)
psxy= myScalarProduct(x,y,dt);
if((myNorm(x,dt)*myNorm(y,dt))>=abs(psxy))
    fprintf('La disuguaglianza di Schwarz è verificata!');
else 
    fprintf('La disuguaglianza di Schwarz NON è verificata!');
end