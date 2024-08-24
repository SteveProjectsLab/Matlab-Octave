%SCHEMA ORTOGONALIZZAZIONE Gram Schmidt 
%Base: Φ = {ϕk(t)}, con k=dimensione

%Costruisco Φ2= {ψk(t)}:
%se k=1: ψ1=ϕ1 / ||ϕ1||;
%se k≠1: ψk=vk / ||vk||    , con vk= φk - sum(da r a k-1){ < φk, ψr >ψr }