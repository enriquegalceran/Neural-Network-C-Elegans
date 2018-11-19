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
        nombre_gusano = lista_subs(j);
        load(sprintf('stateSequences_90/%istateSequence_90means_N2-1000_ds-5.mat',nombre_gusano))
        DataSetC=stateSequence(:,1);
        fmax = length(DataSetC);
        falso_pos = zeros(1,90);
        falso_neg = zeros(1,90);
        correcto = zeros(1,90);
        volver_a_empezar_C = 1;
        
        
        for f = 1:fmax
            if volver_a_empezar_C == 0
                [X_c,Y_c,DataSetC,volver_a_empezar_C] = rotar(DataSetC, X_c(:,1:90), Y_c, 1, entradas_tiempo);
                X_c = [X_c,BiasVectorC];
            elseif volver_a_empezar_C == 1
                [X_c, Y_c, DataSetC] = rotar_ini(stateSequence(:,1), 1, entradas_tiempo);
                X_c = [X_c,BiasVectorC];
                volver_a_empezar_C = 0;
            elseif volver_a_empezar_C == 2
                volver_a_empezar_C = 0;
                % No hacer nada. control de la primera iteracion
            else
                error('No debería salir esto. Volver a empezar tiene que ser 0, 1 o 2')
            end
            res_C = evaluate(X_c,Syn1, Syn2, Syn3, Syn4, Syn5, BiasVectorC);
            res_C = round(res_C);

            for g=1:90
                if Y_c(g) == 0
                    if res_C(g) == 1
                        falso_pos(g) = falso_pos(g) + 1;
                    end
                else
                    if res_C(g) == 1
                        correcto(g) = correcto(g) + 1;
                    else
                        falso_neg(g) = falso_neg(g) + 1;
                    end
                end
            end
        end
        
        corr_sum = sum(correcto);
        fals_p_sum = sum(falso_pos);
        fals_n_sum = sum(falso_neg);
        sum_sum = corr_sum + fals_n_sum + fals_p_sum;
        tarta = [corr_sum, fals_p_sum, fals_n_sum];
        figure(7)
        subplot(lon_sub, lon_sub, k);
        labels = {sprintf('%2.1f%%',corr_sum/sum_sum*100),'',''};
        pie(tarta,labels);
        colormap([0,0.4470,0.7410;0.8500,0.3250,0.098;0.9290,0.6940,0.1250])
        if i == 1
            title(sprintf('%i', lista_subs(j)))
        elseif j == 1
            title(sprintf('%i', lista_subs(i)))
        end
        
%         legend(sprintf('C %i',corr_sum),...
%             sprintf('FP %i',fals_p_sum),...
%             sprintf('FN %i',fals_n_sum))
        drawnow
        k = k+1;
        
    end
end