
% This is where the magic happens, basically, I take my 3-d matrix of
% convolutions and do a search for all the local minimas and maximas.  I
% look at the various planes on each size to see if point N is bigger or
% smaller than both, and iterate over all three dimensions.  Truely, if I
% were aiming for speed, it might make sense to do some benchmarks and
% lower the number of comparisons I'm doing.  But the real slowness in the
% program isn't this function and it's likely that Matlab is doing a fine
% job of loading in memory and that memory load is the big hit here
function [features] = find_features(conv_mat, threshold)
features = zeros(size(conv_mat));
[w,h,n] = size(features);
for x = 2:w-1
    %  x
    for y = 2:h-1
        for z = 2:n-1
            
            if(conv_mat(x,y,z) > threshold) || (conv_mat(x,y,z) < -threshold)
                
                %top bottom
                is_max = (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1, z-1:z+1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y+1, z-1:z+1))));
                is_min = (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1, z-1:z+1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y+1, z-1:z+1))));
                
                %left right
                is_max = is_max && (conv_mat(x,y,z) > max(max(conv_mat(x-1, y-1:y+1, z-1:z+1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x+1, y-1:y+1, z-1:z+1))));
                is_min = is_min && (conv_mat(x,y,z) < min(min(conv_mat(x-1, y-1:y+1, z-1:z+1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x+1, y-1:y+1, z-1:z+1))));
                
                %back front
                is_max = is_max && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1:y+1, z-1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1:y+1, z+1))));
                is_min = is_min && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1:y+1, z-1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1:y+1, z+1))));
                
                if is_max
                    features(x,y,z) = 1;
                end
                if is_min
                    features(x,y,z) = -1;
                end
            end
        end
    end
end

end
