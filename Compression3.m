%Compression3 dibuja lo creado en Compression2.
N_max = 2000;
% clear StanDev
% clear ValMed
% clear NumTotal
salto = 10;
StanDev = zeros(3, N_max/salto);
ValMed = zeros(3, N_max/salto);
NumTotal = zeros(3, N_max/salto);
e = 1;
for kk = 1:salto:N_max
    vector = Matriz_Em(:,kk);
    vector_n = vector(vector ~= 0);
    StanDev(1,e) = std(vector_n);
    ValMed(1,e) = mean(vector_n);
    NumTotal(1,e) = length(vector_n);
    
    vector = Matriz_NN(:,kk);
    vector_n = vector(vector ~= 0);
    StanDev(2,e) = std(vector_n);
    ValMed(2,e) = mean(vector_n);
    NumTotal(2,e) = length(vector_n);
    
    vector = Matriz_Ma(:,kk);
    vector_n = vector(vector ~= 0);
    StanDev(3,e) = std(vector_n);
    ValMed(3,e) = mean(vector_n);
    NumTotal(3,e) = length(vector_n);
    
    e = e+1;
end

eje_x = 1:salto:N_max;
figure(1)
hold off
plot(eje_x, ValMed(1,:))
hold on
plot(eje_x, ValMed(2,:))
plot(eje_x, ValMed(3,:))
legend('Empirical', 'Neural', 'Markov')

figure(2)
errorbar(eje_x,ValMed,StanDev)
title('Em')