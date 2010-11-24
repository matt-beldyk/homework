function [angleCloud, cleanedCloud, pic] = skylineFromLongmont()
    angleCloud = createOptimalSkyline(40.1946, 105.10551, 1, 3000, 600, 5,1600);
    cleanedCloud = removeSpuriousTransparentMountains(  angleCloud);
    pic = turnDistsIntoImage(cleanedCloud); 
    %pic = turnDistsIntoImage(angleCloud);
    image(pic);
end