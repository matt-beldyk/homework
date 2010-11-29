function [angleCloud, cleanedCloud, pic] = skylineFromInTetons()

    startTime = cputime;
    lat = 43.83841404128973;
    lon = 110.61624276579096;
    dist2look = 0;
    imgWidth = 1500;
    imgHeight = 600;
    decLev = 0;
    elev = 2064; % in meters
    maxClipAngle = 1;
    angleCloud = createOptimalSkyline(lat, lon, dist2look, imgWidth, imgHeight, decLev, elev, maxClipAngle);
    skyLineTime = cputime;
    
    cleanedCloud = removeSpuriousTransparentMountains(  angleCloud);
    cleanedTime = cputime;
    
    %pic = turnDistsIntoImage(cleanedCloud); 
    pic = turnDistsIntoImage(angleCloud);
    image(pic);
    
    sprintf('SkylineCalc Time = %f, CleaningTime = %f', skyLineTime - startTime, cleanedTime - skyLineTime)
end