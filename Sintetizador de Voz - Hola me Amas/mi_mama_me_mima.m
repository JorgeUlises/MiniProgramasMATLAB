[x,fs]=wavread('../SenalesDeEjemplo/vozfemenina.wav');%Se lee la señal de audio
%Se extraen las vocales y consonantes necesitadas del audio
xm=x(11600+(1:512)').*hamming(512);%m
xi=x(31300+(1:512)').*hamming(512);;%i
xa=x(27700+(1:512)').*hamming(512);%a
xe=x(1650+(1:512)').*hamming(512);%e

L=1600;%La longitud en muestras de las letras sintetizadas
ym=sinte(xm);ym=ym(1:L);
yi=sinte(xi);yi=yi(1:L);
ya=sinte(xa);ya=ya(1:L);
ye=sinte(xe);ye=ye(1:L);

%Se multiplican por una ventana de hamming para superponer las señales
ym = ym.*hamming(length(ym));
yi = yi.*hamming(length(yi));
ya = ya.*hamming(length(ya));
ye = ye.*hamming(length(ye));

V=800;%Se establece la ventana en que se superponen las letras
%Se unen las palabras y luego se superponen las letras
ymi = vertcat(ym,yi);
ymi = superponer(ymi,L,V);
ymama = vertcat(ym,ya,ym,ya);
ymama = superponer(ymama,L,V);
yme = vertcat(ym,ye);
yme = superponer(yme,L,V);
ymima = vertcat(ym,yi,ym,ya);
ymima = superponer(ymima,L,V);
%Se crea una nueva palabra para el silencio
ysi = zeros(512,1);

%Se unen todos los vectores para escucharlos como uno solo
sal = vertcat(ymi,ysi,ymama,ysi,yme,ysi,ymima);
soundsc(sal);
