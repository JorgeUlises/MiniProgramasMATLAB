clc;
clear all;
close all;
%pkg load image;
BW1 = imread('im1615.png');
lum=imhist(BW1);
%der=diff(lum,1);
% int(1)=0;
% figure;
% subplot(2,1,1), plot(1:length(lum),lum,'b',1:length(lum),ones(1,length(lum))*mean2(lum),'r');
% subplot(2,1,2), plot(der);
% return;
prom=mean2(lum);
limi=100;%fix(mean2(BW));
prim=find(lum(limi:end)>prom,true,'first');
inds=limi+prim;%primero con mayor valor que el promedio y mayor a 100
inv=flipud(lum(1:inds));
for i=1:length(inv)
    seg=find(inv(i:end)>inv(i),true,'first');
    if(~isempty(seg))
        seg=seg+i;
        break;
    end;
end;
pico2=inds-seg;
valle=find(lum(pico2:inds)==min(lum(pico2:inds)),true,'last');
valle=pico2+valle-1;
% maxi=find(der==max(der));
%invder=flipud(der(1:maxi));
%prom=mean2(invder);
%b=find(a==max(a));
%c=flipud(a(1:b));
%prim=find(c<420,true,'first');
%d=b-prim;
%prom=mean2(a);
%find(a==max(a));
%b=diff(a,1);
%c=abs(b);
%d=mean2(c);
%e=c>=d;
%prim=find(e,1,'first');
im1=BW>valle;
imshow(~im1);
[Label,Total]=bwlabel(~im1);
imshow(Label);

num=max(Label(:));
for i=1:num
    
[row, col]=find(Label==i);

%Find Bounding box - Cuadro delimitador
sx=min(col)-0.5;
sy=min(row)-0.5;
breadth=max(col)-min(col)+1;%ancho
len=max(row)-min(row)+1;%alto
BBox=[sx sy breadth len];
display(BBox);

%figure,imshow(BW);
hold on;
x=zeros([1 5]);
y=zeros([1 5]);
x(:)=BBox(1);
y(:)=BBox(2);
x(2:3)=BBox(1)+BBox(3);
y(3:4)=BBox(2)+BBox(4);
%Se dibuja bounding box
plot(x,y);

 %Find Area
Obj_area=numel(row);
display(Obj_area);
%Find Centroid
X=mean(col);
Y=mean(row);
Centroid=[X Y];
display(Centroid);
plot(X,Y,'ro','color','r');
hold off;

 %Find Perimeter
% BW=bwboundaries(Label==num);
% c=cell2mat(BW(1));
% Perimeter=0;
% for i=1:size(c,1)-1
% Perimeter=Perimeter+sqrt((c(i,1)-c(i+1,1)).^2+(c(i,2)-c(i+1,2)).^2);
% end
% display(Perimeter);
[x, y] = contornoBW(Label==num);
measurements = regionprops(labeledImage, Label==num, 'WeightedCentroid');
centerOfMass = measurements.WeightedCentroid;

 %Find Equivdiameter
EquivD=sqrt(4*(Obj_area)/pi);
display(EquivD);


%Find Roundness
Roundness=(4*Obj_area*pi)/Perimeter.^2;
display(Roundness);
                          


%Calculation with 'regionprops'(For verification Purpose);
%Sdata=regionprops(Label,'all');
%Sdata(num).BoundingBox
%Sdata(num).Area
%Sdata(num).Centroid
%Sdata(num).Perimeter
%Sdata(num).EquivDiameter

%imr=bwselect(im1b,col,row);
%s = bwarea(imr);
%display(s);
% figure(3),imshow(imr);
%area(i)=s;
%p = bwperim(imr);
%display(p);
%perimetro(i)=p;
end;
%imshowpair(im1,imr,'montage');