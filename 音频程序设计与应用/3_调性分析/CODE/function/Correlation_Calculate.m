function Correlation = Correlation_Calculate(TonalityMatrix, CentroidEuclidianDistance)

    for i = 1: size(TonalityMatrix, 1)
        CorrelationArray = TonalityMatrix(i, :) * CentroidEuclidianDistance;
        Correlation(i) = sum(CorrelationArray);

    end

end

