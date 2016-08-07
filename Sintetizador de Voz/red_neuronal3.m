P = [0 1 2 3 4 5 6 7 8 9 10;
    10 1.1 2.1 3.1 4.1 5.1 6.1 7.1 8.1 9.1 9.9];
T = [0 4;
     1 3;
     2 2;
     3 1;
     4 0];
 
for (k = 
Ek = (Tk - Ok) * Ok * (1 - Ok);
Wjk = Wjk + L * Ek * Oj;
p=1;

%neurona 
suma = 0;
pesos = rand(12,1)';
for i=1:12
    suma = suma + entradas(i) * pesos (i);
end
a=suma;
sigmoide = 1 / (1 + exp(-a/p));


for 


%%net = newff([0 10],[5 1],{'logsig' 'logsig'});
%%Pprueba = [0 1.1 2.1 3.1 4.1 5.1 6.1 7.1 8.1 9.1 10];
%%Y = sim(net,Pprueba);
%%plot(P,Y,'o');
%plot(P,T,P,Y,'o')
% net.trainParam.epochs = 50;
% net = train(net,P,T);
% Y = sim(net,P);
% plot(P,T,P,Y,'o')