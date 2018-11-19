% Comparar posiciones automáticas
clear
load('postures_90-centers_20-files_5000-framesPerFile.mat');
postures2 = postures;
Comparar_Posiciones
drawnow
k_2 = 2;
fprintf('k=%i',k_2)
fusion = [];
for contando = 1:88
    fprintf('\b%i',k_2)
    [valor_min, index_min(1)] = min(D(2,:));
    index_min(2) = C(2,index_min(1));

    nueva_postura = zeros(48,1);
    for p = 1:48
        nueva_postura(p) = postures2(p,index_min(1)) + postures2(p,index_min(2))/2;
    end
    postures2(:,index_min(1)) = nueva_postura;
    postures2 = [postures2(:,1:index_min(2)-1),postures2(:,index_min(2)+1:end)];
    fusion(:,contando) = index_min';
    Comparar_Posiciones
    drawnow
end
