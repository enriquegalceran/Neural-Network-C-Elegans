%Limpiar base de datos

files = dir('backup/NeuralNetworkV9/');
dirFlags = [files.isdir];
subFolders = files(dirFlags);
lista_subs = zeros(size(files,1)-2,1);
for k = 3 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
    lista_subs(k-2,1) = str2double(subFolders(k).name);
end
lista_subs = lista_subs(1:end-1,:);
lon_sub = length(lista_subs);

for j = 1:lon_sub
    nombre_gusano = num2str(lista_subs(j));
    lista = ls(sprintf('backup/NeuralNetworkV9/%s',nombre_gusano));
    lista = lista(3:end,:);
    lon_lista = length(lista);
    tarta_completa = zeros(lon_lista-1,3);    
    
    %Aquí viene lo que limpia la lista.
    %Primero calculamos cuando hay que meter 0
    min_punto = 0;
    for i = 1:lon_lista-1
        if find(lista(i,:)=='.') > min_punto
            min_punto = find(lista(i,:)=='.');
        end
    end
    %Después metemos el 0
    for i = 1:lon_lista-1
        if find(lista(i,:)=='.') < min_punto
            old_filename = sprintf('backup/NeuralNetworkV8b/%s/%s', nombre_gusano, strtrim(lista(i,:)));
            new_filename = sprintf('backup/NeuralNetworkV8b/%s/0%s', nombre_gusano, strtrim(lista(i,:)));
            movefile(old_filename,new_filename)
        end 
    end
end