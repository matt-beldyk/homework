function [skyline, angleSkyline] = findSkylineFromPointCloud(cloud)
    [w,h, tmp] = size(cloud);
    skyline = zeros(w,1);
    angleSkyline = zeros(w,1);
    
    for i = 1:h
        j = w;
        while j > 1&& ~cloud(j,i,3) 
            j = j-1;
        end
        
        angle = pi *(j/h) - pi/2;
        skyline(i) = j;
        angleSkyline(i) = angle;


    end
end