clear all
close all
clc
[xella,fs]=wavread('vozfemenina.wav');
figure
plot(xella)
vocalreal= xella(27700:28259);



%sound(areal)
L1=length(vocalreal);


x1 = vocalreal.*hamming(L1);


p = 12;
r = zeros(p+1,1);
for k=0:p
    r(k+1)=x1(1:L1-k)'*x1(k+1:L1);
end
R = r(1:p);
r = r(2:p+1);
for k=2:p
    R(:,k) = [R(k,1); R(1:p-1,k-1)];
end
a = -inv(R)*r;

Coef_a(1,:)=[1,a'];

