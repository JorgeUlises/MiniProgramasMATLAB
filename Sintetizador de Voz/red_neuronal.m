% net = newff([0 1; 0 1], [1], {'logsig'}, 'traingdx');
P=[0 0 1 1; 0 1 0 1];
T=[0 1 1 1];
% net.trainParam.epochs=10000;
% net.trainParam.goal=0.0001;
% net = train(net,P,T);
% sim(net, P)
CantidadNeuronas = 1;
percep = newp(minmax(P), CantidadNeuronas);
percep = train(percep, P, T);
percep = adapt(percep, P, T);
plotpv(P,T);
Pesos = percep.IW{1,1};
Umbrales = percep.b{1};
plotpc(Pesos, Umbrales);
sali = sim(percep, newP);