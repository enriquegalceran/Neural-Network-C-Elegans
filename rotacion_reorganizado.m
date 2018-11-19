% Encontrar la matriz de transición para posturas2
rotacion = zeros(2,90);
rotacion(1,:) =  linspace(1,90,90);

for asdfg = 1:90
    for gfdsa = 1:90
        if postures(:,asdfg) == postures2(:,gfdsa)
            rotacion(2,asdfg) = gfdsa;
        end
    end
end


