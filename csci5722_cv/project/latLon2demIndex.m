function [x,y] = latLon2demIndex(lat,lon, sizeDem)
    x = floor(sizeDem * (lat - floor(lat)));
    y = floor(sizeDem * (lon - floor(lon)));
end