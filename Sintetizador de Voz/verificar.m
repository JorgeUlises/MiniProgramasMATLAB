function [ y ] = verificar( W , a )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T = 1;
s = 0;
for j = 2:length(W)
    s = s + W(j)*a(j-1);
end
z(1) = 1/(1+exp(-s));
err = T - z(1); 
if(err < 0.0001)
    y = 1;
else
    y = 0;
end
end

