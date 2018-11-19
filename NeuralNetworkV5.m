% Neural Network v5
% Preparado para hacer el caso B-C
% 90 inputs, 4 hidden layers, 90 outputs
% Empieza a funcionar! Peparacion para analizar varios gusanos diferentes.

% Neural network using https://enlight.nyc/neural-network/ as a base

% Personalize the random seed to today's date
% rng(datenum(datetime('now')));

%% ___INI___

%% Data inputs & Iterations
% Cleans the dataset and makes sure it's "fresh"
clear stateSequence
% clear stateSequence
load(sprintf('stateSequences_90/%istateSequence_90means_N2-1000_ds-5.mat',2775))
DataSet=stateSequence(:,1); %just a 1-D vector

% Number of iterations to perform
n_iteraciones = 1000000;
loops_cada_bloque = 1;
entradas_tiempo = 5;
% [DataSetSize, ~] = size(stateSequence);
% cuantas_lineas = DataSetSize-cuantas_entradas_tiempo;
lineas_simultaneas = 2;

% Prepare X and Y to work with the bias and the Dataset
[X, Y, DataSet] = rotar_ini(DataSet, lineas_simultaneas, entradas_tiempo);
BiasVector = ones(lineas_simultaneas,1);
X = [X,BiasVector];
volver_a_empezar = 2;

%% ANN Size and Synapses
% Size of the inputs, outputs and hidden layers. Do NOT include the extra
% space for the Bias!
inputSize = 90;
hiddenSize1 = 250;
hiddenSize2 = 250;
hiddenSize3 = 250;
hiddenSize4 = 250;
outputSize = 90;

% Comment the section as needed
% Random Start
Syn1 = rand(inputSize+1, hiddenSize1)*2-1;
Syn2 = rand(hiddenSize1+1, hiddenSize2)*2-1;
Syn3 = rand(hiddenSize2+1, hiddenSize3)*2-1;
Syn4 = rand(hiddenSize3+1, hiddenSize4)*2-1;
Syn5 = rand(hiddenSize4+1, outputSize)*2-1;

% Import from last version
% load(sprintf('backup/%s/%i.mat', nombre_archivo, ultimo_guardado));
% load(sprintf('backup/NeuralNetworkV4/Resultado Buenos/Muchas iteraciones 3 lineas, o temporal, 90-90-90-90-90-90.mat'));

%% Drawing
% If it is going to have a small amount of iterations, we will probably
% want to draw the optimization variable on the go. It will reduce the
% calculation time.
% dibujar = 3/2/1/0 --> seldom/often/always/never
dibujar = 2;
dibujar_graf = 1;
cuantos_mostrar = 50000; %Cuantos se muestran en la parte de arriba
err_y = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
err_x = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
err_m = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
err_m2 = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
media = 10;%cuando se utilizan para dibujar la linea de media
media2 = 1000;
figure(1)
loglog(err_x,err_y)
grid minor
drawnow

% How many of the initial iterations are to be cleaned
Clean = 10;

%% Saving Path
% Saving Path. Creates directory as well as the frecueny of backups
nombre_archivo = mfilename;
direcc = sprintf('backup/%s', nombre_archivo);
is_directory = exist(direcc, 'dir');
if is_directory == 0
    mkdir('backup', nombre_archivo);
end
cada_cuantos_guardar = 1000;
cada_cuantos_limpiar = 10;

