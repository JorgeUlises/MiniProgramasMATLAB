[x,fs]=wavread('../SenalesDeEjemplo/vozfemenina.wav');
xo=x(2750+(1:512)').*hamming(512);%o
xl=x(3450+(1:512)').*hamming(512);%l
xa=x(27700+(1:512)').*hamming(512);%a
xm=x(11600+(1:512)').*hamming(512);%m
xe=x(1650+(1:512)').*hamming(512);%e
xs=x(900+(1:512)').*hamming(512);%s

yo=sinte(xo);
yl=sinte(xl);
ya=sinte(xa);
ym=sinte(xm);
ye=sinte(xe);
ys=sinte(xs);
%ramp=[0:1/100:0.5]
%inramp=1-ramp;
%yy1=vertcat(yy1(1:512*2-1),yy1(512*2:end).*(ramp+1));

yo = yo.*hamming(length(yo));
yl = yl.*hamming(length(yl));
ya = ya.*hamming(length(ya));
ym = ym.*hamming(length(ym));
ye = ye.*hamming(length(ye));
ys = ys.*hamming(length(ys));

v=2000;
yhola = vertcat(yo(1:end-v),yo(end+1-v:end)+yl(1:v),yl(v+1:end-v),yl(end+1-v:end)+ya(1:v),ya(v+1,end));
yme = vertcat(ym,ye);
par=[1:v/2]*2;
impar=par-1;
ympar = ym(end-v+1:end);
yeimpar = ye(1:v);
for i = par
    yeimpar(i) = 0;
end
for i = impar
    ympar(i) = 0;
end
yme = vertcat(ym(1:end-v),yeimpar+ympar,ye(v+1:end));
yhola = vertcat(yo(1:end-v),yo(end+1-v:end)+yl(1:v),yl(v+1:end-v),yl(end+1-v:end)+ya(1:v),ya(v+1,end));
yamas = vertcat(ya,ym,ya,ys);
ysi = zeros(4000,1);

sal = vertcat(yhola,ysi,yme,ysi,yamas);
soundsc(sal);
