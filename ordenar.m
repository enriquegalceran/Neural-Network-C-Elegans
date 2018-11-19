function [X,y, datos]=ordenar(datos, X, y, long)
h = zeros(long,1);
for j = 1:long
    h(j) = datos(j,1);
end
X=[X(2:end,:); h];
y = [y(2:end); datos(j+1,1)];
datos = [datos(2:end,:); datos(1,:)];
end