function [img] = createOptimalSkyline(lat, lon, distanceToLook, width, height, decimationLevel)
latDist = vdist(lat, lon, lat+1, lon)
lonDist = vdist(lat, lon, lat, lon +1)

%if( ~decimationLevel)
 %   decimationLevel = 50;
%end
cornerLat = floor(lat);
cornerLon = floor(lon);
img = zeros(height, width,3);

maxElevation = 0;
demCounter = 1;
for cornerLat = floor(lat) -distanceToLook:floor(lat)+distanceToLook
    for cornerLon = floor(lon) -distanceToLook :floor(lon) +distanceToLook
        dem = findSRTMData(cornerLat, cornerLon, decimationLevel);
        sprintf('DEM Loaded')
        %surf(dem);
        %maxLoc = max(max(dem));
        
        [sizeDem, tmp] = size(dem);
       % headings = zeros(sizeDem,sizeDem);
       % dists = zeros(sizeDem, sizeDem);
        
        
       % demCorrection = calculateDemCorrection(lat, lon, cornerLat, cornerLon, sizeDem, latDist, lonDist);
       % sprintf('height correction calculated')
       % dem = dem-demCorrection;
       % sprintf('DEM height Corrected')
        
        for i = 1:sizeDem
            if(mod(i,10) == 0)
                sprintf('Skyline Processing at %.2f%% Dem #%i of %i', 100*i/sizeDem, demCounter, (distanceToLook*2 +1)*(distanceToLook*2+1))
            end
            for j = 1:sizeDem
                [mlat, mlon] = demIndex2LatLon(i,j, sizeDem, cornerLat, cornerLon);
                % sprintf('%d,%d = %3.4f,%3.4f', i,j, mlat, mlon);
                [dist, heading] = findHeading(lat, lon, mlat, mlon,latDist, lonDist);
                % sprintf('Dist=%f Heading=%f\n', dist, heading)
              %  headings(i,j) = heading;
              %  dists(i,j) = dist;
                dropoff = calculateDistDropoff(dist);
                % mark up the skyline pic to the floor
                skyLinePoint = floor((heading + pi) * width/(2*pi));
                if skyLinePoint ==0
                    skyLinePoint = 1;
                end
                pointElevation = floor(dem(i,j) + dropoff);
                if pointElevation > height
                    if maxElevation < pointElevation
                        maxElevation = pointElevation;
                    end
                    pointElevation = height -1;
                end

               % while k > 0 && ( not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist))
                if pointElevation> 0 && ( not(img(pointElevation,skyLinePoint, 3)) || (img(pointElevation,skyLinePoint, 3) > dist))
                    %   for k = 1:dem(i,j)
                    %  if not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist)
                    img(pointElevation,skyLinePoint ,:) = [lat, lon, dist]';
                    % end
                    % end
                   % k = k -1;
                end
            end
        end
        % image(img)
        % img(:,:,3)
        demCounter = demCounter +1;
    end
end
imshow(flipdim(img(:,:,3)/max(max(img(:,:,3))), 1))
%maxHeading = max(max(headings))
%minHeading = min(min(headings))
%maxDistance = max(max(dists))
maxElevation 
%minElevation = min(min(dem))
end
