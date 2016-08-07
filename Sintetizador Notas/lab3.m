clear all;
%close all;
clc;
[x,fs,nbits]=wavread('../SenalesDeEjemplo/vozfemenina.wav');
L = length(x);
y=x(1:end-7);
for n=2:8
    y=y+x(n:(end-8+n));
end
y = y/8;
plot(x(4:end-4),'b-');
hold on
%plot(y,'r--');
%con restas
y=x(2:end) -x(1:end-1);
plot(y,'r--')
%soundsc(x,8000)
