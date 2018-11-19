function y = sigmoideDer_res(x)
% sigmoide
y = sigmoide(x)*(1-sigmoide(x));
% y = x*(1-x);

% ReLu
% if x >= 0
%     y = 1;
% else
%     y = 0.01;
% end

% ExpReLU
% if x < 0
%     y = 0.1*sigmoide(x);
% else
%     y = 1;
% end

%tanh
% y = 1-tanh(x)^2;
end