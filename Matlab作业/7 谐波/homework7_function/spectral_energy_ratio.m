function [signal_ratio, monophonic_ratio]  = spectral_energy_ratio(Y_spec, s)
    monophonic_ratio = [ ];
    signal_ratio = [ ];
    [~, locs1] = findpeaks(Y_spec, NPeaks=13, MinPeakDistance=100);
    locs1 = locs1(2:end);
    monophonic_ratio(1) = sum(Y_spec(locs1)) / (sum(Y_spec) - sum( Y_spec(locs1) ));         % harmonicity and irharmonicity ratio
    monophonic_ratio(2) = sum(Y_spec( locs1(7:end) )) / sum(Y_spec( locs1(1:6) ));              % high and low order harmonicity ratio
    monophonic_ratio(3) = sum(Y_spec(locs1(1:2:11))) / sum(Y_spec(locs1(2:2:12)));            % odd and even order harmonicity ratio
    monophonic_ratio = normalize(monophonic_ratio, 'scale');
    for i = 1 : size(s, 2)
        fram_spec = s(:, i);
        [~, locs2] = findpeaks(fram_spec, NPeaks=12);
        signal_ratio(1, i) = sum(fram_spec(locs2)) / (sum(Y_spec) - sum( fram_spec(locs2) ));
        signal_ratio(2, i) = sum(fram_spec( locs2(7:end) )) / sum(fram_spec( locs2(1:6) ));
        signal_ratio(3, i) = sum(fram_spec(locs2(1:2:11))) / sum(fram_spec(locs2(2:2:12)));
    end
    signal_ratio = normalize(signal_ratio, 'scale');
end

