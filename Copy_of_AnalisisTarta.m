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
if length(factor_lon_sub) == 1
    error('primo')
elseif length(factor_lon_sub) == 2
    valor_x = factor_lon_sub(1);
    valor_y = factor_lon_sub(2);
else
    valor_x = factor_lon_sub(end);
    valor_y = lon_sub / factor_lon_sub(end);
%     valor_x = XX %Para sobreescribir en el caso de que no salga bien
%     valor_y = YY %Para sobreescribir en el caso de que no salga bien
end



for j = 1:lon_sub
    nombre_gusano = num2str(lista_subs(j));
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s',nombre_gusano));
    lon_lista = length(lista);
    tarta_completa = zeros(lon_lista-3,3);
    for i = 3:lon_lista-1
        nombre_archivo_tarta = strtrim(lista(i,:));
        load(sprintf('backup/NeuralNetworkV8b/%s/%s',nombre_gusano,...
            nombre_archivo_tarta),'tarta')
        tarta_completa(i-2,:) = tarta;
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
        plot(tarta_completa_x,tarta_completa)
        title(sprintf('G: %s | final: %2.1f%% %2.1f%% %2.1f%% | Res: %i',...
            nombre_gusano,...
            tarta_completa(end,1)/tarta_completa_suma*100,...
            tarta_completa(end,2)/tarta_completa_suma*100,...
            tarta_completa(end,3)/tarta_completa_suma*100,...
            lon_lista))
    end
end