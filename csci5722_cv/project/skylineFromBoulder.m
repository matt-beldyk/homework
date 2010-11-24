function [angleCloud, cleanedCloud, pic] = skylineFromBoulder()
    angleCloud = createOptimalSkyline(40.01499, 105.27055, 1, 3000, 600, 7,1600);
    cleanedCloud = removeSpuriousTransparentMountains(  angleCloud);
    pic = turnDistsIntoImage(cleanedCloud); 
    %pic = turnDistsIntoImage(angleCloud);
    image(pic);
end