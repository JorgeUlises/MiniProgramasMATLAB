function y = instrumento
    %esta es la frecuencia de muestreo
    fs=48000;
    %se va a generar el acorde de la mayor 
    %frecuencia de la
    fo=440;
    D=4;
    Ns=D*fs;
    Ns
    M=ceil(fs/fo);
    M
    R=ceil(Ns/M);
    R

    x=sin(2*pi*(0:M-1)'/M);
    %x=sawtooth(2*pi*(0:M-1)'/M);
    %x=square(2*pi*(0:M-1)'/M);
  
    a=0.996;
    y1 = sintesis(x,a,R);
    length(y1)
    i=0;
    while(i<1)
    soundsc(y1,fs);
    i=i+1;
    end
    %clear all;
    %close all;
    %clc;
    %plot((0:length(y)-1)'/fs,y);

function y = sintesis(x,a,R)
    %longitud de la señal de entrada
    M = length(x);
    %R es el # de repeticiones
    y = zeros(M*R,1);
    %b comienza en 1 y se va haciendo a luego a^2... a^4 y así...
    %entonces es el amortiguamiento exponencial
    b = 1;
    for i=1:R
        j=(i-1)*M+(1:M)';
        y(j)=b*x;
        b=b*a;
    end

%y=sintesis([1 2 3]' , 0.9 , 4);