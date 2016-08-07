clear all;
close all;
clc;
BW = imread('Manuscrito002.png');
im1 = BW>210;
[y,x]=size(im1);
im1=[im1(1:end,1:end-100),ones(y,100)];
im1=~im1;
%imshow(im1);
se=ones(3,3);
im2=imerode(im1,se);%imagen con letras separadas del fondo
se=ones(1,5000);%del ancho de la imagen
im3=imdilate(im2,se);%imagen para sacar filas bonitas a pedazos

se=ones(1,100);
im3b=imdilate(im3,se);%imagen para sacar filas completas
[im3b,numlines]=bwlabel(im3b);

imt=zeros(size(im1));
s=zeros(0,0);
for i=1:numlines
[r, c]=find(im3b==i);%se encuentra la n fila
im4=bwselect(im3b,c,r);%se selecciona la n fila
s = bwarea(im4);
area(i)=s;
    if(s>x*11+1)%si el area de la fila es mayor a 2 pixeles de ancho
        im5=and(im4,im2);%letras por fila
        se=ones(100,1);
        im6=imdilate(im5,se);%letras por filas dilatadas verticalmente
        im6=and(im6,im4);%letras dilatadas junto con fila bonita y separada
        %figure(3),imshow(im6);
        imt=or(imt,im6);%se concatenan filas
        %[labimg, num] = bwlabel(im6);
    end;
end;
se=ones(4,4);
imt=imdilate(imt,se);
imshow(imt);