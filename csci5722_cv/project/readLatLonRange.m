function [dem] = readLatLonRange(minLat, maxLat, minLon, maxLon)

    latSize = maxLat - minLat + 1
    lonSize = maxLon - minLon + 1
    
    demSize = 3601;
    dem = zeros(latSize*demSize, lonSize*demSize);
    
    for i = 0:latSize -1
        for j = 0:lonSize -1
            i
            j
            latStart = i * demSize + 1
            lonStart = j * demSize + 1
            latEnd = (i + 1) * demSize
            lonEnd = (j + 1) * demSize
            %latStart = (lat - minLat) * demSize + 1
            %lonStart = (lon - minLon) * demSize + 1
            %latEnd = (lat - minLat + 1) * demSize 
            %lonEnd = (lon - minLon + 1) * demSize 
            
            dem(latStart:latEnd, lonStart:lonEnd) = flipdim(flipdim(findSRTMData(minLat + i,minLon + j),2)', 2);
            %dem(latStart:latEnd, lonStart:lonEnd) = findSRTMData(minLat + i,minLon + j)';
        end
    end
end