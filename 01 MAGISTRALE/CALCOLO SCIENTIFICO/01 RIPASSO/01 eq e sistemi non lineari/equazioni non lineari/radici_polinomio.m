clear all
close
clc

%p(x)=x^4-3x^3-3x^2+7x+6

% voglio trovare le sue radici

a=[1 -3 -3 7 6]

x=roots(a)
  %  3.0000 + 0.0000i
  %  2.0000 + 0.0000i
  % -1.0000 + 0.0000i
  % -1.0000 - 0.0000i


  % non bastano le cifre in questo formato
  % cambio formato e ricalcolo


  format long e
  x
     %  3.000000000000001e+00 + 0.000000000000000e+00i
     %  1.999999999999998e+00 + 0.000000000000000e+00i
     % -9.999999999999996e-01 + 1.229656911965825e-08i
     % -9.999999999999996e-01 - 1.229656911965825e-08i

  % il polinomio ha 4 radici

x-ones(4,1)
     %  2.000000000000001e+00 + 0.000000000000000e+00i
     %  9.999999999999980e-01 + 0.000000000000000e+00i
     % -2.000000000000000e+00 + 1.229656911965825e-08i
     % -2.000000000000000e+00 - 1.229656911965825e-08i
  % le radici semplici sono calcolate bene fino alla 15-esima cifra
  % la radice doppia fino alla settima, ottava


  