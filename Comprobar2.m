% comprobar si funciona la red neuronal.
% redondeará y mirará si ha salido bien o no
% desde = 1;
% hasta = 3;
falso_pos = zeros(1,90);
falso_neg = zeros(1,90);
correcto = zeros(1,90);
for p = desde:hasta
    load(sprintf('stateSequences_limpio/datos/%s.mat',subnum(p,1234)))
    DataSetC=stateSequence(:,1);
    fmax = length(DataSetC);

    volver_a_empezar_C = 1;
    entradas_tiempo = 8;

    BiasVectorC = ones(1,1);

    if exist('tarta', 'var') == 0
        tarta = [0,0,0];
    end
    if exist('graf_progreso_x', 'var') == 0
        graf_progreso_x = linspace(1,100,100);
    end
    if exist('graf_progreso_y', 'var') == 0
        graf_progreso_y = zeros(100,3);
    end


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

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
bar_data = [correcto',falso_pos', falso_neg'];
bar(bar_data, 'stacked')
legend('Correcto', 'Falso positivo', 'Falso Negativo')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
corr_sum = sum(correcto);
fals_p_sum = sum(falso_pos);
fals_n_sum = sum(falso_neg);
tarta = [corr_sum, fals_p_sum, fals_n_sum];
h = pie(tarta);
legend(sprintf('C %i',corr_sum),sprintf('FP %i',fals_p_sum),sprintf('FN %i',fals_n_sum))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(4)
% graf_progreso_y = [graf_progreso_y(2:end,:);tarta];
% semilogy(graf_progreso_x,graf_progreso_y)
% ylim([min(graf_progreso_y(:))/1.5 max(graf_progreso_y(:))*1.5])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drawnow