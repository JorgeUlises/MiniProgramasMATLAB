clc;
clear all;
close all;
%pkg load image;
BW = imread('im1611.png');
lum=imhist(BW);
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


measurements = regionprops(Label,'All');
measurement = regionprops(Label,BW,'WeightedCentroid');
% centroid = measurements.Centroid;
% weightedCentroid = measurements.WeightedCentroid;%centro de masa
% area = measurements.Area;
% boundingBox = measurements.BoundingBox;%Cuadro delimitador
% equivDiameter = measurements.EquivDiameter;
% convexArea = measurements.ConvexArea;%area convexa
% convexHull = measurements.ConvexHull;%envolutura convexa
% solidity = measurements.Solidity;% Area/ConvexArea.
% eccentricity = measurements.Eccentricity;%excentricidad

num=max(Label(:));
for i=1:num
% strcat(num2str(measurements(i).Centroid(1)),',',num2str(measurements(i).Centroid(2)),'& ',...
%     num2str(measurement(i).WeightedCentroid(1)),',',num2str(measurement(i).WeightedCentroid(2)),'& ',...
%     num2str(measurements(i).Area),'& ',...
%     num2str(measurements(1).BoundingBox(1)),', ',num2str(measurements(1).BoundingBox(2)),', ',num2str(measurements(1).BoundingBox(3)),', ',num2str(measurements(1).BoundingBox(4)),'& ',...
%     num2str(measurements(i).EquivDiameter),'& ',...
%     num2str(measurements(i).ConvexArea),'& ',...
%     num2str(measurements(i).ConvexHull(1)),', ',num2str(measurements(i).ConvexHull(2)),'& ',...
%     num2str(measurements(i).Solidity),'& ',...
%     num2str(measurements(i).Eccentricity),' \\ \hline')

% strcat(num2str(measurements(i).Centroid(1)),',',num2str(measurements(i).Centroid(2)),'& ',...
%     num2str(measurement(i).WeightedCentroid(1)),',',num2str(measurement(i).WeightedCentroid(2)),'& ',...
%     num2str(measurements(i).Area),' \\ \hline')

% strcat(num2str(measurements(1).BoundingBox(1)),', ',num2str(measurements(1).BoundingBox(2)),', ',num2str(measurements(1).BoundingBox(3)),', ',num2str(measurements(1).BoundingBox(4)),'& ',...
%     num2str(measurements(i).EquivDiameter),'& ',...
%     num2str(measurements(i).ConvexArea),' \\ \hline')

% strcat(num2str(measurements(i).ConvexHull(1)),', ',num2str(measurements(i).ConvexHull(2)),'& ',...
%     num2str(measurements(i).Solidity),'& ',...
%     num2str(measurements(i).Eccentricity),' \\ \hline')

end;


%imshowpair(im1,imr,'montage');