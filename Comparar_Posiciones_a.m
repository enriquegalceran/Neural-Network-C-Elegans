% Comparar posiciones automáticas

load('postures_90-centers_20-files_5000-framesPerFile.mat');
postures2 = postures;
Comparar_Posiciones
drawnow
k_2 = 2;
fprintf('k=%i',k_2)
for contando = 1:20
    for k_2 = 2:4
        fprintf('\b%i',k_2)
        for i = 1:90
            n_indx = C(k_2,i);
            if n_indx>i
                n_fila = postures2(:,n_indx);
                if n_indx == 90
                    postures_c = postures2(1:89);
                else
                    postures_a = postures2(:,1:n_indx-1);
                    postures_b = postures2(:,n_indx+1:end);
                    postures_c = [postures_a, postures_b];
                    postures2 = [postures_c(:,1:i), n_fila, postures_c(:,i+1:end)];
                end
            end
            Comparar_Posiciones
            drawnow
        end
    end
end