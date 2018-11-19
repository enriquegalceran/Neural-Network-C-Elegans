%Cross-reference Neural Network

if exist('n_iteraciones', 'var') == 0
    n_iteraciones = 1000000;
end
entradas_tiempo = 8;
files = dir('backup/NeuralNetworkV8b/');
dirFlags = [files.isdir];
subFolders = files(dirFlags);
lista_subs = zeros(size(files,1)-2,1);
for k = 3 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
    lista_subs(k-2,1) = str2double(subFolders(k).name);
end
lon_sub = length(lista_subs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Crear la base de datos de Neuronas
% Syn1t = zeros(91,80,lon_sub);
% Syn2t = zeros(81,80,lon_sub);
% Syn3t = zeros(81,80,lon_sub);
% Syn4t = zeros(81,80,lon_sub);
% Syn5t = zeros(81,90,lon_sub);


% for j = 1:lon_sub
%     nombre_sub = lista_subs(j);
%     lista = ls(sprintf('backup/NeuralNetworkV8b/%s/',num2str(nombre_sub)));
%     nombre_archivo_cargar = lista(end-1,:);
%     load(sprintf('backup/NeuralNetworkV8b/%s/%s',num2str(nombre_sub),strtrim(nombre_archivo_cargar)), 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5')
% 
% end
        
%%%%%%%%%%%%%%%%%%
%% Cross-reference

volver_a_empezar_C = 1;
BiasVectorC = ones(1,1);

figure(7)
k = 1;
lon_sub = 5;
for i = 1:lon_sub
    nombre_sub = lista_subs(i);
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s/',num2str(nombre_sub)));
    nombre_archivo_cargar = lista(end-1,:);
    load(sprintf('backup/NeuralNetworkV8b/%s/%s',num2str(nombre_sub),strtrim(nombre_archivo_cargar)), 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5')

    
    for j = 1:lon_sub
        gusano = lista_subs(j);
%         load(sprintf('stateSequences_90/%istateSequence_90means_N2-1000_ds-5.mat',gusano))
        Comprobar;
        
        figure(7)
        subplot(lon_sub, lon_sub, k);
        labels = {sprintf('%2.1f%%',tarta(1)/(tarta(2)+tarta(3))*100),'',''};
        pie(tarta,labels);
        colormap parula
        title(sprintf('%i - %i', nombre_sub,gusano))
        drawnow
        k = k+1;
        
        
    end
end