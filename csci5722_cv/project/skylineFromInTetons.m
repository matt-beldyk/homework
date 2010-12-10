function [angleCloud, cleanedCloud, pic] = skylineFromInTetons(targetH, targetW)

    startTime = cputime;
    lat = 43.83841404128973;
    lon = 110.61624276579096;
    elev = findElevation(lat, lon) + 100;
    
    dist2look = 0;
    if ~ (targetH && targetW)
        imgWidth = 1500;
        imgHeight = 600;
    else
        imgWidth = targetW;
        imgHeight = targetH;
    end
    decLev = 3;
    
    
     sprintf('elevation=%f', elev)
     
   % elev = 2064; % in meters
    %elev = 2164;
    maxClipAngle = 1;
    angleCloud = createOptimalSkyline(lat, lon, dist2look, imgWidth, imgHeight, decLev, elev, maxClipAngle);
    skyLineTime = cputime;
    
    %cleanedCloud = removeSpuriousTransparentMountains(  angleCloud);
    cleanedCloud = 0;
    cleanedTime = cputime;
    skyline = findSkylineFromPointCloud(angleCloud);
    %pic = turnDistsIntoImage(cleanedCloud); 
    %pic = turnDistsIntoImage(angleCloud);
    maxDist = max(max(angleCloud(:,:,3)));

    pic = angleCloud(:,:,3);
   % for i = 1:imgWidth
    %    pic(skyline(i),i) = 50000;
    %end
    pic = pic + not(pic) * 40000;
    
    pic = flipdim(pic,1);
    
    sprintf('maxDist=%f', maxDist)
    image(pic);
    colormap(hsv(floor(maxDist)));
    
    sprintf('SkylineCalc Time = %f, CleaningTime = %f', skyLineTime - startTime, cleanedTime - skyLineTime)
   % save('tetons_state_nov_30.mat');
end