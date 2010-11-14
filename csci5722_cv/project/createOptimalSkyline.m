function [img] = createOptimalSkyline(lat, lon, distanceToLook, width, height)
    latDist = vdist(lat, lon, lat+1, lon)
    lonDist = vdist(lat, lon, lat, lon +1)
    
    dem = findSRTMData(floor(lat), floor(lon), 50);
    %surf(dem);
    maxLoc = max(max(dem))
    img = zeros(width, height)
    [sizeDem, tmp] = size(dem)
    for i = 1:sizeDem
        for j = 1:sizeDem
            [mlat, mlon] = demIndex2LatLon(i,j, sizeDem, lat, lon);
            sprintf('%d,%d = %3.4f,%3.4f', i,j, mlat, mlon)
            [dist, heading] = findHeading(lat, lon, mlat, mlon,latDist, lonDist);
            sprintf('Dist=%f Heading=%f\n', dist, heading)
        end
    end
end