function EuclidianDistance = circle_plot(x, y, CircleType)
    
    if strcmpi(CircleType, 'Fifths')
        r = 1; 
        Point = {'0', '7', '2', '9', '4', '11', '6', '1', '8', '3', '10', '5'};
        PointX = [0, 0.5, sqrt(3)/2, ...
                       1, sqrt(3)/2, 0.5, ...
                       0, -0.5, -sqrt(3)/2,...
                      -1, -sqrt(3)/2, -0.5];
        PointY = [1, sqrt(3)/2, 0.5, ...
                        0, -0.5, -sqrt(3)/2, ...
                       -1, -sqrt(3)/2, -0.5, ...
                        0, 0.5, sqrt(3)/2];

        figure(); rectangle('Position',[-r, -r, 2*r, 2*r], 'Curvature',[1,1], 'linewidth',1); axis equal; grid on; title('Fifths')
        text(PointX, PointY, Point, 'Color','b');

    elseif strcmpi(CircleType, 'MinorThirds')
        r = 1; 
        Point = {'0,4,8', '3,7,11', '2,6,10', '1,5,9'};
        PointX = [0, 1, 0, -1];
        PointY = [1, 0, -1, 0];
        
        figure(); rectangle('Position',[-r, -r, 2*r, 2*r], 'Curvature',[1,1], 'linewidth',1); axis equal; grid on; title('Minor Thirds')
        text(PointX, PointY, Point, 'Color','b');

    elseif strcmpi(CircleType, 'MajorThirds')
        r = 0.5;
        Point = {'0,3,6,9', '1,4,7,10', '2,5,8,11'};
        PointX = [0, sqrt(3)/4, -sqrt(3)/4];
        PointY = [0.5, -0.25, -0.25];
        
        figure(); rectangle('Position',[-r, -r, 2*r, 2*r], 'Curvature',[1,1], 'linewidth',1); axis equal; grid on; title('Major Thirds')
        text(PointX, PointY, Point, 'Color','b');

    end

    txt = ['\leftarrow Tonal Centroid: ', '(', num2str(x), ',', num2str(y), ')'];
    text(x, y, txt, 'Color','r')  

    EuclidianDistance = [];
    for i = 1:length(Point)
        ToneCoordinate = [PointX(i), PointY(i)];
        TonalCentroidCoordiante = [x, y];
        EuclidianDistance(i) = pdist([ToneCoordinate; TonalCentroidCoordiante]);
    end

    X = categorical(Point);
    X = reordercats(X, Point);
    figure(); bar(X, EuclidianDistance)

end