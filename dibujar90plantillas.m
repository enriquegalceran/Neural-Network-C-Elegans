%Dibujar todas las plantillas
% la primera parte es para dibujar los resultados de continup_crear_angulos
% 
% figure
% for i = 1:len_x
%     [ske1X,ske1Y] = angle2skel(angulos(:,i),0,1);
%     plot(ske1X, ske1Y)
%     title(sprintf('%i',i))
%     axis equal
%     axis off
%     drawnow
% end



max_x = -999;
min_x = 999;
max_y = -999;
min_y = 999;

figure
for i = 1:90
    subplot(5,18,i)
    [ske1X,ske1Y] = angle2skel(postures2(:,i),0,1);
    plot(ske1X, ske1Y)
    title(sprintf('%i',i))
    axis equal
    axis off
    
    if max(ske1X) > max_x
        max_x = max(ske1X);
    elseif min(ske1X) <min_x
        min_x = min(ske1X);
    end
    if max(ske1Y) > max_y
        max_y = max(ske1Y);
    elseif min(ske1Y) <min_y
        min_y = min(ske1Y);
    end
    
    
end