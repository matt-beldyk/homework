function [dist, heading] = findHeading(myLat, myLon, awayLat, awayLon, distPerLat, distPerLon)

    latDist = distPerLat * (awayLat - myLat);
    lonDist = distPerLon * (awayLon - myLon);
    dist = sqrt(latDist*latDist + lonDist*lonDist);
    heading = atan2(latDist, lonDist);
    
    
end