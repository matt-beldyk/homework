function [corre] = calculateDemCorrection(myLat, myLon, demLat, demLon, demSize, distPerLat, distPerLon)
    %ll = zeros(demSize,demSize, 2);
    %tmps = zeros(demSize);
    radiusEarth = 6371009; % meters
%     for i = 1:demSize
%         tmps(i) = (i -1)/demSize;
%     end
%     for i = 1:demSize
%         ll(i,:,1) = myLat + tmps;
%     end
%     for i = 1:demSize
%         ll(:,i,2) = myLon + tmps';
%     end
    corre = zeros(demSize, demSize);
    
    for i = 1:demSize
        if (mod(i,100) == 0)
            sprintf('DEM Correction %.2f%%', i/demSize)
        end
        for j = 1:demSize
            dist = findDist(myLat, myLon, demLat + i/demSize, demLon+j/demSize, distPerLat, distPerLon);
            sprintf('%f = findHeading(%f, %f, %f, %f, %f, %f)\n', dist, myLat, myLon, demLat + i/demSize, demLon+j/demSize, distPerLat, distPerLon);
            
            %dist
            corre(i,j) = radiusEarth - sqrt(radiusEarth*radiusEarth - dist*dist);
           %corre(i,j) = dist*dist/(2*radiusEarth);
        end
    end
end