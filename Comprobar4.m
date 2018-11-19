% comprobar si funciona la red neuronal.
% redondeará y mirará si ha salido bien o no
bueno = 0;
malo = 0;
BiasVectorC = ones(1,1);
Err_acum = zeros(1,long_validacion);
Err_total = 0;
correcto = zeros(1, long_validacion);
falso_pos = zeros(1, long_validacion);
falso_neg = zeros(1, long_validacion);
for p = 1:long_validacion
    X_C = [Datos_validacion(p,1:90),BiasVectorC];
    Y_C = Datos_validacion(p,91:180);
    res_C = evaluate(X_C,Syn1, Syn2, Syn3, Syn4, Syn5, BiasVectorC);
    [max_num_Y, Y_indx] = max(Y_C(:));
    Rmat_comp = vectorCor(res_C,Rmat);
    [asdf, indx] = max(Rmat_comp(:));
    R_dif = vectorCor(res_C,Rmat(Y_indx,:));
    

    if indx == Y_indx
        bueno = bueno + 1;
        correcto(indx) = correcto(indx) + 1;
    else
        malo = malo + 1;
        falso_neg(Y_indx) = falso_neg(Y_indx) + 1;
        falso_pos(indx) = falso_pos(indx) + 1;
    end
    Err_acum(p) = 1-R_dif;
end
asdf = sum(Err_acum);
Err_total = sum(Err_acum)/long_validacion;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
bar_data = [correcto',falso_pos', falso_neg'];
bar(bar_data, 'stacked')
legend('Correcto', 'Falso positivo', 'Falso Negativo')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(23)
corr_sum = sum(correcto);
fals_p_sum = sum(falso_pos);
fals_n_sum = sum(falso_neg);
tarta = [bueno, malo];
h = pie(tarta);
legend(sprintf('B %i',bueno),sprintf('M %i',malo))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
graf_progreso_y = [graf_progreso_y(2:end,:);tarta];
semilogy(graf_progreso_x,graf_progreso_y)
ylim([min(graf_progreso_y(:))/1.5 max(graf_progreso_y(:))*1.5])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drawnow