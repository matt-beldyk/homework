function [diff] = calculateElevDropoff(myLat, myLon, farLat, farLon, distPerLat, distPerLon)
    radiusEarth = 6371009; % meters
    dist = findDist(myLat, myLon, farLat, farLon, distPerLat, distPerLon);
    diff = -(radiusEarth - sqrt(radiusEarth*radiusEarth - dist*dist));

end