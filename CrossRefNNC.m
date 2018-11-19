% comprobar si funciona la red neuronal.
% redondeará y mirará si ha salido bien o no
e = 1;
figure(32)
q_max = 1188; %cual es el último gusano a evaluar
% load('C:\Users\boorg\Neural Network C Elegans\backup\Red multiple 90% 90-50-90 V9 1-3.mat')
load('Red 51-53 creado en ordenador Ben 31-1.mat')
guardar_matriz = zeros(q_max, q_max);
for q = 1:q_max
    e = e+q-1;
    for w = q:q %q_max

        bueno = 0;
        malo = 0;
        correcto = zeros(1,90);
        falso_neg = zeros(1,90);
        falso_pos = zeros(1,90);

        for p = q:w
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
                graf_progreso_y = zeros(100,2);
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
                [max_num, res_indx] = max(res_C(:));
                [max_num_Y, Y_indx] = max(Y_c(:));

                if res_indx == Y_indx
                    bueno = bueno + 1;
                    correcto(res_indx) = correcto(res_indx) + 1;
                else
                    malo = malo + 1;
                    falso_neg(Y_indx) = falso_neg(Y_indx) + 1;
                    falso_pos(res_indx) = falso_pos(res_indx) + 1;
                end

            end

        end
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         figure(31)
%         bar_data = [correcto',falso_pos', falso_neg'];
%         bar(bar_data, 'stacked')
%         legend('Correcto', 'Falso positivo', 'Falso Negativo')
% 
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         figure(32)
%         subplot(q_max,q_max,e)
%         tarta = [bueno, malo];
%         h = pie(tarta);
%         title(sprintf('%i - %i',q,w))
%         ax = gca;
%         ax.FontSize = 8;
%         legend(sprintf('B %i',bueno),sprintf('M %i',malo))

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        drawnow
        e = e+1;
        guardar_matriz(q,w) = bueno/(bueno+malo);
    end
end

guardar_matriz2 = zeros(1,1188);
for jj = 1: 1188

    guardar_matriz2(jj) = guardar_matriz(jj,jj);
    
end
guardar_matriz = guardar_matriz2;
save(sprintf('C:/Users/boorg/Dropbox/backup Neural Networks/GuardarMatrizNN %i.mat', contador), 'guardar_matriz2')