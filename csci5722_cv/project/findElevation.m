function [elev] = findElevation(lat, lon)
     dem = findSRTMData(floor(lat), floor(lon), 0);
     [w,h] = size(dem);
     [li, lj] = latLon2demIndex(lat, lon, w);
     elev = dem(li,lj);
end