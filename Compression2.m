% Grafica multiple
%% ____INI____

N_max = 3000; % Eje X, longitud secuencia
M_max = 1;
Em_max = 50;


% Red de 3:
% load('Markov 3.mat')
% Red de 1188:
load('Markov 1188.mat')

load('Posturas alternativas.mat')
load('C:\Users\boorg\Neural Network C Elegans\backup\Red multiple 90% 90-50-90 V9 1-3.mat')
tiempo = 8;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Empirical
% tic
% Matriz_Em = zeros(Em_max, N_max);
% max_lon_seq = 0;
% for ii = 1 : N_max
% 
%     for jj = 1:Em_max
%         semilla1 = floor(1+rand(1)*1188);
%         load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat',...
%             subnum(semilla1,1234)))
%         lon_seq = length(stateSequence);
%         if lon_seq>=ii
% 
%             Secuencia_E = stateSequence(1:ii,1)';
%             
%             [~, ~, totSavings] = compressSequenceNFast(Secuencia_E, 91, 20);
%             Matriz_Em(jj, ii) = totSavings/ii;
%         end
%         
%         if max_lon_seq < lon_seq, max_lon_seq = lon_seq; end
%         
%         
%     end
% end
% toc
% 
% save('MatrizEM.mat', 'Matriz_Em', 'elapsedTime');

%% Neural Network
Matriz_NN = zeros(M_max, N_max);
Matriz_Ma = zeros(M_max, N_max);
BiasVector = ones(1,1);
tic
for ii = 1 : N_max
    semilla1 = floor(1+rand(1)*1188);
    load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat',...
            subnum(semilla1,1234)))
        lon_seq = length(stateSequence);
    for jj = 1:M_max
        
        semilla2 = floor(rand(1)*(lon_seq-15)+2);
        SeedN = stateSequence(semilla2:semilla2+9,1);
        [X,Y] = ordenarB(SeedN, tiempo);
        
        Secuencia_N = zeros(1,lon_seq);

        for sec = 1:lon_seq
            res_C = evaluate([X,BiasVector],Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector);
            [max_num, res_indx] = max(res_C(:));
            Secuencia_N(sec) = res_indx;
            SeedN = [SeedN(2:end-1);res_indx;1];
            [X,Y] = ordenarB(SeedN, tiempo);

        end
        
        [~, ~, totSavings] = compressSequenceNFast(Secuencia_N, 91, 10);
        Matriz_NN(jj, ii) = totSavings/length(Secuencia_N);
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Markov
    

        SeedM = stateSequence(semilla2,1);
        Secuencia_M = zeros(1,lon_seq);
        Secuencia_M(1) = SeedM;
        simulaciones = 100;

        for sec = 2 : lon_seq
            temp = Secuencia_M(sec-1);
            azar = rand(1);
            for azar_c = 1:90
                if azar <= Acum(temp,azar_c)
                    Secuencia_M(sec) = azar_c;
                    break
                end
            end
        end
        
        [~, ~, totSavings] = compressSequenceNFast(Secuencia_M, 91, 20);
        
        Matriz_Ma(jj, ii) = totSavings/length(Secuencia_M);
        
    end
end  
toc
save('MatrizNN-Ma.mat', 'Matriz_NN', 'Matriz_Ma', 'elapsedTime')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procesado de la información
% NewSimpleArray = SimpleArray(SimpleArray ~= 0)
        







