% Organizar base de datos transforma una secuencia de templates en nuestras variables X-Y para que aprenda la red
directorio_dat = 'stateSequences_limpio/datos_reordenados/';
directorio_guar = 'stateSequences_limpio/database_reordenados/';
lista_dat = ls(directorio_dat);
lista_dat = lista_dat(3:end,:);
lon_lista = length(lista_dat);

tiempo = 8;

 fprintf('escribiendo el 0000 de %i', lon_lista);
for i = 1:lon_lista
    load([directorio_dat, lista_dat(i,:)]);
    long_data = length(stateSequence);
    
    [X, Y, datosN] = rotar_ini(stateSequence, long_data-tiempo, tiempo);
    filename = [directorio_guar, lista_dat(i,:)];
    save(filename, 'X','Y')
    i_str = subnum(i,lon_lista);
    fprintf('\b\b\b\b\b\b\b\b\b\b\b\b%s de %i', i_str, lon_lista)    
end

fprintf('\n\nfin\n')