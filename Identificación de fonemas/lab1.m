clear all;
[x,fs,nbits]=wavread('../SenalesDeEjemplo/vozfemenina.wav');
E = zeros(194,1);
Z=E;
V=400;
for n=1:194
    i=200*(n-1)+(1:V)';
    y=x(i);
    E(n) = 10*log10(y'*y/V);%dividido en # muestras para energía promedio
    %j=(1:399)';
    %p=y(j).*y(j+1);
    Z(n)=sum(abs(sign(y(2:end))-sign(y(1:end-1))))/798;
end
n=1:194;
%Normalizando
E=(E-min(E))/(max(E)-min(E));
Z=(Z-min(Z))/(max(Z)-min(Z));
sE=zeros(194,1);
sZ=sE;
sS=sE;
%para la energía
for n=1:194
    if E(n)>0.7
        sE(n)=1;
    elseif E(n)<0.4
        sE(n)=0;
    else
        if(n>1)
            sE(n)=sE(n-1);
        else
            sE(n)=0;
        end
    end
end
%para los cruces por cero
for n=1:194
    if Z(n)>0.2
        sZ(n)=1;
    elseif Z(n)<0.1
        sZ(n)=0;
    else
        if(n>1)
            sZ(n)=sZ(n-1);
        else
            sZ(n)=0;
        end
    end
end
%decición de estado
for n=1:194
    if sE(n)==1 && sZ(n)==0
        sS(n)=1;%vocal
    elseif sE(n)==1 && sZ(n)==1
        sS(n)=0.5;%no vocalizado
    else
        sS(n)=0;%silencio
    end
end
n=1:194;
% figure(1);
% plot(n,sE(n),'r');
% hold on;
% plot(n,E(n),'b');
%%% hold on;
% figure(2);
% plot(n,sZ(n),'r');
% hold on;
% plot(n,Z(n),'b');
%%% hold on;
% figure(3);
plot(n,sS(n),'r');
hold on;
k=(0:length(x)-1)/200;
plot(k,abs(x)/max(abs(x)),'b-');
% 
% t=(0:length(x)-1)'/fs;
% n=1:194;
% k=(0:length(x)-1)/200;
% plot(k,abs(x)/max(abs(x)),'b-',n,E,'r-',n,Z,'k-')
% hold on; stem(n,E,'ro')
% hold on; stem(n,Z,'kx')