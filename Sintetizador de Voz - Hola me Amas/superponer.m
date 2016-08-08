function [ y ] = superponer(x,L,V)
R = length(x)/L;%cantidad de pistas
y=x(1:V);%la primera parte de la palabra no es modificada
for i=1:R-1
    xant=x(((i*L)-V)+(1:V)');%V muestras de la pista anterior
    xpos=x((i*L)+(1:V)');%V muestras de la pista siguiente
    x1=x((((i-1)*L)+V)+(1:L-2*V)');%Muestras entre los cruces de las pistas
    y = vertcat(y,x1,xant+xpos);%Concatenar las muestras
end
x2 = x(((((R-1)*L)+V))+(1:L-V)');%la última parte de la palabra no es superpuesta
y=vertcat(y,x2);%concatenar x2 a y
end

