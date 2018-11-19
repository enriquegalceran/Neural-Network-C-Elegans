load('wormAngles/135 CB4852 on food R_2011_03_29__11_09___3___1_features.mat')
X = worm.posture.skeleton.x;
Y = worm.posture.skeleton.y;
X2 = worm.path.coordinates.x;
Y2 = worm.path.coordinates.y;
X(:,any(isnan(X), 1))=[];
Y(:,any(isnan(Y), 1))=[];
max_x = max(X(:));
max_y = max(Y(:));
min_x = min(X(:));
min_y = min(Y(:));
min_g = min(min_x,min_y);
max_g = max(max_x,max_y);
len_x = length(X);
figure (60)
plot(X(:),Y(:));
axis([min_x max_x min_y max_y])
set(gca,'DataAspectRatio',[1 1 1])
hold on
plot(X2(:),Y2(:))
hold off
drawnow
for j = 1:len_x
    figure (61)
    plot(X(:,j),Y(:,j))
    axis([min_x max_x min_y max_y])
    set(gca,'DataAspectRatio',[1 1 1])
    title(sprintf('%i/%i', j, len_x))
    drawnow
end



%esto es para sacar los relativos. El problema está en que tengo las
%posiciones en coordenadas, no en ángulos
% x = zeros(48,len_x);
% y = zeros(48,len_x);
% for m = 1:len_x
%     for n = 1:48
%         x(n,m) = X(n+1,m)-X(n,m);
%         y(n,m) = Y(n+1,m)-X(n,m);
%     end
% end