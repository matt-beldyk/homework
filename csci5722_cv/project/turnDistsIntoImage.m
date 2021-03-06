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
    for i = 1:size(skyline)
        %sprintf('marking up %i %i', i,skyline(i))
        if skyline(i) && skyline(i)<w
            % sprintf('%f-%f,%f', w, skyline(i), i);
            img(w-skyline(i),i,:) = green;
           % img(w-skyline(i)-1, i,:) = green;
        end
    end
    
    
end