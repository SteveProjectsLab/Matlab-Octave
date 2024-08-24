function resultIntegral = integrale(x,dt)

% We approximate the area underlying the function as the sum of rectangles.
% Multiplying x by dt we create a vector whose k-th generic position
% contains the area value of a rectangle of base dt and height x(k). The
% 'sum' command sums all of these values. Finally, we can factorize dt 
% out of the 'sum' command.

resultIntegral = dt*sum(x);