% crear secuencia de ordenador
% Cargamos posturas
load('Posturas alternativas.mat')
% Cargamos red
load('C:\Users\boorg\Neural Network C Elegans\backup\Red multiple 90% 90-50-90 V9 1-3.mat')
% escogemos qué gusano será utilizado como semilla
semilla = 11;
load(sprintf('stateSequences_limpio/datos_reordenados/%s.mat', subnum(semilla,1234)))
tiempo = 8;
Seed = stateSequence(1:9,1);

[X,Y] = ordenarB(Seed, tiempo);
BiasVector = ones(1,1);
len_seq = 1000;
Secuencia = zeros(1,len_seq);
seguro = ones(1,len_seq+1);
for sec = 1 : len_seq
    res_C = evaluate([X,BiasVector],Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector);
    [max_num, res_indx] = max(res_C(:));
    Secuencia(sec) = res_indx;
    seguro(sec) = max_num;
    Seed = [Seed(2:end-1);res_indx;1];
    [X,Y] = ordenarB(Seed, tiempo);
end

figure(100)

for i = 1:len_seq
    [ske1X,ske1Y] = angle2skel(postures2(:,Secuencia(i)),0,1);
    plot(ske1X, ske1Y)
    title(sprintf('%s | %1.3f',subnum(i,len_seq),seguro(i)))
%     axis([min_x max_x min_y max_y])
    set(gca,'DataAspectRatio',[1 1 1])
    axis off
    pause(0.1)
end