function signal_flux = spectral_flux(s)
    signal_flux = [ ];
    for i = 2 : size(s, 2)
        signal_flux(i) = sqrt(sum( abs((s(:, i) - s(:, i-1)) ).^2));
    end
end

