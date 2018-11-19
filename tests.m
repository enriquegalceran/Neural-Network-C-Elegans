% lugar en blanco para tests
% 
% disTable_postures = vectorCor(postures,postures);
% 
% dist = distSeq(1, postures(:,2), disTable_postures)

%% guardar_matriz

% load('guardar matriz.mat')
% load('guardar markov red completa.mat', 'guardar_markov')
% figure(3)
% plot(linspace(1,1188,1188),[guardar_matriz;guardar_markov])
% title('Red Neuronal creada a partir de los gusanos 1-3. Unsorted')
% legend('Neural Network', 'Markov')
% 
% 
% 
% [guardar_matriz,index]=sort(guardar_matriz,'descend');
% guardar_markov=guardar_markov(index);
% 
% figure(4)
% plot(linspace(1,1188,1188),[guardar_matriz;guardar_markov])
% title('Red Neuronal creada a partir de los gusanos 1-3. Sorted by Neural')
% legend('Neural network', 'Markov')
% 
% figure(5)
% hold off
% histogram(guardar_matriz, 160)
% % figure(6)
% hold on
% histogram(guardar_markov,30)
% title('Histograma de success rate para la NN y Markov')
% legend('Neural network', 'Markov')
% 
% 
% 
% guardar2;





%% posturas

% load('postures_90-centers_20-files_5000-framesPerFile.mat')
% load('Posturas alternativas.mat')
% 
% Rmat1 = vectorCor(postures', postures');
% Rmat2 = vectorCor(postures2', postures2');
% 
% Rmat = Rmat2.^2;
% figure(61), imagesc(Rmat1), colorbar
% figure(62), imagesc(Rmat2), colorbar
% figure(63), imagesc(Rmat), colorbar
% 
% min_v = min(Rmat2(:))
% 
% max_v = max(Rmat2(:))
% 
% vector_salida = Rmat2(5,:);
% vector_ruido = vector_salida + rand(1,90)*0.05-0.0025;
% 
% Rmat3 = vectorCor(vector_ruido,Rmat2);
% figure(64), imagesc(Rmat3), colorbar
% [~, indx] = max(Rmat3(:))

%% guardar matriz
% guardar_matriz2 = zeros(1,1188);
% for jj = 1: 1188
% 
%     guardar_matriz2(jj) = guardar_matriz(jj,jj);
%     
% end
% save('guardar matriz2 51-54 70%.mat', 'guardar_matriz2')

%% Compressión


[grammar_O, compVec_O, totSavings_O] = compressSequenceNFast(stateSequence(:,1)', 91, 20);

compressibility=totSavings_O/length(stateSequence(:,1)');






