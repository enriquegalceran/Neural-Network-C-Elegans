lista = ls('stateSequences_limpio/');
lista = lista(3:end,:);
lon_lista = length(lista);
for i = 1:lon_lista
    movefile(sprintf('stateSequences_limpio/%s', lista(i,:)),sprintf('stateSequences_limpio/datos/%i.mat',i))
end