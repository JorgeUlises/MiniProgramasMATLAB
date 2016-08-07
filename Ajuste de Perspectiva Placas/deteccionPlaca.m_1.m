close all; clear all; clc;
%TRANSFORMACIÓN GEOMÉTRICA AF�?N

im1 = imread('PlacaBlancoNegro.bmp');
y = [63,20,132]';
x = [84,295,310]';
yp = [1,1,160]';
xp = [1,330,330]';
M = [ones(3,1),x,y];
a = M^(-1)*xp;
b = M^(-1)*yp;
Mp = [ones(3,1),xp,yp];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;
for m=1:160
    for n=1:330
        im2(m,n)=im1(round(bp'*[1;n;m]),round(ap'*[1;n;m]));
    end;
end;

figure, imshow(im2);