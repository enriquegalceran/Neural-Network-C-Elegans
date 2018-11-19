load('wormAngles/135 CB4852 on food L_2011_03_28__12_44_32___6___3_features.mat')
X = worm.posture.skeleton.x;
Y = worm.posture.skeleton.y;
X(:,any(isnan(X), 1))=[];
len_x = length(X);
Y(:,any(isnan(Y), 1))=[];

% X2 = worm.path.coordinates.x;
% Y2 = worm.path.coordinates.y;
% max_x = max(X(:));
% max_y = max(Y(:));
% min_x = min(X(:));
% min_y = min(Y(:));
% min_g = min(min_x,min_y);
% max_g = max(max_x,max_y);


angulos = zeros(48,len_x);
for m = 1:len_x
    for i = 1:47
        p1 = [X(i+1,m)-X(i,m) Y(i+1,m)-Y(i,m)];
        angulos(i,m) = atan2(p1(2),p1(1));
    end
    
end
angulos(:,any(isnan(angulos), 1))=[];

if 0
    angulos = (angulos/pi+1)/2;
    len_x = length(angulos);
    max(angulos(:));
    min(angulos(:));
end

% for i = 1: len_x
%     plot(linspace(1,48,48),angulos(:,i)')
%     axis([0 48 -pi pi])
%     drawnow
% end

% for n = 1: len_x
%     media = mean(angulos(:,n));
%     angulos(:,n) = angulos(:,n) - media;
% end

% Rmat = vectorCor(angulos(:,1:200)', postures');
Rmat = vectorCor(postures', postures');

imagesc(Rmat), colorbar %, axis equal

%%%%% para representar los ángulos resultantes utilizar la primera parte de
%%%%% dibujar90plantillas.m

clear p1
clear p2
clear m
clear i