% analisis de la tarta para una simulacion ya hecha

if exist('n_iteraciones', 'var') == 0
    n_iteraciones = 1000000;
end

files = dir('backup/NeuralNetworkV8b/');
dirFlags = [files.isdir];
subFolders = files(dirFlags);
lista_subs = zeros(size(files,1)-2,1);
for k = 3 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
    lista_subs(k-2,1) = str2double(subFolders(k).name);
end


% Obtener las coordenadas que van a hacer falta para el subplot
lon_sub = length(lista_subs);
% lon_sub = 21
factor_lon_sub = factor(lon_sub);
if length(factor_lon_sub) == 23
    error('primo')
elseif length(factor_lon_sub) == 2
    valor_x = factor_lon_sub(1);
    valor_y = factor_lon_sub(2);
else
    valor_x = factor_lon_sub(end);
    valor_y = lon_sub / factor_lon_sub(end);
end

% valor_x = 1; %Para sobreescribir en el caso de que no salga bien
% valor_y = 3; %Para sobreescribir en el caso de que no salga bien




for j = 1:lon_sub
    nombre_gusano = num2str(lista_subs(j));
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s',nombre_gusano));
    lista = lista(3:end,:);
    lon_lista = length(lista);
    tarta_completa = zeros(lon_lista-2,3);    
    
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
    %volvemos a cargar los nombres en el orden correcto
    nombre_gusano = num2str(lista_subs(j));
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s',nombre_gusano));
    lista = lista(3:end,:);

    
    %Ordenar
%     if lista 
%     end
    
    
    
    for i = 2:lon_lista-1
        nombre_archivo_tarta = strtrim(lista(i,:));
        load(sprintf('backup/NeuralNetworkV8b/%s/%s',nombre_gusano,...
            nombre_archivo_tarta),'tarta')
        tarta_completa(i,:) = tarta;
    end
    
    
    %Dibujar
    if lon_sub == 1
        figure(6)
        tarta_completa_x = linspace(1,n_iteraciones,length(tarta_completa));
        tarta_completa_suma = sum(tarta_completa(end,:));
        plot(tarta_completa_x,tarta_completa)
        title(sprintf('Gusano: %s | final: %2.1f%% %2.1f%% %2.1f%% | resolucion: %i',...
            nombre_gusano,...
            tarta_completa(end,1)/tarta_completa_suma*100,...
            tarta_completa(end,2)/tarta_completa_suma*100,...
            tarta_completa(end,3)/tarta_completa_suma*100,...
            lon_lista))
    else
        figure(6)
        subplot(valor_y, valor_x, j)
        tarta_completa_x = linspace(1,n_iteraciones,length(tarta_completa));
        tarta_completa_suma = sum(tarta_completa(end,:));
%         plot(tarta_completa_x,tarta_completa)
        semilogy(tarta_completa_x,tarta_completa)
        title(sprintf('G: %s | final: %2.1f%% %2.1f%% %2.1f%% | Res: %i',...
            nombre_gusano,...
            tarta_completa(end,1)/tarta_completa_suma*100,...
            tarta_completa(end,2)/tarta_completa_suma*100,...
            tarta_completa(end,3)/tarta_completa_suma*100,...
            lon_lista))
    end
end