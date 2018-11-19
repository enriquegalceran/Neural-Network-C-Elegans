%Hyper-markov
clear
lista_gen = zeros(1,20);
for hasta = 1:20
    desde = 1;
%     hasta = 2;
    gusano_cuenta = hasta-desde+1;
    simulaciones = 100;
    len_datosmax = 0;
    direccion = 'stateSequences_limpio/datos/';
    tic
    Supermatriz
    for gusano = desde:hasta
    %     Name_of_file = sprintf('%s%s.mat',direccion, subnum(gusano,1234));
    %     clear stateSequence
    %     load(Name_of_file)
    %     DataSet=stateSequence(:,1);
    % 
    %     len_datos = length(DataSet);
    %     if len_datos > len_datosmax
    %         len_datosmax = len_datos;
    %     end
    % 
        T=zeros(90,90);
        Acum = zeros(90,90);
        for x = 1:longitud_total
            [~, indx] = max(Valores_shuffled(x,1:90));
            [~, indy] = max(Valores_shuffled(x,91:180));
            T(indx,indy) = T(indx,indy) + 1;
        end

        for i = 1:90
            suma = sum(T(i,:));
            if suma ~= 0
                T(i,:)= T(i,:)/suma;
            end

            for j = 1:90
                if j == 1
                    Acum(i,j) = T(i,j);
                else
                    Acum(i,j) = T(i,j) + Acum(i,j-1);
                end
            end
        end
    end


    bueno = 0;
    malo = 0;
    Prob = zeros(longitud_total, simulaciones);
    for simul = 1:simulaciones
        for x = 1:longitud_total
            [~, indx] = max(Valores_shuffled(x,1:90));
            azar = rand(1);
            for azar_c = 1:90
                if azar <= Acum(indx,azar_c)
                    Prob(x,simul) = azar_c;
                    break
                end
            end
            [~, indy] = max(Valores_shuffled(x,91:180));
            if indy == azar_c
                bueno = bueno +1;
            else
                malo = malo +1;
            end
        end
    end
    relacion = bueno/(longitud_total*simulaciones)*100;
    toc
    figure(8)
    pie([bueno, malo]);
    title(sprintf('Simul. = %i | Exito = %2.3f%%', simulaciones, relacion))
    colormap parula
    lista_gen(hasta) = bueno/(bueno+malo);
end
figure
plot(linspace(1,20,20),lista_gen)