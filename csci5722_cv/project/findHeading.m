function [dist, heading] = findHeading(myLat, myLon, awayLat, awayLon, distPerLat, distPerLon)
    heading = arctan((awayLat - myLat)/(awayLon - myLon))
    
    % Yes, I'm cheating this is straight line distance from a cheaty
    % version of lat lon distance.  I'm assuming it doesn't matter on this
    % scale and wgs84 great circle distance is an *expensive* computation
    
    latDist = distPerLat * (awayLat - myLat)
    lonDist = distPerLon * (awayLon - myLon)
    dist = sqrt(latDist*latDist + lonDist*lonDist)
end