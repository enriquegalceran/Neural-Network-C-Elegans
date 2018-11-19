% Grafica multiple
%% ____INI____

N_max = 3000; % Eje X, longitud secuencia
M_max = 5; % Iteraciones que se repiten. de momento 1 para no liar
lon_ii = 5; %%%%%%%%%%%%%%%%%%%%%%%%%% <------------------------
% el 3 viene de que se hará tres gráficas diferentes

% Red de 3:
% load('Markov 3.mat')
% Red de 1188:
load('Markov 1188.mat')

load('Posturas alternativas.mat')
load('C:\Users\boorg\Neural Network C Elegans\backup\Red multiple 90% 90-50-90 V9 1-3.mat')
tiempo = 8;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Empirical

Matriz_Em = zeros(2, lon_ii);
max_lon_seq = 0;
for ii = 1 : lon_ii
    
    load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat',...
        subnum(ii,1234)))
    lon_seq1 = length(stateSequence);
    lon_seq = round(lon_seq1,-1);
    if lon_seq>lon_seq1, lon_seq= lon_seq-10; end
    Secuencia_E = stateSequence(1:lon_seq,1)';
    [~, ~, totSavings] = compressSequenceNFast(Secuencia_E, 91, 20);
    
    Matriz_Em(1, ii) = totSavings/length(Secuencia_E);
    Matriz_Em(2, ii) = lon_seq;
    
    if max_lon_seq < lon_seq1, max_lon_seq = lon_seq1; end
    

end



    %% Neural Network
Matriz_NN = zeros(2, lon_ii, M_max);
Matriz_Ma = zeros(2, lon_ii, M_max);
for ii = 1 : lon_ii
    load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat',...
        subnum(ii,1234)))
    lon_seq1 = length(stateSequence);
    lon_seq = round(lon_seq1,-1);
    if lon_seq>lon_seq1, lon_seq= lon_seq-10; end
    
    
    for m = 1:M_max
        semilla = floor(rand(1)*(lon_seq1-10));
        SeedN = stateSequence(semilla:semilla+9,1);
        [X,Y] = ordenarB(SeedN, tiempo);
        BiasVector = ones(1,1);
        Secuencia_N = zeros(1,lon_seq);

        for sec = 1:lon_seq
            res_C = evaluate([X,BiasVector],Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector);
            [max_num, res_indx] = max(res_C(:));
            Secuencia_N(sec) = res_indx;
            SeedN = [SeedN(2:end-1);res_indx;1];
            [X,Y] = ordenarB(SeedN, tiempo);

        end
        
        [~, ~, totSavings] = compressSequenceNFast(Secuencia_N, 91, 20);
        
        Matriz_NN(1, ii, m) = totSavings/length(Secuencia_N);
        Matriz_NN(2, ii, m) = lon_seq;
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Markov
    
        semilla = floor(rand(1)*(lon_seq1-10));
        SeedM = stateSequence(semilla,1);
        Secuencia_M = zeros(1,len_seq);
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
        
        Matriz_Ma(1, ii, m) = totSavings/length(Secuencia_M);
        Matriz_Ma(2, ii, m) = lon_seq;
        
    end
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procesado de la información
BaseDatos = zeros(max_lon_seq, max_lon_seq*M_max);

for ii = 1: lon_ii
    for jj = 1: lon_ii
        







