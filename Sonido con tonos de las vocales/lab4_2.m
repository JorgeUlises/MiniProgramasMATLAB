clear all;
[x,fs,nbits]=wavread('../SenalesDeEjemplo/vozfemenina.wav');

V=400;%tamaño de la ventana%ventanas muestras en tiempo
dt=194;%discriminante de tiempo %número de muestras en el tiempo para la señal
dev=200;%distancia entre ventanas
E = zeros(dt,1);
Z=E;

%Se crea el vector de energía y cruces por cero a partir de la ventana
for n=1:dt
    i=dev*(n-1)+(1:V)';
    y=x(i);
    E(n) = 10*log10(y'*y/V);%dividido en # muestras para energía promedio
    %j=(1:399)';
    %p=y(j).*y(j+1);
    Z(n)=sum(abs(sign(y(2:end))-sign(y(1:end-1))))/798;
end

%Normalizando
E=(E-min(E))/(max(E)-min(E));
Z=(Z-min(Z))/(max(Z)-min(Z));
sE=zeros(dt,1);
sZ=sE;
sS=sE;
%disparador de ventana para la energía
for n=1:dt
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
for n=1:dt
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
%decición de estado silencio/vocalicado/novocalizado
i=1;
j=1;
k=1;
for n=1:dt
    if sE(n)==1 && sZ(n)==0
        sS(n)=1;%vocalizado
        ssVE(i)=E(n);
        ssVZ(i)=Z(n);
        i=i+1;
    elseif sE(n)==1 && sZ(n)==1
        sS(n)=0.5;%no vocalizado
        snVE(j)=E(n);
        snVZ(j)=Z(n);
        j=j+1;
    else
        sS(n)=0;%silencio
        ssSE(k)=E(n);
        ssSZ(k)=Z(n);
        k=k+1;
    end
end

% plot(ssSE,ssSZ,'*r');hold on;
% plot(ssVE,ssVZ,'*b');hold on;
% plot(snVE,snVZ,'*c');hold on;

tonos = zeros(dt,1);
for n=1:dt
    if(sS(n)==1)%es un sonido vocalizado
        ini=n*dev;%posición inicial de la ventanas
        fin=ini+V;%posición final de la ventana
        xx=x(ini:fin);%recorta el sonido vocalizado para analizar el tono
		%se analiza el tono en la función especificada en el archivo valortono.m
        tonos(n)=valortono(xx,fs);
    end
end
n=(1:dt);
tn=(n*length(x))/(fs*dev);
%hold on;
%tonosnorma = (tonos-min(tonos))/(max(tonos)-min(tonos));
%stem(n,tonosnorma,'y');
%figure(2);
stem(n,tonos,'b');

