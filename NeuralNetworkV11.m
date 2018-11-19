% Neural Network v11
% Aquí utilizará la incorporación de la matriz R de correlación de André
% NO FUNCIONA
%
% Neural network using https://enlight.nyc/neural-network/ as a base
%
%
% Parametres (alfabetical order):
%       cada_cuantos_guardar - after how many iteration does the NN backup
%               the data
%       cada_cuantos_limpiar - how frequently does the backups get cleaned
%               and reduced in number
%       Clean - how many initial iterations are deleted so that the
%               plotting has reasonable limits in the Y axis
%       cuantos_usar - How many worms are taken into account for the neural
%               network.
%       dibujar - When does the plotting accour (look %%Drawing)
%       dir_datos - Where the Data is located
%       entradas_tiempo - ??????????
%       hiddenSize/inputSize/outputSize - how many Neurons are in each layer
%       learning_rate - learning rate
%                    _ini - initial learning rate
%                    _frecuency - how many iterations between reduction of
%                               the learning rate
%                    _max/min - max and minimum value of the LR
%                    _rate - how much it changes each time
%       lim_contador - limit to the value 'contador' (i reset)
%       lineas_simultaneas - how big is each batch
%       lo - parametre used to locate the next input datas. changes automa.
%       loops_cada_bloque - how many iterations does each batch go through.
%                Normally it's 1
%       media - How many iterations are taken into account for the mean-line
%       n_iteraciones - how many iterations are per each 'contador' cycle
%       tarta - if available, the relation betweeen successfull evaluations
%               and failed evaluation of the NN.



% Personalize the random seed to today's day
% rng(datenum(datetime('now')));

%% ___INI___

%% Data inputs & Iterations
%cambiar valor para los diferentes datos
% clear
desde = 1;
hasta = 3;
Supermatriz;
load(sprintf('stateSequences_limpio/todos mezclados %s-%s.mat',...
    subnum(desde,1234), subnum(hasta, 1234)),'X_mezclada', 'Y_mezclada')
% load('backup/NeuralNetworkV9/1/699500.mat','Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5')
long_total = length(X_mezclada);
% Number of iterations to perform
n_iteraciones = 500000;
loops_cada_bloque = 1;
entradas_tiempo = 1;
lineas_simultaneas = 20; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gusano = 2775;
contador = 1;
lim_contador = 1000000;
% Prepare X and Y to work with the bias and the Dataset
BiasVector = ones(lineas_simultaneas,1);
volver_a_empezar = 1; % Used to reset the dataset when it reaches the end.

%% Rmat

% Creates he 
Rmat = vectorCor(postures2', postures2');
Y_ind = zeros(1,long_total);
for i = 1:long_total
    [~, Y_temp_ind] = max(Y_mezclada(i,:));
    Y_temp = Rmat(Y_temp_ind,:);
    Y_mezclada(i,:) = (Y_temp+1)/2;
    Y_ind(i) = Y_temp_ind;
end
long_validacion = round(long_total*0.15);
Datos_validacion = Valores_shuffled(end-long_validacion+1:end,:);
Valores_shuffled = Valores_shuffled(1:end-long_validacion,:);
long_total = length(Valores_shuffled);

%% Learning rate
learning_rate = 0.001;
learning_rate_rate = 0.95;
learning_rate_frecuency = 3000;
learning_rate_max = 10;
learning_rate_min = 0.00001;

%% ANN Size and Synapses
% Size of the inputs, outputs and hidden layers. Do NOT include the extra
% space for the Bias!
inputSize = 90;
hiddenSize1 = 60;
hiddenSize2 = 60;
hiddenSize3 = 60;
hiddenSize4 = 60;
outputSize = 90;

% Comment the section as needed

% Random Start
Syn1 = normrnd(0,1,inputSize+1,   hiddenSize1);
Syn2 = normrnd(0,1,hiddenSize1+1, hiddenSize2);
Syn3 = normrnd(0,1,hiddenSize2+1, hiddenSize3);
Syn4 = normrnd(0,1,hiddenSize3+1, hiddenSize4);
Syn5 = normrnd(0,1,hiddenSize4+1, outputSize);

% Syn1 = normrnd(0,1/sqrt(inputSize+1),inputSize+1,   hiddenSize1);

% Import from last version
% load(sprintf('backup/%s/%i.mat', nombre_archivo, ultimo_guardado));

%% Drawing
% If it is going to have a small amount of iterations, we will probably
% want to draw the optimization variable on the go. It will reduce the
% calculation time.
% dibujar = 3/2/1/0 --> seldom/often/always/never
dibujar = 2;

err_y = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
err_x = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
err_m = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
media = 1000;%cuando se utilizan para dibujar la linea de media
figure(1)
loglog(err_x,err_y)
grid minor
drawnow

% How many of the initial iterations are to be cleaned
Clean = 50;

%% Saving Path
% Saving Path. Creates directory as well as the frecueny of backups
nombre_archivo = mfilename;
direcc = sprintf('backup/%s', nombre_archivo);
is_directory = exist(direcc, 'dir');
if is_directory == 0
    mkdir('backup', nombre_archivo);
end

direcc = sprintf('backup/%s/%i', nombre_archivo, contador);
is_directory_g = exist(num2str(direcc), 'dir');
if is_directory_g == 0
    mkdir(sprintf('backup/%s',nombre_archivo), num2str(contador));
end

%Cada cuantos se va a guardar y cuantos de limpian
cada_cuantos_guardar = 200;
cada_cuantos_limpiar = 20;