%% TRAINING
Comprobar;
tic
i = 1;
for m = 1:n_iteraciones
    if volver_a_empezar == 0
        [X,Y,DataSet,volver_a_empezar] = rotar(DataSet, X(:,1:90), Y, lineas_simultaneas, entradas_tiempo);
        X = [X,BiasVector];
    elseif volver_a_empezar == 1
        [X, Y, DataSet] = rotar_ini(stateSequence(:,1), lineas_simultaneas, entradas_tiempo);
        X = [X,BiasVector];
        volver_a_empezar = 0;
    elseif volver_a_empezar == 2
        volver_a_empezar = 0;
        % No hacer nada. control de la primera iteracion
    else
        error('No debería salir esto. Volver a empezar tiene que ser 0, 1 o 2')
    end
    
    if i>Clean && Clean > 0
        err_y = linspace(1, n_iteraciones*loops_cada_bloque-Clean, n_iteraciones*loops_cada_bloque-Clean);
        err_x = linspace(1, n_iteraciones*loops_cada_bloque-Clean, n_iteraciones*loops_cada_bloque-Clean);
        Clean = 0;
        i = 1;
    end
    
    for n= 1:loops_cada_bloque
        %% Forwards
        % Applys the synapses and evaluates the neural network. Takes Bias into
        % account.
        w1 = X*Syn1;
        z1 = [arrayfun(@(x) sigmoide(x),w1),BiasVector];
        w2 = z1*Syn2;
        z2 = [arrayfun(@(x) sigmoide(x),w2),BiasVector];
        w3 = z2*Syn3;
        z3 = [arrayfun(@(x) sigmoide(x),w3),BiasVector];
        w4 = z3*Syn4;
        z4 = [arrayfun(@(x) sigmoide(x),w4),BiasVector];
        w5 = z4*Syn5;
        res = arrayfun(@(x) sigmoide(x),w5);

        %% Backwards
        % Operates the error of the ANN and backtracks.
        res_er = Y - res;
        res_delta =res_er.*arrayfun(@(x) sigmoideDer(x),res);

        z4_er = res_delta*Syn5';
        z4_delta =z4_er.*arrayfun(@(x) sigmoideDer(x), z4);
        z4_delta = z4_delta(:,1:hiddenSize4);

        z3_er = z4_delta*Syn4';
        z3_delta =z3_er.*arrayfun(@(x) sigmoideDer(x), z3);
        z3_delta = z3_delta(:,1:hiddenSize3);

        z2_er = z3_delta*Syn3';
        z2_delta =z2_er.*arrayfun(@(x) sigmoideDer(x), z2);
        z2_delta = z2_delta(:,1:hiddenSize2);

        z1_er = z2_delta*Syn2';
        z1_delta =z1_er.*arrayfun(@(x) sigmoideDer(x), z1);
        z1_delta = z1_delta(:,1:hiddenSize1);

        %% Reevaluating the Synapses
        Syn1 = Syn1 + X'*z1_delta;
        Syn2 = Syn2 + z1'*z2_delta;
        Syn3 = Syn3 + z2'*z3_delta;
        Syn4 = Syn4 + z3'*z4_delta;
        Syn5 = Syn5 + z4'*res_delta;

        %% Plotting
        % err is the norm of the error function. Takes into account the
        % multiple attempts that are made simultaneously
        err_y(i) = norm(res_er);
        err_m(i) = mean(err_y(max(i-media,1):i));
        err_m2(i) = mean(err_y(max(i-media2,1):i));
        if dibujar == 1
            figure(1)
            derr_x = err_x(1:i);
            derr_y = err_y(1:i);
            derr_m = err_m(1:i);
            derr_m2 = err_m2(1:i);
            subplot(2,1,1)
            hold off
            loglog(derr_x, derr_y, 'b');
            hold on
            loglog(derr_x, derr_m, 'r');
            loglog(derr_x, derr_m2, 'y');
            title(sprintf('%i | %1.4f',i, mean(derr_m(end))))
            grid on
            grid minor
            subplot(2,1,2)
            hold off
            semilogy(derr_x, derr_y);
            hold on
            semilogy(derr_x, derr_m, 'r');
            semilogy(derr_x, derr_m2, 'y');
            title(sprintf('%i | %1.4f',i, derr_m2(end)))
            grid on
            grid minor
            drawnow
        end

        %% Backups de seguridad
        if rem(i,cada_cuantos_guardar) == 0
            filename = sprintf('backup/%s/%i.mat', nombre_archivo, i);
            ultimo_guardado = i;
            ahora = datetime('now');
            if exist('tarta', 'var') == 0
                tarta = [0,0,0];
            end
            save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y', 'ahora', 'tarta')
            if dibujar == 2
                figure(1)
                derr_x = err_x(1:i);
                derr_y = err_y(1:i);
                derr_m = err_m(1:i);
                derr_m2 = err_m2(1:i);
                subplot(2,1,1)
                hold off
                loglog(derr_x, derr_y, 'b');
                hold on
                loglog(derr_x, derr_m, 'r');
                loglog(derr_x, derr_m2, 'y');
                title(sprintf('%i | %1.4f',i, mean(derr_m(end))))
                grid on
                grid minor
                subplot(2,1,2)
                hold off
                semilogy(derr_x, derr_y);
                hold on
                semilogy(derr_x, derr_m, 'r');
                semilogy(derr_x, derr_m2, 'y');
                title(sprintf('%i | %1.4f',i, derr_m2(end)))
                grid on
                grid minor
                drawnow
            end
            if rem(i,cada_cuantos_guardar*cada_cuantos_limpiar) == 0
                for k=1:cada_cuantos_limpiar-1
                    filename_borrar = sprintf('backup/%s/%i.mat', nombre_archivo, i-cada_cuantos_guardar*k);
                    delete(filename_borrar)
                end
                if dibujar_graf ==1 
                    Comprobar;
                    figure(1)
                end
                if dibujar == 3
                    figure(1)
                    derr_x = err_x(1:i);
                    derr_y = err_y(1:i);
                    derr_m = err_m(1:i);
                    derr_m2 = err_m2(1:i);
                    subplot(2,1,1)
                    hold off
                    loglog(derr_x, derr_y, 'b');
                    hold on
                    loglog(derr_x, derr_m, 'r');
                    loglog(derr_x, derr_m2, 'y');
                    title(sprintf('%i | %1.4f',i, mean(derr_m(end))))
                    grid on
                    grid minor
                    subplot(2,1,2)
                    hold off
                    semilogy(derr_x, derr_y);
                    hold on
                    semilogy(derr_x, derr_m, 'r');
                    semilogy(derr_x, derr_m2, 'y');
                    title(sprintf('%i | %1.4f',i, derr_m2(end)))
                    grid on
                    grid minor
                    drawnow
                end
            end
        end
    i = i+1;
    elapsedTime = toc;
    end
end





%% Final plot
if dibujar == 0
    semilogy(err_x, err_y);
    grid on
    grid minor
end

%% Evaluar como prueba final
% Final testing of the Neural Network
test = X
res = evaluate(test, Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector)
sprintf('iteraciones: %1i | error final: %1.10f', n_iteraciones, err_y(end))

fprintf('Elapsed time is %1.6f seconds. (%1.4f minutos)', elapsedTime, elapsedTime/60)
filename = sprintf('backup/%s/Resultado %i iteraciones.mat', nombre_archivo, n_iteraciones);
save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y', 'elapsedTime', 'ahora')

