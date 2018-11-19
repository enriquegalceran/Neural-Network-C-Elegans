% Comparar Posiciones B (buscar el 3º más cercano)

% load('postures_90-centers_20-files_5000-framesPerFile.mat');
% postures2 = postures;

Comparar_Posiciones
% Comparar_Posiciones_a
drawnow
fprintf('p=00')
while 1
    for p = 1:89 %en horizontal que pareja(i,i+1) estamos mirando. Izqui
        fprintf('\b\b%i',subnum(p,12))
        Comparar_Posiciones
        drawnow
        cont = 999;
        for q = 2:90 %contador i
            for r = 2:90 %contado i+1
                if C(q,p) == C(r,p+1) && C(q,p) ~= p+1 && cont>=q+r
                    n_indx = C(q,p);
                    cont = q+r;
                    posibilidad = C(q,p);
                    dist = [D(q,p), D(r, p+1) A(p,p+1)];
                    break
                end       
            end
        end

        if cont ~= 999
            [~, pos_min] = min(dist(:));
            n_fila = postures2(:,n_indx);
            if pos_min == 3

                if n_indx == 90
                    postures_c = postures2(1:89);
                else
                    postures_a = postures2(:,1:n_indx-1);
                    postures_b = postures2(:,n_indx+1:end);
                    postures_c = [postures_a, postures_b];
                    postures2 = [postures_c(:,1:p), n_fila, postures_c(:,p+1:end)];
                end
            elseif pos_min == 1
                if p == 1
                    postures2 = [n_fila, postures2(:,2:end)];
                else
                    postures_a = postures2(:,1:n_indx-1);
                    postures_b = postures2(:,n_indx+1:end);
                    postures_c = [postures_a, postures_b];
                    postures2 = [postures_c(:,1:p-1), n_fila, postures_c(:,p:end)];
                end
            else
                if p == 89
                    postures2 = [postures2(:,1:end-1),n_fila];
                else
                    postures_a = postures2(:,1:n_indx-1);
                    postures_b = postures2(:,n_indx+1:end);
                    postures_c = [postures_a, postures_b];
                    postures2 = [postures_c(:,1:p+1), n_fila, postures_c(:,p+2:end)];
                end
            end
        end

    end
end