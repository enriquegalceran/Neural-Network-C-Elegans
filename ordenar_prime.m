function [X, y, datos]=ordenar_prime(datos, long, cuantas_lineas)
X = zeros(cuantas_lineas, long);
y = zeros(cuantas_lineas,90);
for i = 1 : cuantas_lineas
    for j = 1 : long
        X(i,j) = datos(j+i-1,1);
    end
%     y(i)=datos(i+long,1);
    y(i,datos(i+long,1)) = 1;
end
h = datos(1:cuantas_lineas,:);
datos = [datos(cuantas_lineas+1:end,:);h];
end