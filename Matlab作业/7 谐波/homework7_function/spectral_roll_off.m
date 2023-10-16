function signal_roll_off = spectral_roll_off(s, energy_percent, f)
    signal_roll_off = [ ];
    i = 1;
    ener_spec = s .^ 2;
    for i = 1 : size(s, 2)
        energy = 0;
        k = 1;
        total_ener = sum(ener_spec(:, i));
        while energy <= total_ener * energy_percent
            energy = energy + ener_spec(k, i);
            k = k + 1;
        end
        signal_roll_off(i) = f(k);
    end
end

