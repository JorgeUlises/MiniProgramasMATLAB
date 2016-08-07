close all; clear all; clc;
%TRANSFORMACIÓN GEOMÉTRICA BILINEAL IMAGEN 2

im1 = imread('PlacasAutomoviles/placa_001.png');
y = [252,246,281,288]';
x = [288,351,349,286]';
yp = [1,1,160,160]';
xp = [1,330,330,1]';
M = [ones(4,1),x,y,x.*y];
a = M^(-1)*xp;
b = M^(-1)*yp;
Mp = [ones(4,1),xp,yp,xp.*yp];
ap = Mp^(-1)*x;
bp = Mp^(-1)*y;
for m=1:160, for n=1:330, im2(m,n)=im1(round(bp'*[1;n;m;n*m]), round(ap'*[1;n;m;n*m])); end; end;

figure, imshow(im2);