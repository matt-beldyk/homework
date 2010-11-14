function [dist, heading] = findHeading(myLat, myLon, awayLat, awayLon, distPerLat, distPerLon)

    latDist = distPerLat * (awayLat - myLat);
    lonDist = distPerLon * (awayLon - myLon);
    dist = sqrt(latDist*latDist + lonDist*lonDist);
    heading = atan2(latDist, lonDist);
    
    
    %if 0
    %if(awayLat == myLat && awayLon == myLon)
    %    dist = 0;
    %    heading = 0;
%     end
%     if latDist >=0
%             
%         dist = sqrt(latDist*latDist + lonDist*lonDist);
%         heading = asin(lonDist/dist);
%     end
%     if latDist < 0 
%         dist = sqrt(latDist*latDist + lonDist*lonDist);
%         heading = -asin(lonDist/dist) + pi;
%     end
%     end
    % Yes, I'm cheating this is straight line distance from a cheaty
    % version of lat lon distance.  I'm assuming it doesn't matter on this
    % scale and wgs84 great circle distance is an *expensive* computation
    

end