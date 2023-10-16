function [signal_TS, monophonic_TS] = TriStimulus(Y_spec, s)
    signal_TS = [ ];
    monophonic_TS = [ ];
    [~, locs1] = findpeaks(Y_spec, NPeaks=13, MinPeakDistance=100);
    locs1 = locs1(2:end);
    monophonic_TS(1) = Y_spec( locs1(1) );
    monophonic_TS(2) = sum(Y_spec( locs1(2 : 4) ));
    monophonic_TS(3) = sum(Y_spec( locs1(5 : 12) ));
    monophonic_TS = monophonic_TS / max(monophonic_TS);
    for i = 1 : size(s, 2)
        spec = s(:, i);
        [~, locs] = findpeaks(spec, NPeaks=12);
        signal_TS(1, i) = spec( locs(1) );
        signal_TS(2, i) = sum(spec( locs(2 : 4) ));
        signal_TS(3, i) = sum(spec( locs(5 : end) ));
    end
end

