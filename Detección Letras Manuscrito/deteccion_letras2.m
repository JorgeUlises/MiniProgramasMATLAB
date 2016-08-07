clear all;
close all;
clc;
%leer imagen a blanco y negro
BW1 = imread('Manuscrito001.png');
%convertir a blanco y negro con umbral
im1 = BW1>210;
[y,x]=size(im1);
%quitar ruido del borde derecho reemplazando por cero
im1=[im1(1:end,1:end-100),ones(y,100)];
%imagen en negativo
im1=~im1;
%imshow(im1);
%erosionar la imagen para eliminar bordes de los cuadros
se=ones(3,3);
im2=imerode(im1,se);%imagen con letras separadas del fondo

%se saca la imagen de las filas con ruido
se=ones(1,100);%del ancho de la imagen
im3=imdilate(im1,se);%imagen para sacar filas bonitas a pedazos
im3a = bwconvhull(im3,'objects');%filas más bonitas

%se filtra el ruido de la imagen de las filas quitando a las de areas
%pequeñas
[im3a,numlines]=bwlabel(im3a);
im3b = zeros(size(im3a));
for i=1:numlines
[r, c]=find(im3a==i);%se encuentra la n fila
fakerow=bwselect(im3a,c,r);%se selecciona la n fila
s = bwarea(fakerow);
area(i)=s;
if(s>x*10+1)%si el area de la fila es mayor a 15 pixeles de ancho
    realrow = fakerow;
    se=ones(15,15);
    realrow=imerode(realrow,se);
    im3b=or(im3b,realrow);
    clear realrow;
end;
end;

%se muestran las letras que existen en la fila. Se elimina el ruido que hay
%fuera de las filas
[im3bb,numlines]=bwlabel(im3b);
im3c = zeros(size(im3a));%Imagen con letras limpias.
for i=1:numlines
[r, c]=find(im3bb==i);%se encuentra la n fila
row=bwselect(im3bb,c,r);%se selecciona la n fila
letinrow=and(im2,row);%letras por fila
im3c=or(im3c,letinrow);%se concatenan filas
end;

%Se realiza la dilatación de la imagen con letras para detectar 
se=ones(100,5);
im3d=imdilate(im3c,se);
[im3d,numlines]=bwlabel(im3d);%Imagen que hace un cuadro con todas las letras

%se descartan las letras detectadas en el paso anterior, descartando a las
%de de área pequeña
im3e = zeros(size(im3a));
for i=1:numlines
[r, c]=find(im3d==i);%se encuentra la n fila
fakeletter=bwselect(im3d,c,r);%se selecciona la n fila
s = bwarea(fakeletter);
area(i)=s;
if(s>100*6)%si el area de la letra es mayor a la del pixel solo o dos dilatado
    realletter = fakeletter;
    im3e=or(im3e,realletter);
    clear realrow;
end;
end;

%intenta recorrer filas y columna en orden para hallar sus características,
%pero no funciona
[im6,numlines]=bwlabel(im3b');
numrows = unique(im3b);
im6=im6';
for i=1:numrows
[r, c]=find(im3b==i);%se encuentra la n fila
fila=bwselect(im3b,c,r);
[im5,numletters]=bwlabel(and(im3c,fila));%Imagen que tiene los cuadros de las letras
for i=1:numlines
[r, c]=find(im5==i);%se encuentra la n fila
letra=bwselect(im3c,c,r);%se selecciona el cuadro en la imagen con letras
end;
end;





