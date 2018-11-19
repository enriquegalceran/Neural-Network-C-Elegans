function [x,y] = ordenarB(datos, tiempo)
% Generates the next line of input for the ANN to train with.
% Goes through the last 'tiempo' positions and creates a value of relevancy
x = zeros(1,90);
y = zeros(1,90);
for i = 1 : tiempo
    peso = WeightFunction(i);
    x(datos(i)) = x(datos(i)) + peso;
end
x = x/max(x);
y(datos(tiempo + 1)) = 1;
end