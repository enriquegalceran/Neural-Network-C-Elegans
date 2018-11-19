% crear secuencia de ordenador
% Cargamos posturas
load('Posturas alternativas.mat')
% Cargamos red
load('C:\Users\boorg\Neural Network C Elegans\backup\Red multiple 90% 90-50-90 V9 1-3.mat')
% escogemos qué gusano será utilizado como semilla
semilla = 10;
load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat', subnum(semilla,1234)))
tiempo = 8;
SeedN = stateSequence(1:9,1);
SeedM = stateSequence(8,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Secuencia usando Redes neuronales

[X,Y] = ordenarB(SeedN, tiempo);
BiasVector = ones(1,1);
len_seq = 1000;
Secuencia_N = zeros(1,len_seq);
for sec = 1 : len_seq
    res_C = evaluate([X,BiasVector],Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector);
    [max_num, res_indx] = max(res_C(:));
    Secuencia_N(sec) = res_indx;
    SeedN = [SeedN(2:end-1);res_indx;1];
    [X,Y] = ordenarB(SeedN, tiempo);
end

% Dibujar. Poner 0 para ignorar, 1 para dibujar
if 0
    figure(100)
    for i = 1:len_seq
        [ske1X,ske1Y] = angle2skel(postures2(:,Secuencia_N(i)),0,1);
        plot(ske1X, ske1Y)
        title(sprintf('%s | %1.3f',subnum(i,len_seq),seguro(i)))
    %     axis([min_x max_x min_y max_y])
        set(gca,'DataAspectRatio',[1 1 1])
        axis off
        pause(0.1)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Secuencia usando Markov

% Red de 3:
% load('Markov 3.mat')
% Red de 1188:
load('Markov 1188.mat')

SecuenciaM = zeros(1,len_seq);
SecuenciaM(1) = SeedM;
simulaciones = 100;


for sec = 2 : len_seq
    temp = SecuenciaM(sec-1);
    azar = rand(1);
    for azar_c = 1:90
        if azar <= Acum(temp,azar_c)
            SecuenciaM(sec) = azar_c;
            break
        end
    end
end












