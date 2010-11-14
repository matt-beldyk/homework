

function [lat, lon] = demIndex2LatLon(x,y,sizeDem, lLat, lLon)
    lat = lLat + x/sizeDem;
    lon = lLon + y/sizeDem;
end