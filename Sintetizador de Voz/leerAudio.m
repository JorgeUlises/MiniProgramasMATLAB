senal_salida=audiorecorder(8000,16,1);
recordblocking(senal_salida,2);
senal_grabada=getaudiodata(senal_salida, 'single');
sig = senal_grabada(10000:10511).*hamming(512);
% [x,fs]=wavread('vozfemenina.wav');
% xa=x(27700+(1:512)').*hamming(512);%a
% xe=x(1650+(1:512)').*hamming(512);%e
[yo,coef]=sinte(sig);
soundsc(yo);
verificar(W,coef)