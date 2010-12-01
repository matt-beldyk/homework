function [angleCloud, cleanedCloud, pic] = skylineFromInTetons()

    startTime = cputime;
    lat = 43.83841404128973;
    lon = 110.61624276579096;
    elev = findElevation(lat, lon) + 100;
    
    dist2look = 0;
    imgWidth = 1500;
    imgHeight = 600;
    decLev = 0;
    
    
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
    skyline
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
    save('tetons_state_nov_30.mat');
end