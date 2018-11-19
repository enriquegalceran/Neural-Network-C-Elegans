load('postures_90-centers_20-files_5000-framesPerFile');
load('Posturas alternativas');
rotacion_reorganizado
lista = ls('stateSequences_limpio/datos_reordenados/');
lista = lista(3:end,:);
lon_lista = length(lista);
for i = 1:lon_lista
    %cargamos
    load(sprintf('stateSequences_limpio/datos_reordenados/%s', lista(i,:)));
    n_stateSequence = stateSequence;
    len_s = length(stateSequence);
    %sustituimos por los valores nuevos
    for j = 1:len_s
        n_stateSequence(j,1) = rotacion(2,stateSequence(j,1));
    end
    %guardamos
    stateSequence = n_stateSequence;
    save(sprintf('stateSequences_limpio/datos_reordenados/%s', lista(i,:)),'stateSequence');
end

