function res = evaluate(X,Syn1, Syn2, Syn3, Syn4, Syn5, BiasVector)
% Evaluates the Neural Network. Only suitable for testing. Doesn't export
% intermediate outputs.

% hay que poner de entrada en lugar de sólo X ->>>>>[X,BiasVector] !!!!
w1 = X*Syn1;
z1 = [arrayfun(@(x) sigmoide(x),w1),BiasVector];
w2 = z1*Syn2;
z2 = [arrayfun(@(x) sigmoide(x),w2),BiasVector];
w3 = z2*Syn3;
z3 = [arrayfun(@(x) sigmoide(x),w3),BiasVector];
w4 = z3*Syn4;
z4 = [arrayfun(@(x) sigmoide(x),w4),BiasVector];
w5 = z4*Syn5;
res = arrayfun(@(x) sigmoide_res(x),w5);

end