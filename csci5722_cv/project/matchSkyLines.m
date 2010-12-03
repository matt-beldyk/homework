function [offset] = matchSkyLines(photoSkyline, modelSkyline)

    %if not(photoAngleHint)
        % Math via http://www.bobatkins.com/photography/technical/field_of_view.html
   %     photoAngleHint = 35.6;
   % end

    minDiffVal = inf;
    minDiffOffset = 0;
    
    for i = 1:(size(modelSkyline)-size(photoSkyline))
        myDif = 0;
        for j = 1:size(photoSkyline)
            photoSkyline(j)
            if photoSkyline(j) > 0  %actuall a value
                myDif = myDif + abs(modelSkyline(i+j) - photoSkyline(j));
            end
        end
        sprintf('i=%d, diff=%f', i, myDif)
        
        if myDif < minDiffVal
            minDiffVal = myDif;
            minDiffOffset = i;
        end
    end
    
    sprintf('Offset = %d, diff = %f', minDiffOffset, minDiffVal)
    
    offset = minDiffOffset;
end