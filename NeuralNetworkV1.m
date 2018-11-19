% Neural Network v1
% 90 inputs, 4 hidden layers, 90 outputs and 5 synapsis

% simple neural network using https://enlight.nyc/neural-network/

seed = datenum(datetime('now'));
rng(seed);

X = [[2,9]; [1,5]; [3,6]];
Y = [92; 86; 89];
y = Y/100;
n_iteraciones = 10000;

inputSize = 2;
hiddenSize1 = 3;
hiddenSize2 = 3;
hiddenSize3 = 3;
hiddenSize4 = 3;
outputSize = 1;

Syn1 = rand(inputSize, hiddenSize1);
Syn2 = rand(hiddenSize1, hiddenSize2);
Syn3 = rand(hiddenSize2, hiddenSize3);
Syn4 = rand(hiddenSize3, hiddenSize4);
Syn5 = rand(hiddenSize4, outputSize);

% Si dibujamos en directo dibujar = 1
dibujar = 0;
if dibujar == 1
    err_y = [];
    err_x = [];
else
    err_y = linspace(1, n_iteraciones, n_iteraciones);
    err_x = linspace(1, n_iteraciones, n_iteraciones);
end

% parametros guardar
nombre_archivo = mfilename;
direcc = sprintf('backup/%s', nombre_archivo);
a = exist(direcc, 'dir');
if a == 0
    mkdir('backup', nombre_archivo);
end
cada_cuantos_guardar = 1000;
cada_cuantos_limpiar = 5;

% training
tic
for i= 1:n_iteraciones
    %% Forwards
    w1 = X*Syn1;
    z1 = arrayfun(@(x) sigmoide(x),w1);
    w2 = z1*Syn2;
    z2 = arrayfun(@(x) sigmoide(x),w2);
    w3 = z2*Syn3;
    z3 = arrayfun(@(x) sigmoide(x),w3);
    w4 = z3*Syn4;
    z4 = arrayfun(@(x) sigmoide(x),w4);
    w5 = z4*Syn5;
    res = arrayfun(@(x) sigmoide_res(x),w5);

    %% Backwards
    % calcular el error del puente final
    res_er = y - res;
    res_delta =res_er.*arrayfun(@(x) sigmoideDer_res(x),res);

    %calcular el error del primer puente
    z4_er = res_delta*Syn5';
    z4_delta =z4_er.*arrayfun(@(x) sigmoideDer(x), z4);

    z3_er = z4_delta*Syn4';
    z3_delta =z3_er.*arrayfun(@(x) sigmoideDer(x), z3);

    z2_er = z3_delta*Syn3';
    z2_delta =z2_er.*arrayfun(@(x) sigmoideDer(x), z2);

    z1_er = z2_delta*Syn2';
    z1_delta =z1_er.*arrayfun(@(x) sigmoideDer(x), z1);

    %% Corrección de los puentes
    Syn1 = Syn1 + X'*z1_delta;
    Syn2 = Syn2 + z1'*z2_delta;
    Syn3 = Syn3 + z2'*z3_delta;
    Syn4 = Syn4 + z3'*z4_delta;
    Syn5 = Syn5 + z4'*res_delta;
    
    %% Representacion
    err_y(i) = norm(res_er);
    if dibujar == 1
        err_x(i) = i;
        yyaxis left
        grid on
        semilogy(err_x, err_y);
        yyaxis right
        plot(err_x, err_y);
        drawnow
    end
    
    %% Copia de seguridad
    if rem(i,cada_cuantos_guardar) == 0
        filename = sprintf('backup/%s/%i.mat', nombre_archivo, i);
        save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y')
        if rem(i,cada_cuantos_guardar*cada_cuantos_limpiar) == 0
            for j=1:cada_cuantos_limpiar-1
                filename_borrar = sprintf('backup/%s/%i.mat', nombre_archivo, i-cada_cuantos_guardar*j);
                delete(filename_borrar)
            end
        end
    end

end
%% Dibujo final
if dibujar == 0
    semilogy(err_x, err_y);
    grid on
    grid minor
end


%% Evaluar como prueba final
    test = X
    w1 = X*Syn1;
    z1 = arrayfun(@(x) sigmoide(x),w1);
    w2 = z1*Syn2;
    z2 = arrayfun(@(x) sigmoide(x),w2);
    w3 = z2*Syn3;
    z3 = arrayfun(@(x) sigmoide(x),w3);
    w4 = z3*Syn4;
    z4 = arrayfun(@(x) sigmoide(x),w4);
    w5 = z4*Syn5;
    res = arrayfun(@(x) sigmoide_res(x),w5)
sprintf('iteraciones: %1i | error final: %1.10f', n_iteraciones, err_y(end))
elapsedTime = toc;
fprintf('Elapsed time is %1.6f seconds.', elapsedTime)
filename = sprintf('backup/%s/Resultado %i iteraciones.mat', nombre_archivo, n_iteraciones);
save(filename, 'Syn1', 'Syn2', 'Syn3', 'Syn4', 'Syn5', 'err_y', 'elapsedTime')

