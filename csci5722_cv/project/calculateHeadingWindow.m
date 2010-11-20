function [minHeading, maxHeading, distance] = calculateHeadingWindow(i,j,camLat, camLon, cornerLat, cornerLon, latDist, lonDist, decimationLevel, sizeDem)
minHeading = inf;
maxHeading = -inf;
distCounter = 0;
jump = 0.5 * decimationLevel;
for l = [i-jump, i+jump]
    for m = [j-jump, j+jump]
        [mlat, mlon] = demIndex2LatLon(l,m, sizeDem, cornerLat, cornerLon);
        [dist, heading] = findHeading(camLat, camLon, mlat, mlon,latDist, lonDist);
        %sprintf('l =%f, m = %f, mlat = %f, mlon = %f', l, m, mlat, mlon)
        if heading < minHeading
            minHeading = heading;
        end
        if heading > maxHeading
            maxHeading = heading;
        end
        distCounter = distCounter + dist;
    end
end
distance = distCounter/4;
end