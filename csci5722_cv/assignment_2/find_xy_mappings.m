function [mappings] = find_xy_mappings(old, next)
    
    for i = 1:size(old)
        min_dist = Inf;
        if mod(i,100) == 0
            i
        end
        for j = 1:size(next)
            distance = norm(old(i,:) - next(j,:));
            if(distance < min_dist)
                min_dist = distance;
                min_j = j;
            end
            mappings(i,:) = [old(i,1), old(i,2), next(min_j,1), next(min_j,2)];
        end
    end
