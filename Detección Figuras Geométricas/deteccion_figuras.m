BW = imread('FigurasGeometricasGrandes.png');
%de intensidad 50 hacia arriba
im1=BW>50;
se=[0,1,0;1,1,1;0,1,0];
%im2=imerode(im1,se);
im2=imdilate(im1,se);
im3=im2-im1;
%im4=xor(im2,im1);la misma cosa
im4=bwlabel(im3);
