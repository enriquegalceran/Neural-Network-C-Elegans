% analisis de la tarta para una simulacion ya hecha
entradas_tiempo = 8;


files = dir('backup/NeuralNetworkV8b/');
dirFlags = [files.isdir];
subFolders = files(dirFlags);
lista_subs = zeros(size(files,1)-2,1);
for k = 3 : length(subFolders)
% 	fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
    lista_subs(k-2,1) = str2double(subFolders(k).name);
end
lon_sub = length(lista_subs);

% Syn1t = zeros(91,80,lon_sub);
% Syn2t = zeros(81,80,lon_sub);
% Syn3t = zeros(81,80,lon_sub);
% Syn4t = zeros(81,80,lon_sub);
% Syn5t = zeros(81,90,lon_sub);
% ahorat = zeros(lon_sub,20);
tarta_completa = zeros(lon_sub,3);


for j = 1:lon_sub
    nombre_sub = lista_subs(j);
    lista = ls(sprintf('backup/NeuralNetworkV8b/%s/',num2str(nombre_sub)));
    nombre_archivo_cargar = lista(end-1,:);
    load(sprintf('backup/NeuralNetworkV8b/%s/%s',num2str(nombre_sub),strtrim(nombre_archivo_cargar)))
    
%     matObj = matfile(sprintf('backup/NeuralNetworkV8b/%s/%s',num2str(nombre_sub),strtrim(nombre_archivo_cargar)));
%     who(matObj)
    
%     Syn1t(:,:,j) = Syn1;
%     Syn2t(:,:,j) = Syn2;
%     Syn3t(:,:,j) = Syn3;
%     Syn4t(:,:,j) = Syn4;
%     Syn5t(:,:,j) = Syn5;
%     ahorat(j,:) = datestr(ahora);
    
    nombre_gusano = nombre_sub;
    Comprobar;
    tarta_completa(j,:) = tarta/sum(tarta);
    
end



% Plot
figure(5)
c = {};
for l = 1:length(lista_subs)
    c(l) = {num2str(lista_subs(l))};
end
c = categorical(c);
subplot(2,1,1)
bar(c,tarta_completa)
box off
subplot(2,1,2)
bar(c,tarta_completa),set(gca,'yscale','log')
box off




