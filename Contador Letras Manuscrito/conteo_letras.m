% hay hombre que lucha un dia y son buenos.
% Hay otros que luchan un año y son mejores.
% Hay quienes lucha muchos años y son muy buenos.
% Pero hay los que muchan toda la vida;
% estos son imprescindibles.
% Bertold Brecht
BW = imread('TextoManuscritoBinario.png');
im1=[ones(384,51),BW(1:end,52:end)];
im1=~im1;
%se=strel('square',2);
%se=[0,1,0;0,1,0;0,1,0];
se=ones(2,2);
im2=imerode(im1,se);%imagen con letras separadas

se=ones(1,10);
im3=imdilate(im1,se);%imagen para sacar filas bonitas a pedazos
figure(3),imshow(im3);
se=ones(5,1);
im3=imdilate(im3,se);%arreglar problemas de columnas
figure(3),imshow(im3);
se=ones(1,100);
im3b=imdilate(im1,se);%imagen para sacar filas completas
im3b=bwlabel(im3b);


imt=zeros(size(im1));
for i=1:9
[r, c]=find(im3b==i);%se encuentra la n fila
im4=bwselect(im3b,c,r);%se selecciona la n fila
im4=and(im4,im3);%imagen de la fila seleccionada pero bonita y separada
im5=and(im4,im2);%letras por fila
se=ones(100,1);
im6=imdilate(im5,se);%letras por filas dilatadas verticalmente
im6=and(im6,im4);%letras dilatadas junto con fila bonita y separada
%figure(3),imshow(im6);
imt=or(imt,im6);%se concatenan filas
%[labimg, num] = bwlabel(im6);
end;

numlet=0;
[iml, num] = bwlabel(imt);
imf=zeros(size(imt));

for i=1:num
[r, c]=find(iml==i);
imr=bwselect(iml,c,r);
s = bwarea(imr);
% figure(3),imshow(imr);
area(i)=s;
% pause(1);
if s>=40%78
    numlet=numlet+1;
    imf=or(imf,imr);
end
end
numlet
%L = bwlabel(im1);
%se=strel('square',3);
% se=ones(21,1);
% im2=imdilate(im1,se);
% se=ones(1,49);
% im3=imdilate(im1,se);
% im4=and(im2,im3);
figure(1),imshow(im1),title('imagen original');
figure(2),imshow(imt),title('imagen original');