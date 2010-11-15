function [dist] = findDist(myLat, myLon, awayLat, awayLon, distPerLat, distPerLon)

    latDist = distPerLat * (awayLat - myLat);
    lonDist = distPerLon * (awayLon - myLon);
    dist = sqrt(latDist*latDist + lonDist*lonDist);

    
    
end