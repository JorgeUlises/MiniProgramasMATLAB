close all;
clc;
clear all;
A = getB();
P = A;

for k=1:length(P(:,1))
a = P(k,:);
W=neurona(a);
j=1;
while (j<=79)
    if verificar(W,P(j,:))
        W
    else 
        j
        j = 1000;
    end
    j = j + 1;
end
end

