function [updatedCloud] = removeSpuriousTransparentMountains(cloud)
    [w,h,tmp] = size(cloud)
    updatedCloud = cloud;
    for i = 1:h
        if (mod(i,50) == 0)
            sprintf('Removing Transparent Mountains: %.2f%%', 100*i/w)
        end
        j = w;
        loc = [0 0 0];
        while j > 0
            if( loc(3) && (loc(3) <= cloud(j,i,3)||~cloud(j,i,3)))
               % sprintf('updating %i,%i', i, j)
                updatedCloud(j,i,:) = loc;
            else
                loc = cloud(j,i,:);
            end
            j = j-1;
        end
    end
end