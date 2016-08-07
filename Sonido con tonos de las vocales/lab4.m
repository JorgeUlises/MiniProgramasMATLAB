clear all; 
clc; 
[x,fs]=wavread('../SenalesDeEjemplo/vozfemenina.wav'); 
x=x(11600+(1:512)'); 
%x=x(801:1200);
%plot(x); 
[N,F,A,W]=firpmord([0.025 0.035 0.095 0.105],[0 1 0],[1 1 1]/100);
h=firpm(N,F,A,W); 
x=conv(h,x); 
L=length(x);
for f=120:2:400%se toma hasta 400 para tomar el segundo armonico... 
    for i=0:100 
        y=sin(2*pi*f*(i+(0:L-1)')/fs);%contrulle señal seno variando la fase 
        nx=sqrt(x'*x);%magnitud de x 
        ny=sqrt(y'*y);%magnitud de y 
        ro(i+1)=y'*x/(nx*ny);%coeficiente de correlacion 
    end; 
    mxro(f/2-59)=max(ro); 
end;
f=(120:2:400);
plot(f,mxro);
%grid on;
a=repmat(max(mxro),1,length(mxro))-mxro;
b=find(~a);
b=b(1);
tono=f(b);