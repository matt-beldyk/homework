function [] = testDriver()

    % Boulder, CO
    boulderLat = 40.01944; boulderLon = 105.29278;
    
    % Lyons, CO
    lyonsLat =  40.22371; lyonsLon =  105.26276;
    
    % Longmont, CO
    longmontLat= 40.18071; longmontLon =  105.11066;
    
    % Rabbit Mountain
    rabLat =  40.23053; rabLon =  105.19958;
    
    
    dem = findSRTMData(floor(boulderLat), floor(boulderLon), 10);
  %  surf(dem);
    
    [w,h] = size(dem);
    [x,y] = latLon2demIndex(lyonsLat, lyonsLon, w);
    dem(x,y) = 2000;
    
    [x,y] = latLon2demIndex(boulderLat, boulderLon, w);
    dem(x,y) = 2000;
    sprintf('Boulder x=%d, y=%d\n', x,y)
    sprintf('Boulder bLat=%d, bLon=%d\n', boulderLat, boulderLon)
    [lat,lon] = demIndex2LatLon(x,y,w,floor(boulderLat), floor(boulderLon))
    sprintf('Boulder lat=%d, lon=%d\n', lat, lon)
    
    
    [x,y] = latLon2demIndex(longmontLat, longmontLon, w);
    dem(x,y) = 2000;
    
    [x,y] = latLon2demIndex(rabLat, rabLon, w);
    dem(x,y) = 2000;
    
    surf(dem)
end
