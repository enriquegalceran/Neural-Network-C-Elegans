function y = clip(x,n)

if x<-n
    y = -n;
elseif x>n
    y = n;
else
    y = x;
end

end