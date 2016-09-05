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

for m=min(yp):max(yp)
    for n=min(xp):max(xp)
        yt
        yt = round(bp'*[n;m;n*m;1]);
        xt = round(ap'*[n;m;n*m;1]);
        if(yt>=min(yp) && yt<=max(yp) && xt>=min(xp) && xt<=max(xp))
            im2(m,n)=im1(yt,xt);
        else
            %im2(m,n)=0;
        end
    end
end

im2=uint8(im2);
%figure, 
imshow(im2);
