clc;
clear all;
close all;
BW = imread('im1615.png');
% % phi=2;
%BW=BW(1:360,1:360);
% % for y=-1:1
% %     for x=-1:1
% %         %gxy(x+2,y+2)=exp(-((x^2)+(y^2))/(2*phi^2));
% %         %gxy(x,y)=exp(-((x^2)+(y^2))/(2*phi^2));
% %         %Gxy(y,x)=(1/(2*pi*(phi)^2))*exp(-(((x-tam(2)/2)^2)+((y-tam(1)/2)^2))/(2*phi^2));
% %         Gxy(y+2,x+2)=(1/(2*pi*(phi)^2))*exp(-(((x)^2)+((y)^2))/(2*phi^2));
% %     end;
% % end;
%Gxy=double(gxy/max(gxy(:)));
%Gxy=1/159*[1,4,7,4,1;4,20,33,20,4;7,33,55,33,7;4,20,33,20,4;1,4,7,4,1];
% % tam=size(BW);
% % im1=BW;
% % for y=2:tam(1)-1
% %     for x=2:tam(2)-1
% %         im1(y,x)=...
% %             Gxy(1,1)*BW(y+1,x-1)+Gxy(1,2)*BW(y+1,x)+Gxy(1,3)*BW(y+1,x+1)...
% %             +Gxy(2,1)*BW(y,x-1)+Gxy(2,2)*BW(y,x)+Gxy(2,3)*BW(y,x+1)...
% %             +Gxy(3,1)*BW(y-1,x-1)+Gxy(3,2)*BW(y-1,x)+Gxy(3,3)*BW(y-1,x+1);
% %     end;
% % end;
% fn = imnoise(BW,'gaussian'); 
% h1=fspecial('gaussian'); 
% h2=fspecial('average'); 
% g1=imfilter(fn,h1); 
% im1=imfilter(fn,h2); 
%imshow(im1);
im2 = edge(BW,'Canny');
%se = [0,1,0;1,1,1;0,1,0];
%se = strel('disk',3);
%im3 = imclose(im2,se);
im3= imfill(im2,'holes');
imshow(~im3);