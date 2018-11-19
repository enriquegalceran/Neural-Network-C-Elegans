% Comparar posiciones de las templates
% load('postures_90-centers_20-files_5000-framesPerFile.mat');
% postures2 = postures;

cantidad_posturas = size(postures2,2);
A = zeros(cantidad_posturas,cantidad_posturas);
B = zeros(cantidad_posturas,2);
C = zeros(cantidad_posturas,cantidad_posturas);
D = zeros(cantidad_posturas,cantidad_posturas);

%Crear la matriz de diferencias entre las diferencias entre los templates
for i = 1:cantidad_posturas
    for j = 1:cantidad_posturas % poner i:90 si no quieres repetir y no importa tener ambos lados
        for k = 1:48
            A(i,j) = A(i,j) + 1- abs(cos(postures2(k,i)-postures2(k,j)));
        end
    end
end

%Transformarlo a una matriz 90x2 que tenga ordenado 
for i = 1:cantidad_posturas
    for j = 1:cantidad_posturas
        B(i,j,1) = j;
        B(i,j,2) = A(i,j);
    end
end

%ordenar Finalmente obtenemos la matriz C. est� ordenada tal que C(:,i) sea
%un vector columna que nos da las dem�s plantillas ordenadas de menor a
%mayor. Obviamente, C(1,i)=i pues la diferencia es 0 consigo misma.
% D es igual, pero en vez de darnos el template, nos dala diferencia.
for i = 1:cantidad_posturas
    a = squeeze(B(i,:,:));
    [~, order] = sort(a(:,2));
    temp = a(order,:);
    C(:,i) = temp(:,1);
    D(:,i) = temp(:,2);
end

figure(50)
imagesc(A), colorbar, axis equal

% figure(51), imagesc(D), colorbar, axis equal
