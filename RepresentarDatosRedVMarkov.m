load('guardar matriz.mat')
load('guardar markov red completa.mat', 'guardar_markov')
load('guardar matriz2 51-54 70%.mat')
guardar_markov_simple = guardar_markov;
load('guardar 1188.mat')
guardar_markov_complejo = guardar_markov;
load('guardar markov de 51-53.mat')
guardar_markov_nuevo = guardar_markov;
load('C:/Users/boorg/Dropbox/backup Neural Networks/GuardarmatrizNN 50.mat')
guardar_matriz_50 = guardar_matriz;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Red Normal, sin ordenar de 1-1188
figure(3)
plot(linspace(1,1188,1188),[guardar_matriz; guardar_matriz_50; guardar_matriz2; guardar_markov_simple; guardar_markov_complejo; guardar_markov_nuevo])
title('Comparison of efficiency for different methods. Unsorted')
legend('Red 1-3', 'Red 51-53', 'Red Buena', 'Markov - 3', 'Markov - 1188', 'Markov 51-53')
print('-f3','C:/Users/boorg/Dropbox/backup Neural Networks/unsorted.bmp','-dbmp')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Red ordenada
[guardar_matriz,index]=sort(guardar_matriz,'descend');
guardar_matriz2 = guardar_matriz2(index);
guardar_markov_simple=guardar_markov_simple(index);
guardar_markov_complejo=guardar_markov_complejo(index);
guardar_markov_nuevo = guardar_markov_nuevo(index);
guardar_matriz_50 = guardar_matriz_50(index);

figure(4)
plot(linspace(1,1188,1188),[guardar_matriz; guardar_matriz_50; guardar_matriz2; guardar_markov_simple; guardar_markov_complejo; guardar_markov_nuevo])
title('Comparison of efficiency for different methods. Sorted by 1-3 NN')
legend('Red 1-3', 'Red 51-53', 'Red Buena', 'Markov - 3', 'Markov - 1188', 'Markov 51-53')
print('-f4','C:/Users/boorg/Dropbox/backup Neural Networks/sorted 1-3.bmp','-dbmp')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Red ordenada por la nueva
[guardar_matriz2,index]=sort(guardar_matriz2,'descend');
guardar_matriz = guardar_matriz(index);
guardar_markov_simple=guardar_markov_simple(index);
guardar_markov_complejo=guardar_markov_complejo(index);
guardar_markov_nuevo = guardar_markov_nuevo(index);

figure(5)
plot(linspace(1,1188,1188),[guardar_matriz; guardar_matriz2; guardar_markov_simple; guardar_markov_complejo; guardar_markov_nuevo])
title('Comparison of efficiency for different methods. Sorted by 51-54 NN')
legend('Red 1-3', 'Red 51-53', 'Markov - 3', 'Markov - 1188', 'Markov 51-53')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histograma
figure(6)
hold off
histogram(guardar_matriz, 160)
hold on
histogram(guardar_matriz2, 100)
histogram(guardar_markov_complejo, 40)
title('Histogram of success rates for NNs and Markov')
legend('Red 1-3', 'Red 51-53', 'Markov - 1188')

figure(7)
hold off
histogram(guardar_markov_simple, 30)
hold on
histogram(guardar_markov_complejo, 30)
histogram(guardar_markov_nuevo, 30)
title('Histogram of success rates Markovs')
legend('Markov - 3', 'Markov - 1188', 'Markov 51-53')

figure(8)
hold off
histogram(guardar_matriz, 160)
hold on
histogram(guardar_matriz2, 100)
histogram(guardar_markov_complejo, 30)
title('Comparison NNs vs Markov')
legend('Red 1-3', 'Red 51-53', 'Markov 1188')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Reordenada por Markov 3
[guardar_markov_simple,index]=sort(guardar_markov_simple,'descend');
guardar_matriz=guardar_matriz(index);
guardar_matriz2=guardar_matriz2(index);
guardar_markov_complejo=guardar_markov_complejo(index);

figure(9)
plot(linspace(1,1188,1188),[guardar_matriz;guardar_matriz2; guardar_markov_simple; guardar_markov_complejo])
title('Red Neuronal creada a partir de los gusanos 1-3. Sorted by Markov 3')
legend('Neural Network', 'NN 51-53', 'Markov - 3', 'Markov - 1188')


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Reordenada por Markov 1188
[guardar_markov_complejo,index]=sort(guardar_markov_complejo,'descend');
guardar_matriz=guardar_matriz(index);
guardar_matriz2=guardar_matriz2(index);
guardar_markov_simple=guardar_markov_simple(index);

figure(10)
plot(linspace(1,1188,1188),[guardar_matriz;guardar_matriz2; guardar_markov_simple; guardar_markov_complejo])
title('Red Neuronal creada a partir de los gusanos 1-3. Sorted by markov 1188')
legend('Neural Network', 'NN 51-53', 'Markov - 3', 'Markov - 1188')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[guardar_matriz_50,index]=sort(guardar_matriz_50,'descend');
guardar_matriz2 = guardar_matriz2(index);
guardar_markov_simple=guardar_markov_simple(index);
guardar_markov_complejo=guardar_markov_complejo(index);
guardar_markov_nuevo = guardar_markov_nuevo(index);
guardar_matriz = guadar_matriz(index);

figure(11)
plot(linspace(1,1188,1188),[guardar_matriz; guardar_matriz_50; guardar_matriz2; guardar_markov_simple; guardar_markov_complejo; guardar_markov_nuevo])
title('Comparison of efficiency for different methods. Sorted by buena NN')
legend('Red 1-3', 'Red 51-53', 'Red Buena', 'Markov - 3', 'Markov - 1188', 'Markov 51-53')
print('-f11','C:/Users/boorg/Dropbox/backup Neural Networks/sorted buena.bmp','-dbmp')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gráfica de la evolución de guardar matrices
Matrices_comunes = zeros(50, 1188);
for i = 1:50
    load(sprintf('C:/Users/boorg/Dropbox/backup Neural Networks/GuardarmatrizNN %i.mat',i))
    Matrices_comunes(i,:) = guardar_matriz;
end

Matrices_comunes_sorted = zeros(50, 1188);
matriz_final = Matrices_comunes(50,:);
[matriz_final, index] = sort(matriz_final(50,:),'descend');
Matrices_comunes_sorted(50,:) = matriz_final;
for ii = 1:49
    matriz_temp = Matrices_comunes(i,:);
    Matrices_comunes_sorted(i,:) = matriz_temp(index);
end
save('C:/Users/boorg/Dropbox/backup Neural Networks/resultado analizado.mat', 'Matrices_comunes_sorted', 'Matrices_comunes');
