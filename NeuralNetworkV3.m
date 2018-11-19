% Neural Network v3
% Preparado para hacer el caso A un poco a la fuerza
% 90 inputs, 4 hidden layers, 90 outputs and 5 synapsis

% Neural network using https://enlight.nyc/neural-network/ as a base

% Personalize the random seed to today's day
% rng(datenum(datetime('now')));

%% ___INI___

%% Data inputs & Iterations
% Cleans the dataset and makes sure it's "fresh"
clear
% clear stateSequence
load(sprintf('stateSequences_90/%istateSequence_90means_N2-1000_ds-5.mat',2775))

% Number of iterations to perform
n_iteraciones = 10000000;
cuantas_entradas_tiempo = 8;
% [DataSetSize, ~] = size(stateSequence);
% cuantas_lineas = DataSetSize-cuantas_entradas_tiempo;
cuantas_lineas = 60;

% Prepare X and Y to work with the bias and the Dataset
[X, Y, stateSequence] = ordenar_prime(stateSequence, cuantas_entradas_tiempo, cuantas_lineas);
X = X/90;
% Y = Y/90;
BiasVector = ones(cuantas_lineas,1);
X = [X,BiasVector];

%% ANN Size
% Size of the inputs, outputs and hidden layers. Do NOT include the extra
% space for the Bias!
inputSize = cuantas_entradas_tiempo; % It's the same, but for congruence's sake it's renamed 
hiddenSize1 = 30;
hiddenSize2 = 30;
hiddenSize3 = 30;
hiddenSize4 = 40;
outputSize = 90;

Syn1 = rand(inputSize+1, hiddenSize1)*2-1;
Syn2 = rand(hiddenSize1+1, hiddenSize2)*2-1;
Syn3 = rand(hiddenSize2+1, hiddenSize3)*2-1;
Syn4 = rand(hiddenSize3+1, hiddenSize4)*2-1;
Syn5 = rand(hiddenSize4+1, outputSize)*2-1;

%% Drawing
% If it is going to have a small amount of iterations, we will probably
% want to draw the optimization variable on the go. It will reduce the
% calculation time.
% dibujar = 2/1/0 to sometimes/always/never
dibujar = 0;
err_y = linspace(1, n_iteraciones, n_iteraciones);
err_x = linspace(1, n_iteraciones, n_iteraciones);
semilogy(err_x,err_y)
grid minor

%% Saving Path
% Saving Path. Creates directory as well as the frecueny of backups
nombre_archivo = mfilename;
direcc = sprintf('backup/%s', nombre_archivo);
is_directory = exist(direcc, 'dir');
if is_directory == 0
    mkdir('backup', nombre_archivo);
end
cada_cuantos_guardar = 500;
cada_cuantos_limpiar = 5;

%% TRAINING
tic
for j = 1:100000000
%     [X,Y,stateSequence] = ordenar(stateSequence, X, Y, cuantas_entradas_tiempo);
    for i= 1:n_iteraciones
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
        if dibujar == 1
            derr_x = err_x(1:i);
            derr_y = err_y(1:i);
            title(sprintf('%i',i))
            semilogy(derr_x, derr_y);
            grid minor
            drawnow
        end

        %% Backups de seguridad
        if rem(i,cada_cuantos_guardar) == 0
            filename = sprintf('backup/%s/%i.mat', nombre_archivo, i);
            save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y')
            if dibujar == 2
                derr_x = err_x(1:i);
                derr_y = err_y(1:i);
                subplot(2,1,1)
                loglog(derr_x, derr_y);
                title(sprintf('%i',i))
                grid on
                grid minor
                subplot(2,1,2)
                semilogy(derr_x, derr_y);
                title(sprintf('%i',i))
                grid on
                grid minor
                drawnow
            end
            if rem(i,cada_cuantos_guardar*cada_cuantos_limpiar) == 0
                for j=1:cada_cuantos_limpiar-1
                    filename_borrar = sprintf('backup/%s/%i.mat', nombre_archivo, i-cada_cuantos_guardar*j);
                    delete(filename_borrar)
                end
            end
        end

    end
end
elapsedTime = toc;
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
save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y', 'elapsedTime')

