function energy_curve = energy_curve(f, energy_each_frame)
    energy_curve = zeros(size(energy_each_frame, 1), 1);
    for frame = 1 : size(energy_each_frame, 1)
        [~,  locs]= max(energy_each_frame(frame, :));
        if locs
            energy_curve(frame) = f(locs);
        end
    end
    energy_curve = medfilt1(energy_curve, 15);
end