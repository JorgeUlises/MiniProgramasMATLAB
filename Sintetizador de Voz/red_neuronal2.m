net = newff([0 1; 0 1],[2 1],{'logsig','logsig'});
net = train(net, P, T);
salida = sim(net, P);