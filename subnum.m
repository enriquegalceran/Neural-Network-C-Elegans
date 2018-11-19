function num_str = subnum(x,m)
 % changes number to a string with preceding 0s to match the rest of the
 % numbers

num_str = num2str(x);
long = length(num_str);
long_m = length(num2str(m));
while long < long_m
    num_str = ['0', num_str];
    long = length(num_str);
end
end