function y = instrumento
    %Limpiamos el workspace
    clear all;
    close all;
    clc;
    %esta es la frecuencia de muestreo
    fs=48000;
    %se va a generar el acorde de LA mayor 
    %(según http://es.wikipedia.org/wiki/Acorde)
    %además utilizamos el concepto de síntesis aditiva
    %(http://es.wikipedia.org/wiki/S%C3%ADntesis_aditiva)
    %para que al sumar las 3 frecuencias nos de el acorde deseado.
    %frecuencia de LA 
    fo1=440;
    %do #
    fo2=277.18;
    %mi 
    fo3=329.63;
    % Duración:
    %cambia la longitud de la muestra, algo así como el # de seg
    D=1;
    %Numero de muestras Ns (aproximado ya que la señal al final se recorta) 
    Ns=D*fs;
    %esto me da el phase delay, en pocas palabras, es el # de veces
    %que la señal cabe en la frecuencia de muestreo, para la frecuencia 
    %de 440 (la) cabe 110 veces y así sucesivamente
    M1=ceil(fs/fo1);
    M2=ceil(fs/fo2);
    M3=ceil(fs/fo3);
    %Vamos a escoger la menor frecuencia para hallar el 
    %# de veces mínimo que va a caber la señal 
    %la frec ponderada es el mínimo común múltipo de las 3
    %frecuencia, o sea la frec fundamental de la señal LA MAYOR
    %de multiplica por 100 y divide por 100 para evitar decimales
    %pero nos dimos cuenta luego que lo que hacíamos era atenuar alfa veces
    %cada periodo de esta. De otra manera, no cabe un periodo dentro de la 
    %representación de fs igual a 48000 ya que un periodo dura 14 seg.
    %esta era la fórmula que se usaba: %lcm es el mínimo común multiplo
    %%fpond=lcm(lcm(fo1*100,fo2*100),fo3*100)/100;
    %%%%%%%%%%
    %Ahora la frecuencia ponderada era el máximo de las 3 frecuencias
    %porque recordemos que por el teorema de nyquist, el problema está en 
    %las frecuencias altas y no en las bajas.
    fpond=max([fo1,fo2,fo3]);
    %Mt es el número de veces que cabe la frecuencia mayor en este caso 
    %la de 440 en la frecuencia de muestreo fs
    Mt=ceil(fs/fpond);
    %Mt=ceil(fs/(gcd(gcd(fix(fo1),fix(fo2)),fix(fo3))));
    %R1=ceil(Ns/M1);
    %R2=ceil(Ns/M2);
    %R3=ceil(Ns/M3);
    %Rt es el número de repeticiones de la señal en la duración de D
    %segundos
    Rt=ceil(Ns/Mt);

    %generamos las 3 señales bases
    x1=sin(2*pi*(0:M1-1)'/M1);
    x2=sin(2*pi*(0:M2-1)'/M2);
    x3=sin(2*pi*(0:M3-1)'/M3);
    %x=sawtooth(2*pi*(0:M-1)'/M);
    %x=square(2*pi*(0:M-1)'/M);
    
    %hallamos el mínimo común multiplo de las señales para la suma
    %posterior, recordemos que esa longitud es el periodo de la señal LA
    %Mayor
    mcm=lcm(lcm(length(x1),length(x2)),length(x3));
    %Se halla cuantas veces esta cada una de las señales base en la
    %señal de LA MAYOR
    d1=mcm/length(x1);
    d2=mcm/length(x2);
    d3=mcm/length(x3);
    %creamos vectores de x1, x2 y x3 que serán replicar la señal base las
    %"d" veces que se consideren hasta que se llegue a l periodo de LA
    %MAYOR
    xx1=x1;
    xx2=x2;
    xx3=x3;
    for i=1:d1-1
      xx1=vertcat(xx1,x1);
    end
    for i=1:d2-1
      xx2=vertcat(xx2,x2);   
    end
    for i=1:d3-1
      xx3=vertcat(xx3,x3);
    end
    %Se suman las señales que son de igual magnitud para dar cabida al
    %vector x
    x=xx1+xx2+xx3;
    %como x demora 14.5544 segundos es necesario recortarlo a la longitud
    %de la señal básica máxima
    %plot(x);
    %soundsc(x,fs);
    maximo = max([length(x1),length(x2),length(x3)]);
    X=x(1:maximo);
    %plot(x);
    %definimos el factor de atenuanción alfa
    a=0.985;
    %sintesis por medio del algoritmo de Karplus Strong
    %http://ears.pierrecouprie.fr/spip.php?article2364
    %cambie el nombre de la variable a y1 para evitar el verbose que da el
    %y en la definición de la función instrumento
    y1=sintesis(X,a,Rt);
    soundsc(y1,fs);
    %subplot(1,3,1);
    t=(0:length(y1)-1)'/fs;
    plot(t,y1);
    
    %podríamos incluso redefinir el valor de R a 1, para escuchar los 14
    %segundos que demora en realidad la señal LA MAYOR
    R=1;
    a=0.9;
    y1=sintesis(x,a,R);
    %subplot(1,3,2);
    t=(0:length(y1)-1)'/fs;
    subplot(2,1,1);
    plot(t,y1);
    subplot(2,1,2);
    plot(t,y1);
    %soundsc(y1,fs);
    
    %pero como nos damos cuenta, la atenucación alfa, nunca entra en juego
    %ya que con un R=1 solo se van a reproducir los 14 segundos y después
    %de esa primera vez si entra en cuenta la atenuación. Para verlo mejor,
    %sólo es necesario aumentar R y graficarlo, ya que de escucharlo nos
    %demoraríamos mucho sin realmente presenciar un cambio. Además de
    %disminuir alfa para hacer evidente el cambio de atenuación.
    R=10;
    a=0.5;
    y1=sintesis(x,a,R);
    subplot(1,3,3);
    t=(0:length(y1)-1)'/fs;
    plot(t,y1);
    %plot(,y);


function y = sintesis(x,a,R)
    %M longitud de la señal de entrada
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