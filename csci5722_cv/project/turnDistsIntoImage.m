function [img] = turnDistsIntoImage(cloud)
    img = zeros(size(cloud));
    maxDist = max(max(cloud(:,:,3)));
    [w,h, tmp] = size(cloud)
    
    img(:,:,1) = flipdim(cloud(:,:,3)/maxDist, 1);
    img(:,:,2) = img(:,:,1);
    img(:,:,3) = img(:,:,1);
    sprintf('computed img from cloud')
    skyline = findSkylineFromPointCloud(cloud);
    sprintf('completed compution of skyline')
    green = [0,1,0];
    for i = 2:size(skyline)-1
        sprintf('marking up %i %i', i,skyline(i))
        if skyline(i)
            img(w-skyline(i),i,:) = green;
            img(w-skyline(i)-1, i,:) = green;
        end
    end
    
    
end