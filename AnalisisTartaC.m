% analisis de la tarta para una simulacion ya hecha
desde = 1;
hasta = 3;

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
lista_subs = lista_subs(1:end-1,:);

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

% valor_x = 5; %Para sobreescribir en el caso de que no salga bien
% valor_y = 3; %Para sobreescribir en el caso de que no salga bien




for j = 1:lon_sub
    nombre_gusano = subnum(lista_subs(j),12);
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s',nombre_gusano));
    lista = lista(3:end,:);
    lon_lista = length(lista);
    tarta_completa = [];    
    
    
    indx = 1;
    for i = 1:2:lon_lista-1
        nombre_archivo_tarta = strtrim(lista(i,:));
        load(sprintf('backup/NeuralNetworkV8b/%s/%s',nombre_gusano, nombre_archivo_tarta),'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5')
        Comprobar2;
        tarta_completa(indx,:) = tarta;
        indx = indx + 1;
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
        title(sprintf('G: %s | final: %2.1f%% %2.1f%% | Res: %i',...
            nombre_gusano,...
            tarta_completa(end,1)/tarta_completa_suma*100,...
            tarta_completa(end,2)/tarta_completa_suma*100,...
            lon_lista))
    end
end