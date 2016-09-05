%--
%el gradiente se puede hacer con la convolución
%los bordes son oscuros porque las sumas dan más bajas
%--
%convolución para hacer filtraje
clear
I = testmatrix('magi',7)%magic(7)
k = testmatrix('magi',3)%magic(3)
h = k(:,$:-1:1)%fliplr
h = h($:-1:1,:)%flipud
J = conv2(I,k)%conv2(I,k,'full')
J = conv2(I,k,'same')%con solo los píxeles de la imagen?
%está haciendo que el pixel central coindida con el punto de la imagen
im1 = imread('escudo_ud_rainbow.png');
figure, imshow(im1)
k = ones(3)/9;
im2 = uint8(round(conv2(double(im1),k)));
figure, imshow(im2)
%[size(im1),size(im2)]
im2 = uint8(round(conv2(double(im1),k,'same')));
figure, imshow(im2)
size(im2)
k = ones(5)/25;
im3 = uint8(round(conv2(double(im1),k)));
imshow(im3);
%filtro promediador?
k=ones(5,4)/20
%máscara de sobel
k=[-1 0 1; -2 0 2; -1 0 1];
im5 = conv2(double(im1),k,'same');%Derivada horizontal
%[min(im5(;)),max(im5(:))]
figure, imshow(im5,[]), colorbar
im6 = conv2(double(im1),k','same');%Derivada vertical
figure, imshow(im6,[]), colorbar
[H,w]=freqz2(k,[40,40]);
%imshow(H,[],'n'})
stem(H(20,:]))%da un sinc... el filtro promediador es un pulso cuadrado
%siempre una ventana rectangular procude un senoC en frecuencia
