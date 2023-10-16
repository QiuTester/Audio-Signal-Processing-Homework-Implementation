function time_amp_curve = time_domain_curve(f)
    time_amp_curve = [ ];
    for i = 1 : size(f, 2)
        time_amp_curve(i) = max(abs(f(:, i)));
    end
end

