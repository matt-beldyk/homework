function [skyline] = findSkylineFromPointCloud(cloud)
    [w,h, tmp] = size(cloud);
    skyline = zeros(w,1);
    for i = 1:h
        j = w;
        while j > 1&& ~cloud(j,i,3) 
            j = j-1;
        end
        skyline(i) = j;


    end
end