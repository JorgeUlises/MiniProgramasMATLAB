close all; 
clear all; clc;
%TRANSFORMACIÓN GEOMÉTRICA BILINEAL

im1 = imread('escudo_ud_rainbow_byn.png');
%im1=uint8(ones(512,512)*255);
im2=im1;
%im2=zeros(size(im1));
im2((1:256),(128:384))=0;
%figure, imshow(uint8(im2));
px = 159;
py = 58;

%%cuadrante 4
x = [256,384,384,256]';
y = [128,128,256,256]';
xp = [px,384,384,256]';
yp = [py,128,256,256]';

Mp = [xp,yp,xp.*yp,ones(4,1)];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;

for m=min(yp):max(yp)
    for n=min(xp):max(xp)
        yt = round(bp'*[n;m;n*m;1]);
        xt = round(ap'*[n;m;n*m;1]);
        if(yt>=min(yp) && yt<=max(yp) && xt>=min(xp) && xt<=max(xp))
            im2(m,n)=im1(yt,xt);
        else
            %im2(m,n)=0;
        end
    end
end

%%cuadrante 3
x = [128,255,255,128]';
y = [128,128,255,255]';
xp = [128,px,255,128]';
yp = [128,py,255,255]';

Mp = [xp,yp,xp.*yp,ones(4,1)];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;

for m=min(yp):max(yp)
    for n=min(xp):max(xp)
        yt = round(bp'*[n;m;n*m;1]);
        xt = round(ap'*[n;m;n*m;1]);
        if(yt>=min(y) && yt<=max(y) && xt>=min(x) && xt<=max(x))
            im2(m,n)=im1(yt,xt);
        else
            %im2(m,n)=0;
        end
    end
end

%%cuadrante 2
x = [256,384,384,256]';
y = [1,1,127,127]';
xp = [256,384,384,px]';
yp = [1,1,127,py]';

Mp = [xp,yp,xp.*yp,ones(4,1)];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;

for m=min(yp):max(yp)
    for n=min(xp):max(xp)
        yt = round(bp'*[n;m;n*m;1]);
        xt = round(ap'*[n;m;n*m;1]);
        if(yt>=min(y) && yt<=max(y) && xt>=min(x) && xt<=max(x))
            im2(m,n)=im1(yt,xt);
        else
            %im2(m,n)=0;
        end
    end
end

%%cuadrante 1
x = [128,255,255,128]';
y = [1,1,127,127]';
xp = [128,255,px,128]';
yp = [1,1,py,127]';

Mp = [xp,yp,xp.*yp,ones(4,1)];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;

for m=min(yp):max(yp)
    for n=min(xp):max(xp)
        yt = round(bp'*[n;m;n*m;1]);
        xt = round(ap'*[n;m;n*m;1]);
        if(yt>=min(y) && yt<=max(y) && xt>=min(x) && xt<=max(x))
            im2(m,n)=im1(yt,xt);
        else
            %im2(m,n)=0;
        end
    end
end







im2=uint8(im2);
%figure, 
imshow(im2);
