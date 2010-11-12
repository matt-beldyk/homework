function [dem] = readLatLonRange(minLat, maxLat, minLon, maxLon)

    latSize = maxLat - minLat +1;
    lonSize = maxLon - minLon +1;
    
    demSize = 3601;
    dem = zeros(latSize*demSize, lonSize*demSize);
    
    for lat = minLat:maxLat
        for lon = minLon: maxLon
            latStart = (lat - minLat) * demSize
            lonStart = (lon - minLon) * demSize
            latEnd = (lat - minLat + 1) * demSize
            lonEnd = (lon - minLon + 1) * demSize
            
            dem(latStart:latEnd, lonStart:lonEnd) = findSRTMData(lat,lon);
        end
    end
end