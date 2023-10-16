function Delta = CompensationAppropriate(Generation)

    global N; global Fs; global CompensationCurve;

    PopulationResponse = freqz([Generation(2) Generation(1) 1], [1 Generation(1) Generation(2)], N, Fs);
    PopulationPhaseCurve = unwrap(angle(PopulationResponse))*180/pi;

    Diff = abs(CompensationCurve - PopulationPhaseCurve);
    Delta = sum(Diff);
    
end

