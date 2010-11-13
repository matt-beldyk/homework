function [img] = createOptimalSkyline(lat, lon, distanceToLook, width, height)
    latDist = vdist(lat, lon, lat+1, lon)
    lonDist = vdist(lat, lon, lat, lon +1)
    
    dem = findSRTMData(floor(lat), floor(lon), 3);
    surf(dem);
end