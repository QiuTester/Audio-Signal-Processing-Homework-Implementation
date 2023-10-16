function y = preprocessing(x)
    x = x(:, 1);
    for i=2:length(x)
        x(i) = x(i) - 0.97*x(i-1);   
    end
    y = x;
end

