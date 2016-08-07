function [tono]=valortono(x,fs)
	%se hace el filtro digital
    [N,F,A,W]=firpmord([0.025 0.035 0.095 0.105],[0 1 0],[1 1 1]/100);
    h=firpm(N,F,A,W);
	%se hace la convolución de la respuesta al impulso con la señal x
    x=conv(h,x); 
    L=length(x);%longitud de L
    for f=120:2:400%se toma hasta 400 para tomar el segundo armonico... 
        for i=0:100 
            y=sin(2*pi*f*(i+(0:L-1)')/fs);%contrulle señal seno variando la fase 
            nx=sqrt(x'*x);%magnitud de x 
            ny=sqrt(y'*y);%magnitud de y 
            %ro(i+1)=y'*x/(nx*ny);%coeficiente de correlacion 
            ro(i+1)=y'*x/(nx*ny);
        end; 
        mxro(f/2-59)=max(ro); 
    end;
	%los valores de frecuencias para el barrido
    f=(120:2:400);
    %plot(f,mxro);
    %grid on;
	%se haya el máximo valor de los ro entre el sonido
    a=repmat(max(mxro),1,length(mxro))-mxro;
    b=find(~a);
    b=b(1);
	%ese es el tono que corresponde al máximo ro y el que se retorna
    tono=f(b);
end

%k=(0:length(x)-1)/200;

