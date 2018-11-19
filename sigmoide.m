function y=sigmoide(x)
% sigmoide
y = 1/(1+exp(-x));

%ReLu
% y = max(0.01*x,x);

%ExpReLU
% if x>= 0
%     y = x;
% else
%     y = 0.1*(exp(x)-1);
% end

%tanh
% y = tanh(x);
end