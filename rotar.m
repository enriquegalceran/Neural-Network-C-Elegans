function [X,Y,datosN,volver_a_empezar] = rotar(datos, X, Y, lineas_simultaneas, tiempo)
% rotates the inputs and outputs to receive the new values
    % datos = dataset
    % X = inputs
    % Y = correct outputs
    % x = new inputs
    % y = new outputs
    % lineas_simultaneas = #rows that are calculated each iteration
    % tiempo = how many "last positions" are taken into account

% Check if it reached the end and we need to restart the dataset
if size(datos, 1) == tiempo+1
    % Ha llegado al final.
    % Hay que volver a cargar la salida.
    % Hay que programarlo todavía (?)
    volver_a_empezar = 1;
else
    volver_a_empezar = 0;
end

%Get the new lines
[x,y] = ordenarB(datos, tiempo);

% update inputs and outputs
if lineas_simultaneas == 1
    X = x;
    Y = y;
else
    X = [X(2:end,:);x];
    Y = [Y(2:end,:);y];
end
datosN = datos(2:end);
end