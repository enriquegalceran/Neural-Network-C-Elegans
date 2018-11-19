%Markov
tic
if exist('T', 'var') * exist('Acum', 'var') == 0
    clear stateSequence
%     nombre_gusano = 2775
    load(sprintf('stateSequences_90/%istateSequence_90means_N2-1000_ds-5.mat',nombre_gusano))
    DataSet=stateSequence(:,1);

    len_datos = length(DataSet);

    T=zeros(90,90);
    for i = 1:len_datos-1
        T(DataSet(i),DataSet(i+1)) = T(DataSet(i),DataSet(i+1)) + 1;
    end
    
    for i = 1:90
        suma = sum(T(i,:));
        if suma ~= 0
            T(i,:)= T(i,:)/suma;
        end
    end

    %Probabilidad acumulada
    Acum = zeros(90,90);

    for i = 1:90
        for j = 1:90
            if j == 1
                Acum(i,j) = T(i,j);
            else
                Acum(i,j) = T(i,j) + Acum(i,j-1);
            end
        end
    end
end

%Azar
simulaciones = 1000;
Prob = zeros(len_datos-1,simulaciones);
% Añadir posible bucle que envuelve el bucle de abajo para darle más
% simulaciones. En ese caso habrá también que hacer más cálculos para
% comprobar.
for k = 1:simulaciones
    for i = 1:len_datos-1
        azar = rand(1);
        for j = 1:90
            if azar <= Acum(DataSet(i),j)
                Prob(i,k) = j;
                break
            end
        end
    end
end


% Comprobar Markov:
bien = 0;
mal = 0;
for k = 1:simulaciones
    for i = 1:len_datos-1
        if Prob(i,k) == DataSet(i+1)
            bien = bien +1;
        else
            mal = mal +1;
        end
    end
end
toc
relacion = bien / (bien + mal)
