[x,fs]=wavread('../SenalesDeEjemplo/vozfemenina.wav');
xo=x(2750+(1:512)').*hamming(512);%o
xl=x(3450+(1:512)').*hamming(512);%l
xa=x(27700+(1:512)').*hamming(512);%a
xm=x(11600+(1:512)').*hamming(512);%m
xe=x(1650+(1:512)').*hamming(512);%e
xs=x(900+(1:512)').*hamming(512);%s

L=2000;
yo=sinte(xo);yo=yo(1:L);
yl=sinte(xl);yl=yl(1:L);
ya=sinte(xa);ya=ya(1:L);
ym=sinte(xm);ym=ym(1:L);
ye=sinte(xe);ye=ye(1:L);
ys=sinte(xs);ys=ys(1:L);

yo = yo.*hamming(length(yo));
yl = yl.*hamming(length(yl));
ya = ya.*hamming(length(ya));
ym = ym.*hamming(length(ym));
ye = ye.*hamming(length(ye));
ys = ys.*hamming(length(ys));

V=L/2;
yhola = vertcat(yo,yl,ya);
yhola = superponer(yhola,L,V);
yme = vertcat(ym,ye);
yme = superponer(yme,L,V);
yamas = vertcat(ya,ym,ya,ys);
yamas = superponer(yamas,L,V);
ysi = zeros(512,1);

sal = vertcat(yhola,ysi,yme,ysi,yamas);
soundsc(sal);
