function CentroidEuclidianDistance = Tone_EuclidianDistance_Calculate(FifthsDistance, MinorThirdsDistance, MajorThirdsDistance)

    CentroidEuclidianDistance = zeros(12, 1);

    MinorThirdsCycle = [1, 4, 3, 2];
    MajorThirdsCycle = [1, 2, 3];

    for i = 1:12

        if mod(i, 2);  FifthsIndex = i; 
        else
            if (i-6<=0); FifthsIndex = i+6; else; FifthsIndex = i-6; end 
        end
        if ~mod(i, 4); MinorThirdsIndex = MinorThirdsCycle(end); else MinorThirdsIndex = MinorThirdsCycle(mod(i, 4)); end
        if ~mod(i, 3); MajorThirdsIndex = MajorThirdsCycle(end); else MajorThirdsIndex = MajorThirdsCycle(mod(i, 3)); end

        CentroidEuclidianDistance(i) = FifthsDistance(FifthsIndex) + MinorThirdsDistance(MinorThirdsIndex) + MajorThirdsDistance(MajorThirdsIndex);

    end

    CentroidEuclidianDistance = 1 ./ CentroidEuclidianDistance;

end

