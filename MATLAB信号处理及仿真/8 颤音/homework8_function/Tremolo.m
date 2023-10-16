function [Shim, ShdB] = Tremolo(time_amp_curve)
    Shim = 0;
    ShdB = 0;
    num_im = 0;
    num_dB = 0;
    for i = 1 : size(time_amp_curve, 2)-1
        amp_diff = abs(time_amp_curve(i) - time_amp_curve(i+1));
        amp_ratio = abs( 20*log10(time_amp_curve(i+1) / time_amp_curve(i)) );
        if ~isnan(amp_diff)
            Shim = Shim + amp_diff;
            num_im = num_im + 1;
        end

        if ~isnan(amp_ratio) && ~isinf(amp_ratio)
            ShdB = ShdB + amp_ratio;
            num_dB = num_dB + 1;
        end
    end

    Shim = (Shim/num_im) / (sum(time_amp_curve) / size(time_amp_curve, 2));
    ShdB = ShdB / num_dB;
end

