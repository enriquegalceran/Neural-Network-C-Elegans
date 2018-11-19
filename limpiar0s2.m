lista = ls('stateSequences_limpio/datos');
lista = lista(3:end,:);
lon_lista = length(lista);
cambio = 0;
min_punto = 0;
for i = 1:lon_lista
    if find(lista(i,:)=='.') > min_punto
        min_punto = find(lista(i,:)=='.');
    end
end
%Después metemos el 0
for i = 1:lon_lista
    if find(lista(i,:)=='.') < min_punto
        old_filename = sprintf('stateSequences_limpio/datos/%s', strtrim(lista(i,:)));
        new_filename = sprintf('stateSequences_limpio/datos/0%s', strtrim(lista(i,:)));
        movefile(old_filename,new_filename)
        cambio = 1;
    end 
end

if cambio == 0
    fprintf('Sin cambios')
else
    fprintf('Cambiado')
end