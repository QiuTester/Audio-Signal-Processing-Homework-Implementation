function total_energy = energy_sum(energy_each_frame)
    total_energy = sum(energy_each_frame, 1);
    total_energy = total_energy / max(total_energy); 
end