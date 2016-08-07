function y = instrumento
    %Limpiamos el workspace
    clear all;
    close all;
    clc;
    %esta es la frecuencia de muestreo
    fs=48000;
    %se va a generar el acorde de LA mayor 
    %(seg�n http://es.wikipedia.org/wiki/Acorde)
    %adem�s utilizamos el concepto de s�ntesis aditiva
    %(http://es.wikipedia.org/wiki/S%C3%ADntesis_aditiva)
    %para que al sumar las 3 frecuencias nos de el acorde deseado.
    %frecuencia de LA 
    fo1=440;
    %do #
    fo2=277.18;
    %mi 
    fo3=329.63;
    % Duraci�n:
    %cambia la longitud de la muestra, algo as� como el # de seg
    D=1;
    %Numero de muestras Ns (aproximado ya que la se�al al final se recorta) 
    Ns=D*fs;
    %esto me da el phase delay, en pocas palabras, es el # de veces
    %que la se�al cabe en la frecuencia de muestreo, para la frecuencia 
    %de 440 (la) cabe 110 veces y as� sucesivamente
    M1=ceil(fs/fo1);
    M2=ceil(fs/fo2);
    M3=ceil(fs/fo3);
    %Vamos a escoger la menor frecuencia para hallar el 
    %# de veces m�nimo que va a caber la se�al 
    %la frec ponderada es el m�nimo com�n m�ltipo de las 3
    %frecuencia, o sea la frec fundamental de la se�al LA MAYOR
    %de multiplica por 100 y divide por 100 para evitar decimales
    %pero nos dimos cuenta luego que lo que hac�amos era atenuar alfa veces
    %cada periodo de esta. De otra manera, no cabe un periodo dentro de la 
    %representaci�n de fs igual a 48000 ya que un periodo dura 14 seg.
    %esta era la f�rmula que se usaba: %lcm es el m�nimo com�n multiplo
    %%fpond=lcm(lcm(fo1*100,fo2*100),fo3*100)/100;
    %%%%%%%%%%
    %Ahora la frecuencia ponderada era el m�ximo de las 3 frecuencias
    %porque recordemos que por el teorema de nyquist, el problema est� en 
    %las frecuencias altas y no en las bajas.
    fpond=max([fo1,fo2,fo3]);
    %Mt es el n�mero de veces que cabe la frecuencia mayor en este caso 
    %la de 440 en la frecuencia de muestreo fs
    Mt=ceil(fs/fpond);
    %Mt=ceil(fs/(gcd(gcd(fix(fo1),fix(fo2)),fix(fo3))));
    %R1=ceil(Ns/M1);
    %R2=ceil(Ns/M2);
    %R3=ceil(Ns/M3);
    %Rt es el n�mero de repeticiones de la se�al en la duraci�n de D
    %segundos
    Rt=ceil(Ns/Mt);

    %generamos las 3 se�ales bases
    x1=sin(2*pi*(0:M1-1)'/M1);
    x2=sin(2*pi*(0:M2-1)'/M2);
    x3=sin(2*pi*(0:M3-1)'/M3);
    %x=sawtooth(2*pi*(0:M-1)'/M);
    %x=square(2*pi*(0:M-1)'/M);
    
    %hallamos el m�nimo com�n multiplo de las se�ales para la suma
    %posterior, recordemos que esa longitud es el periodo de la se�al LA
    %Mayor
    mcm=lcm(lcm(length(x1),length(x2)),length(x3));
    %Se halla cuantas veces esta cada una de las se�ales base en la
    %se�al de LA MAYOR
    d1=mcm/length(x1);
    d2=mcm/length(x2);
    d3=mcm/length(x3);
    %creamos vectores de x1, x2 y x3 que ser�n replicar la se�al base las
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
    %Se suman las se�ales que son de igual magnitud para dar cabida al
    %vector x
    x=xx1+xx2+xx3;
    %como x demora 14.5544 segundos es necesario recortarlo a la longitud
    %de la se�al b�sica m�xima
    %plot(x);
    %soundsc(x,fs);
    maximo = max([length(x1),length(x2),length(x3)]);
    X=x(1:maximo);
    %plot(x);
    %definimos el factor de atenuanci�n alfa
    a=0.985;
    %sintesis por medio del algoritmo de Karplus Strong
    %http://ears.pierrecouprie.fr/spip.php?article2364
    %cambie el nombre de la variable a y1 para evitar el verbose que da el
    %y en la definici�n de la funci�n instrumento
    y1=sintesis(X,a,Rt);
    soundsc(y1,fs);
    %subplot(1,3,1);
    t=(0:length(y1)-1)'/fs;
    plot(t,y1);
    
    %podr�amos incluso redefinir el valor de R a 1, para escuchar los 14
    %segundos que demora en realidad la se�al LA MAYOR
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
    
    %pero como nos damos cuenta, la atenucaci�n alfa, nunca entra en juego
    %ya que con un R=1 solo se van a reproducir los 14 segundos y despu�s
    %de esa primera vez si entra en cuenta la atenuaci�n. Para verlo mejor,
    %s�lo es necesario aumentar R y graficarlo, ya que de escucharlo nos
    %demorar�amos mucho sin realmente presenciar un cambio. Adem�s de
    %disminuir alfa para hacer evidente el cambio de atenuaci�n.
    R=10;
    a=0.5;
    y1=sintesis(x,a,R);
    subplot(1,3,3);
    t=(0:length(y1)-1)'/fs;
    plot(t,y1);
    %plot(,y);


function y = sintesis(x,a,R)
    %M longitud de la se�al de entrada
    M = length(x);
    %R es el # de repeticiones
    y = zeros(M*R,1);
    %b comienza en 1 y se va haciendo a luego a^2... a^4 y as�...
    %entonces es el amortiguamiento exponencial
    b = 1;
    for i=1:R
        j=(i-1)*M+(1:M)';
        y(j)=b*x;
        b=b*a;
    end

%y=sintesis([1 2 3]' , 0.9 , 4);