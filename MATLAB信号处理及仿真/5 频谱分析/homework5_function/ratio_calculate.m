function energy_ratio = ratio_calculate(f, total_energy)
    f1 = f >= 5.0e+01 & f <= 1.0e+03;
    lower_energy = sum(total_energy(f1));
    f2 = f >= 1.0e+03 & f <= 5.0e+03;
    higher_energy = sum(total_energy(f2));
    energy_ratio = higher_energy / lower_energy;
end