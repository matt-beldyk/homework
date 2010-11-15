function [dropoff] = calculateDistDropoff(dist)
    radiusEarth = 6371009; % meters

    dropoff = -(radiusEarth - sqrt(radiusEarth*radiusEarth - dist*dist));
end