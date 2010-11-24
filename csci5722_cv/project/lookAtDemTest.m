function [dem] = lookAtDemTest()
    lat = 40;
    lon = 105;
    dem = findSRTMData(lat, lon, 30);
    sizeDem = size(dem)
    
    %  Boulder
    [i,j] = latLon2demIndex(40.017624, 105.27966, sizeDem);
    dem(i,j) = 2000;
    
    % Longmont
    [i,j] = latLon2demIndex(40.1946, 105.10551, sizeDem);
    dem(i,j) = 2000;
    
    % Lyons
    [i,j] = latLon2demIndex(40.22607, 105.26688, sizeDem);
    dem(i,j) = 2000;
    
    surf(dem)
end