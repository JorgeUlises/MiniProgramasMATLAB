function [ W ] = neurona( a )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
T = 1;
W = zeros(13,1);
W(1) = a(13);
err = 1;
while(err >= 0.001)
s = 0;
for j = 2:length(W)
    s = s + W(j)*a(j-1);
end
z(1) = 1/(1+exp(-s));
err = T - z(1);
if(err < 0.001)
    mjs='Terminado';
    mjs
else
    etta = rand(1) *100;
    for n=1:length(W)-1%13
        W(n+1) = W(n) + (etta * err * z * (1 - z) * a(n));
        %W(n)
        %etta * err * z(1) * (1 - z(1)) * a(n)
        %W(n+1)        
    end
    %W
end
end
end

