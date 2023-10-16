function y = preprocessing(x, signal_type)
    x = x(:, 1);
    if signal_type == 'music'
        y = x;
    elseif signal_type == 'voice'
        for i=2:length(x)
            x(i) = x(i) - 0.97*x(i-1);   
        end
        y = x;
    end
end

