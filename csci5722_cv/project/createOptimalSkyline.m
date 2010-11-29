function [img] = createOptimalSkyline(lat, lon, distanceToLook, width, height, decimationLevel, myElevation, maxClipAngle)
latDist = vdist(lat, lon, lat+1, lon)
lonDist = vdist(lat, lon, lat, lon +1)
tooCloseCutoff = 1000; % 15 KM

%if( ~decimationLevel)
%   decimationLevel = 50;
%end

img = zeros(height, width,3);

maxElevation = 0;
demCounter = 1;
minAngle = inf;
maxAngle = -inf;

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
                
                
                %sprintf('i=%d j=%d, dropoff=%.2f dist=%.2f', i,j,dropoff,dist)
                
               % [minHeading, maxHeading, distance] = calculateHeadingWindow(i,j,lat, lon, cornerLat, cornerLon, latDist, lonDist, decimationLevel, sizeDem);
               
               %removing the too wide rendering
                [mlat, mlon] = demIndex2LatLon(i,j, sizeDem, cornerLat, cornerLon);
                [ distance, minHeading] = findHeading(lat, lon, mlat, mlon, latDist, lonDist);
                maxHeading = minHeading;
                
                if distance > tooCloseCutoff
                    dropoff = calculateDistDropoff(distance);
                    
                    % mark up the skyline pic
                   leftSkyLinePoint =  heading2Index(minHeading, width);
                   rightSkyLinePoint = heading2Index(maxHeading, width);
                   
                  
                    [pointElevation, angle] = calculatePointElevation(distance, myElevation, floor(dem(i,j) + dropoff), height,maxClipAngle);
                    if angle > maxAngle
                        maxAngle = angle;
                    end
                    if angle <minAngle
                        minAngle = angle;
                    end
                    
                    if pointElevation> 0

                        for k = leftSkyLinePoint:rightSkyLinePoint
                            if not(img(pointElevation,k, 3)) || (img(pointElevation,k, 3) > distance)
                                
                                %sprintf('points should be %i wide', rightSkyLinePoint - leftSkyLinePoint +1)
                                
                                img(pointElevation,k ,:) = [lat, lon, distance]';
                            end
                            
                        end
                    end
                end
            end
        end
        
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
sprintf('minAngle=%f, maxAngle=%f', minAngle, maxAngle)
end


% takes a heading of -pi to pi and turns it into a horizontal index
% for the picute
function [dex] = heading2Index(heading, width)
    dex =  floor((heading + pi) * width/(2*pi));
    if dex==0
        dex =1;
    end
end
