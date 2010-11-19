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
        
        
        [sizeDem, tmp] = size(dem);
        
        
        for i = 1:sizeDem
            if(mod(i,10) == 0)
                sprintf('Skyline Processing at %.2f%% Dem #%i of %i', 100*i/sizeDem, demCounter, (distanceToLook*2 +1)*(distanceToLook*2+1))
            end
            for j = 1:sizeDem
                
                minHeading = inf;
                maxHeading = -inf;
                distCounter = 0;
                jump = 0.5 * decimationLevel;
                for l = [i-jump, i+jump]
                    for m = [j-jump, j+jump]
                        [mlat, mlon] = demIndex2LatLon(l,m, sizeDem, cornerLat, cornerLon);
                        [dist, heading] = findHeading(lat, lon, mlat, mlon,latDist, lonDist);
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
                %sprintf('minHeading=%f, maxHeading=%f', minHeading, maxHeading)
                
                % sprintf('%d,%d = %3.4f,%3.4f', i,j, mlat, mlon);
                %[dist, heading] = findHeading(lat, lon, mlat, mlon,latDist, lonDist);
                % [lDist, leftHeading] = findHeading(leftLat, leftLon, mlat, mlon, latDist, lonDist);
                %[rDist, rightHeading] = findHeading(rightLat, rightLon, mlat, mlon, latDist, lonDist);
                
                % sprintf('Dist=%f Heading=%f\n', dist, heading)
                %  headings(i,j) = heading;
                %  dists(i,j) = dist;
                dropoff = calculateDistDropoff(distance);
                %sprintf('i=%d j=%d, dropoff=%.2f dist=%.2f', i,j,dropoff,dist)
                
                % mark up the skyline pic
                skyLinePoint = floor((heading + pi) * width/(2*pi));
                leftSkyLinePoint =  floor((minHeading + pi) * width/(2*pi));
                rightSkyLinePoint = floor((maxHeading + pi) * width/(2*pi));
                
                % oi vey, matlab indexing starts at 1
                if skyLinePoint ==0
                    skyLinePoint = 1;
                end
                if leftSkyLinePoint == 0
                    leftSkyLinePoint = 1;
                end
                if rightSkyLinePoint == 0
                    rightSkyLinePoint = 1;
                end
                
                
                pointElevation = floor(dem(i,j) + dropoff);
                
                % clip to my actual margins, don't run past
                if pointElevation > height
                    if maxElevation < pointElevation
                        maxElevation = pointElevation;
                    end
                    pointElevation = height -1;
                end
                
                
                % while k > 0 && ( not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist))
                if pointElevation> 0
                    for k = leftSkyLinePoint:rightSkyLinePoint
                        if not(img(pointElevation,k, 3)) || (img(pointElevation,k, 3) > distance)
                            %   for k = 1:dem(i,j)
                            %  if not(img(k,skyLinePoint, 3)) || (img(k,skyLinePoint, 3) > dist)
                            %sprintf('points should be %i wide', rightSkyLinePoint - leftSkyLinePoint +1)
                            
                            %  sprintf('pointElevation=%f, k=%f', pointElevation, k)
                            img(pointElevation,k ,:) = [lat, lon, distance]';
                        end
                        % end
                        % end
                        % k = k -1;
                    end
                end
            end
        end
        % image(img)
        % img(:,:,3)
        demCounter = demCounter +1;
    end
end
%img = removeSpuriousTransparentMountains(img);

%imshow(flipdim(cleanedImg(:,:,3)/max(max(cleanedImg(:,:,3))), 1))
%maxHeading = max(max(headings))
%minHeading = min(min(headings))
%maxDistance = max(max(dists))
maxElevation
%minElevation = min(min(dem))
end
