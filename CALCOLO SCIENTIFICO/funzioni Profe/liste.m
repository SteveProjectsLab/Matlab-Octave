function [lbor,lint,lintint,lgamma,ifro]=liste(ifro,nov);
% LISTE Assembles lists of internal, boundary, interface nodes.
%  [lbor,lint,lintint,lgamma,ifro]=liste(ifro,nov);
%
% All lists are referred to global ordering on Omega
%
% Input : ifro = column array of length noe=nov(npdx*npdy,ne):
%            if (x_i,y_i) is internal to Omega then ifro(i)=0,
%            if (x_i,y_i) is on \partial\Omega and Dirichlet boundary
%            condition is imposed there, then ifro(i)=1,
%            if (x_i,y_i) is on \partial\Omega and Neumann boundary
%            condition is imposed there, then ifro(i)=31,
%         nov = local -global map, previously generated by cosnov_2d
%
% Output:
%        lbor= list of boundary nodes
%        lint= list of internal nodes
%        lintint= list of internal nodes which are internal to spectral elements
%        lgamma= list of internal nodes which are on the interface between 
%                spectral elements
%
%
% Reference: CHQZ2 = C. Canuto, M.Y. Hussaini, A. Quarteroni, T.A. Zang,
%                    "Spectral Methods. Fundamentals in Single Domains"
%                    Springer Verlag, Berlin Heidelberg New York, 2006.

%   Written by Paola Gervasio
%   $Date: 2007/04/01$

[ldnov,ne]=size(nov);
noe=nov(ldnov,ne);
v=zeros(noe,1);
for ie=1:ne
for i=1:ldnov
ip=nov(i,ie);
v(ip)=v(ip)+1;
end
end


lint=[];lbor=[];lgamma=[]; lintint=[];
for i=1:noe
if(ifro(i)==1)
lbor=[lbor;i];
else
lint=[lint;i];
end
if(v(i)>1 & ifro(i)==0)
ifro(i)=-1;
end
end

for i=1:length(lint)
if(ifro(lint(i))==-1)
lgamma=[lgamma;i];
else
lintint=[lintint;i];
end
end

return
