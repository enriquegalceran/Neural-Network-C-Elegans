% SuperMatriz Genera la variable Valores_shuffled a partir de los datos
% organizados (OrganData)en X-Y, juntándolos en una matriz muy grande y
% mezclando dicha matriz sin perder las diferentes variables

dir_datos = 'stateSequences_limpio/database_reordenados';
lista = ls(dir_datos);
lista = lista(3:end,:);
lon_lista = length(lista);
longitud_total = 0;

% cuantos se usarán
% desde = 1;
% hasta = 100;
% hasta = lon_lista;

% tic
% fprintf('Leyendo 0000')
for i = desde:hasta
%     fprintf('\b\b\b\b%s', subnum(i,1234))
    load(sprintf('%s/%s.mat', dir_datos, subnum(i,1234)),'Y')
    longitud_total = longitud_total + length(Y);
end


Valores = zeros(longitud_total,180);
% fprintf('\nGuardando 0000')
k = 1;
for i = desde:hasta
%     fprintf('\b\b\b\b%s', subnum(i,1234))
    load(sprintf('%s/%s', dir_datos, subnum(i,1234)))
    
    Valores(k:k+length(X)-1,1:90) = X;
    Valores(k:k+length(X)-1,91:180) = Y;
    k = k + length(X);
end
% toc
% tic
Valores_shuffled = Valores(randperm(size(Valores,1)),:);
X_mezclada = Valores(:,1:90);
Y_mezclada = Valores(:,91:180);
save(sprintf('stateSequences_limpio/todos mezclados %s-%s.mat',...
    subnum(desde,1234), subnum(hasta, 1234)),'X_mezclada', 'Y_mezclada')
% toc

