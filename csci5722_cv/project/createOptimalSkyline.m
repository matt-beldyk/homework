function [img] = createOptimalSkyline(lat, lon, distanceToLook, width, height)
    latDist = vdist(lat, lon, lat+1, lon)
    lonDist = vdist(lat, lon, lat, lon +1)
   
    cornerLat = floor(lat);
    cornerLon = floor(lon);
    dem = findSRTMData(cornerLat, cornerLon, 50);
   
    %surf(dem);
    maxLoc = max(max(dem));
    img = zeros(height, width,3);
    [sizeDem, tmp] = size(dem);
    headings = zeros(sizeDem,sizeDem);
    dists = zeros(sizeDem, sizeDem);
    for i = 1:sizeDem
        for j = 1:sizeDem
            [mlat, mlon] = demIndex2LatLon(i,j, sizeDem, cornerLat, cornerLon);
           % sprintf('%d,%d = %3.4f,%3.4f', i,j, mlat, mlon);
            [dist, heading] = findHeading(lat, lon, mlat, mlon,latDist, lonDist);
           % sprintf('Dist=%f Heading=%f\n', dist, heading)
            headings(i,j) = heading;
            dists(i,j) = dist;
            
            % mark up the skyline pic to the floor
            skyLinePoint = floor((heading + pi) * width/(2*pi));
            k = dem(i,j);
            while k > 0 && ( not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist))
             %   for k = 1:dem(i,j)
                  %  if not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist)
                        img(k,skyLinePoint ,:) = [lat, lon, dist]';
                   % end
               % end
               k = k -1;
            end
        end
    end
   % image(img)
  % img(:,:,3)
  imshow(flipdim(img(:,:,3)/max(max(dists)), 1))
    maxHeading = max(max(headings))
    minHeading = min(min(headings))
    maxDistance = max(max(dists))
    maxElevation = max(max(dem))
end