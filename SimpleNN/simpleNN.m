% simple neural network using https://enlight.nyc/neural-network/

seed = datenum(datetime('now'));
rng(seed);
a = sigmoide(1);
X = [[2,9]; [1,5]; [3,6]];
Y = [92; 86; 89];
y = Y/100;

n_iteraciones = 10000;

inputSize = 2;
hiddenSize = 3;
outputSize = 1;

W1 = rand(inputSize, hiddenSize);
W2 = rand(hiddenSize, outputSize);


err_y = linspace(1,n_iteraciones, n_iteraciones);

%parametros guardar
nombre_archivo = mfilename;
mkdir('backup', nombre_archivo);
cada_cuantos_guardar = 1000;
cada_cuantos_limpiar = 5;

%training
for i= 1:n_iteraciones
    %%%% Forward
    z = X*W1;
    z2 = arrayfun(@(x) sigmoide(x),z);
    z3 = z2*W2;
    res = arrayfun(@(x) sigmoide(x),z3);

    %%%% Backwards
    % calcular el error del puente final
    res_er = y - res;
    err_y(i) = norm(res_er);
    res_delta =res_er.*arrayfun(@(x) sigmoideDer(x),res);

    %calcular el error del primer puente
    z2_er = res_delta*W2';
    z2_delta =z2_er.*arrayfun(@(x) sigmoideDer(x), z2);

    %Corrección de los puentes
    W1 = W1 + X'*z2_delta;
    W2 = W2 + z2'*res_delta;
    
    %Backup variables
    if rem(i,cada_cuantos_guardar) == 0
        filename = sprintf('backup/%s/%i.mat', nombre_archivo, i);
        save(filename, 'W1', 'W2', 'err_y')
        if rem(i,cada_cuantos_guardar*cada_cuantos_limpiar) == 0
            for j=1:cada_cuantos_limpiar-1
                filename_borrar = sprintf('backup/%s/%i.mat', nombre_archivo, i-1000*j);
                delete(filename_borrar)
            end
        end
    end
end

%Evaluar como prueba final
test = X
err_x = linspace(1,n_iteraciones, n_iteraciones);
semilogy(err_x, err_y)
ylabel('log')
z = test*W1;
z2 = arrayfun(@(x) sigmoide(x),z);
z3 = z2*W2;
res = arrayfun(@(x) sigmoide(x),z3)
sprintf('iteraciones: %1i | error final: %1.10f', n_iteraciones, err_y(end))