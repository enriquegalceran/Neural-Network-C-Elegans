% animación del movimiento del gusano en función de la plantilla


load('stateSequences_limpio/datos/0001.mat')
load('backup/Red multiple 90% 90-100-90 V9 1-3.mat')
load('postures_90-centers_20-files_5000-framesPerFile.mat')

DataSet = stateSequence(:,1);
len_datos = length(DataSet);
figure(100)

for i = 1:len_datos
    [ske1X,ske1Y] = angle2skel(postures(:,DataSet(i)),0,1);
    plot(ske1X, ske1Y)
    title(sprintf('%i',i))
%     axis([min_x max_x min_y max_y])
    set(gca,'DataAspectRatio',[1 1 1])
    axis off
    pause(0.1)
end