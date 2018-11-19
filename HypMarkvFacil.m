%Hyper-markov facilitado para la nueva distribución de templates
clear
tol_m = 5;
desde = 51;
hasta = 53;
simulaciones = 200;
q_max = 1188;
tol = 1; % tolerancia es "relajación en la comprobación + 1"
tic
Supermatriz
T=zeros(90,90);
Acum = zeros(90,90);
fprintf('\n%s/%i',subnum(0,longitud_total),longitud_total);
a = repmat('\b',1,length(num2str(longitud_total))*2+1);
for x = 1:longitud_total
    fprintf(a);
    fprintf('%s/%i', subnum(x,longitud_total),longitud_total);
    [~, indx] = max(Valores_shuffled(x,1:90));
    [~, indy] = max(Valores_shuffled(x,91:180));
    T(indx,indy) = T(indx,indy) + 1;
end

for i = 1:90
    suma = sum(T(i,:));
    if suma ~= 0
        T(i,:)= T(i,:)/suma;
    end

    for j = 1:90
        if j == 1
            Acum(i,j) = T(i,j);
        else
            Acum(i,j) = T(i,j) + Acum(i,j-1);
        end
    end
end
toc


% e = 1;
tic
guardar_markov = zeros(1,q_max);
fprintf('\n%s/%i',subnum(0,q_max),q_max);
a = repmat('\b',1,length(num2str(q_max))*2+1);

for q = 1: q_max
    fprintf(a);
    fprintf('%s/%i', subnum(q,q_max),q_max);
    desde = q;
%     e = e+q-1;
    for w = q:q %q_max
        hasta = w;
        Supermatriz;
        bueno = 0;
        malo = 0;
        Prob = zeros(longitud_total, simulaciones);
        for simul = 1:simulaciones
            for x = 1:longitud_total
                [~, indx] = max(Valores_shuffled(x,1:90));
                azar = rand(1);
                for azar_c = 1:90
                    if azar <= Acum(indx,azar_c)
                        Prob(x,simul) = azar_c;
                        break
                    end
                end
                [~, indy] = max(Valores_shuffled(x,91:180));
                if indy <= azar_c + tol-1 && indy >= azar_c - tol+1
                    bueno = bueno +1;
                else
                    malo = malo +1;
                end
            end
        end
        relacion = bueno/(longitud_total*simulaciones)*100;
        guardar_markov(q) = relacion/100;

%         figure(33)
%         subplot(q_max,q_max,e)
%         tarta = [bueno, malo];
%         h = pie(tarta);
%         title(sprintf('%i - %i',q,w))
%         ax = gca;
%         ax.FontSize = 8;
%         e = e + 1;
        

    end
end
toc