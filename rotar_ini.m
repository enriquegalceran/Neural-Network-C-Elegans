function [X, Y, datosN] = rotar_ini(datos, lineas_simultaneas, tiempo)
% Generates the initial inputs and outputs
datosN = datos;
if lineas_simultaneas == 1
    [X,Y] = ordenarB(datosN, tiempo);
    datosN = datosN(2:end);
else
    X = zeros(lineas_simultaneas,90);
    Y = zeros(lineas_simultaneas,90);
    
    for i= 1 : lineas_simultaneas
        [x,y] = ordenarB(datosN, tiempo);
        datosN = datosN(2:end);
        X(i,:) = x;
        Y(i,:) = y;
    end
end
end