%% TRAINING
tic
lo = 1;
% Comprobar2;
fprintf('C: %s/%i - I: %s/%i',subnum(0,lim_contador), lim_contador, subnum(0,n_iteraciones),n_iteraciones); 
for contador = 1:lim_contador
     learning_rate = learning_rate/0.81;    
    i = 1;
    direcc = sprintf('backup/%s/%i', nombre_archivo, contador);
    is_directory_g = exist(num2str(direcc), 'dir');
    if is_directory_g == 0
        mkdir(sprintf('backup/%s',nombre_archivo), num2str(contador));
    end
    
    for m = 1:n_iteraciones
        a = repmat('\b',1,length(num2str(n_iteraciones))*2+length(num2str(lim_contador))*2+8);
        fprintf(a);
        fprintf('%s/%i - I: %s/%i',subnum(contador,lim_contador), lim_contador, subnum(i,n_iteraciones),n_iteraciones)
        
        if volver_a_empezar == 0
            X = [X_mezclada(lo:lo+lineas_simultaneas-1,:),BiasVector];
            Y = Y_mezclada(lo:lo+lineas_simultaneas-1,:);
            lo = lo + lineas_simultaneas;
            if lo+lineas_simultaneas >= long_total
                volver_a_empezar = 1;
            end
        elseif volver_a_empezar == 1
            X = [X_mezclada(1:lineas_simultaneas,:),BiasVector];
            Y = Y_mezclada(1:lineas_simultaneas,:);
            lo = 1 + lineas_simultaneas;
            volver_a_empezar = 0;
        else
            error('No debería salir esto. Volver a empezar tiene que ser 0, 1 o 2')
        end

        if i>Clean && Clean > 0
            err_y = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
            err_x = linspace(1, n_iteraciones*loops_cada_bloque, n_iteraciones*loops_cada_bloque);
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
            res = arrayfun(@(x) sigmoide_res(x),w5);

            %% Backwards
            % Operates the error of the ANN and backtracks.
            res_er = -Y.*log(res)+(1-Y).*log(1-res);
%             res_er = (Y-res).^2;
            res_delta =res_er.*arrayfun(@(x) sigmoideDer_res(x),res);

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
            Syn1 = Syn1 + learning_rate*X'*z1_delta;
            Syn2 = Syn2 + learning_rate*z1'*z2_delta;
            Syn3 = Syn3 + learning_rate*z2'*z3_delta;
            Syn4 = Syn4 + learning_rate*z3'*z4_delta;
            Syn5 = Syn5 + learning_rate*z4'*res_delta;

            %% Plotting
            % err is the norm of the error function. Takes into account the
            % multiple attempts that are made simultaneously
            err_y(i) = norm(res_er)/lineas_simultaneas;
            err_m(i) = mean(err_y(max(i-media,1):i));
            if dibujar == 1
%                 Comprobar2;
                if gcf ~=1
                    figure(1)
                end
                derr_x = err_x(1:i);
                derr_y = err_y(1:i);
                derr_m = err_m(1:i);
                hold off
                semilogy(derr_x, derr_y);
                hold on
                semilogy(derr_x, derr_m, 'r');
                title(sprintf('%i - %i - %1.5f', contador, i, learning_rate))
                grid on
                grid minor
                drawnow
            end

            %% Backups de seguridad
            if rem(i,cada_cuantos_guardar) == 0
                filename = sprintf('backup/%s/%i/%s.mat', nombre_archivo, contador, subnum(i,n_iteraciones));
                ultimo_guardado = i;
                ahora = datetime('now');
                save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'ahora', 'elapsedTime', 'entradas_tiempo', 'lineas_simultaneas', 'desde', 'hasta', 'tarta','nombre_archivo')
                if dibujar == 2
                    if gcf ~=1
                        figure(1)
                    end
                    derr_x = err_x(1:i);
                    derr_y = err_y(1:i);
                    derr_m = err_m(1:i);
                    hold off
                    semilogy(derr_x, derr_y);
                    hold on
                    semilogy(derr_x, derr_m, 'r');
                    title(sprintf('%i - %i - %1.5f', contador, i, learning_rate))
                    grid on
                    grid minor
                    drawnow
                end
                if rem(i,cada_cuantos_guardar*cada_cuantos_limpiar) == 0
                    for k=1:cada_cuantos_limpiar-1
                        filename_borrar = sprintf('backup/%s/%i/%s.mat', nombre_archivo, contador, subnum(i-cada_cuantos_guardar*k, n_iteraciones));
                        delete(filename_borrar)
                    end
%                     Comprobar2;
                    figure(1)
                    if dibujar == 3
                        if gcf ~=1
                            figure(1)
                        end
                        derr_x = err_x(1:i);
                        derr_y = err_y(1:i);
                        derr_m = err_m(1:i);
                        hold off
                        semilogy(derr_x, derr_y);
                        hold on
                        semilogy(derr_x, derr_m, 'r');
                        title(sprintf('%i - %i - %1.5f', contador, i, learning_rate))
                        grid on
                        grid minor
                        drawnow
                    end
                end
            end
        i = i+1;
        if rem(i,learning_rate_frecuency) == 0 && learning_rate<learning_rate_max && learning_rate>learning_rate_min
            learning_rate=learning_rate*learning_rate_rate;
        end
        elapsedTime = toc;
        end
    end

    fprintf('\niteraciones: %1i | error final: %1.10f \n', n_iteraciones, err_y(end))
    fprintf('Elapsed time is %1.6f seconds. (%1.4f minutos)', elapsedTime, elapsedTime/60)
    filename = sprintf('backup/%s/%i/Resultado %i iteraciones.mat', nombre_archivo, contador, n_iteraciones);
    save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y', 'ahora', 'elapsedTime', 'entradas_tiempo', 'lineas_simultaneas', 'desde', 'hasta')
    fprintf('\nC: %s/%i - I: %s/%i',subnum(contador,lim_contador), lim_contador, subnum(i,n_iteraciones),n_iteraciones); 
end